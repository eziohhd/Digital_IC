////////////////////////////////////////////////////////////////
// input ports
// clk             -clock signal
// arstn           -reset the system (asynchronous reset, active low)
// start           -start IFFT calculation

// output ports
// start_check     -to testbench, to be activated when the first effective result is generated at the output of the IFFT papeline (active high)
// bank_addr       -to select test case (10 bits)
// twiddle_sel1    -control signal, to select twiddle factors for the 1st layer in the 64IFFT pipeline
// twiddle_sel2    -control signal, to select twiddle factors for the 2nd layer in the 64IFFT pipeline
// twiddle_sel3    -control signal, to select twiddle factors for the 3rd layer in the 64IFFT pipeline
// twiddle_sel4    -control signal, to select twiddle factors for the 4th layer in the 64IFFT pipeline
// twiddle_sel5    -control signal, to select twiddle factors for the 5th layer in the 64IFFT pipeline
// pattern2        -control signal, to contol the communator at the 2nd layer in the 64IFFT pipeline
// pattern3        -control signal, to contol the communator at the 3rd layer in the 64IFFT pipeline
// pattern4        -control signal, to contol the communator at the 4th layer in the 64IFFT pipeline
// pattern5        -control signal, to contol the communator at the 5th layer in the 64IFFT pipeline
// pattern6        -control signal, to contol the communator at the 6th layer in the 64IFFT pipeline
// cnt_cal         -to counter 32 cycles within each test case (5 bits)
////////////////////////////////////////////////////////////////
module ifft_ctrl
    (
        input clk,
        input arstn,
        input start,
        output start_check,
        output reg [9:0] bank_addr,
        output reg [4:0] twiddle_sel1,
        output reg [4:0] twiddle_sel2,
        output reg [4:0] twiddle_sel3,
        output reg [4:0] twiddle_sel4,
        output reg [4:0] twiddle_sel5,
        output reg pattern2,
        output reg pattern3,
        output reg pattern4,
        output reg pattern5,
        output reg pattern6,
        output reg [4:0] cnt_cal
    );
    
    localparam NO_TEST_CASE = 10'd1000;

//define cycles need to wait to get the first result
    localparam IFFT_LATENCY = 5'd31;

//state define   
    localparam IDLE = 2'd0;
    localparam INIT = 2'd1;
    localparam CAL = 2'd2;
    localparam DONE = 2'd3;

// port definition
// fill in your code here
    reg [1:0] current_state;
    reg [1:0] next_state;
    
// update current states (sequential logic, reset with arstn)
// fill in your code here
    always @(posedge clk or negedge arstn) begin
    if (!arstn)
        current_state <= IDLE;
    else
        current_state <= next_state;
    end

// next state generation (combinational logic)
// fill in your code here
   always @(*) begin
      // Default assignment for next state
      next_state = current_state;
      case (current_state)
          IDLE: if (start) 
                    next_state = INIT;
                else
                    next_state = IDLE;
          INIT: if (cnt_cal == IFFT_LATENCY-1) 
                    next_state = CAL;
                else
                    next_state = INIT;
          CAL: if (bank_addr == NO_TEST_CASE) 
                    next_state = DONE;
               else
                    next_state = CAL;
          DONE: next_state = IDLE;
          default: next_state = IDLE;
      endcase
    end

// output generation (combinational logic)
// fill in your code here
always @(*) twiddle_sel1 = cnt_cal;
always @(posedge clk or negedge arstn) begin
    if (!arstn) twiddle_sel2 <= 0;
    else if (current_state == INIT || current_state == CAL ) twiddle_sel2 <= twiddle_sel2 + 2;
    else twiddle_sel2 <= 0;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) twiddle_sel3 <= 0;
    else if (current_state == INIT || current_state == CAL ) twiddle_sel3 <= twiddle_sel3 + 4;
    else twiddle_sel3 <= 0;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) twiddle_sel4 <= 0;
    else if (current_state == INIT || current_state == CAL ) twiddle_sel4 <= twiddle_sel4 + 8;
    else twiddle_sel4 <= 0;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) twiddle_sel5 <= 0;
    else if (current_state == INIT || current_state == CAL ) twiddle_sel5 <= twiddle_sel5 + 16;
    else twiddle_sel5 <= 0;
end

always @(posedge clk or negedge arstn) begin
    if (!arstn) pattern2 <= 0;
    else if ((current_state == INIT || current_state == CAL) &&pattern6&&pattern5&&pattern4&&pattern3 ) pattern2 <= ~pattern2;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) pattern3 <= 0;
    else if ((current_state == INIT || current_state == CAL) &&pattern6&&pattern5&&pattern4  ) pattern3 <= ~pattern3;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) pattern4 <= 0;
    else if ((current_state == INIT || current_state == CAL) &&pattern6&&pattern5  ) pattern4 <= ~pattern4;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) pattern5 <= 0;
    else if ((current_state == INIT || current_state == CAL) &&pattern6  ) pattern5 <= ~pattern5;
end
always @(posedge clk or negedge arstn) begin
    if (!arstn) pattern6 <= 0;
    else if (current_state == INIT || current_state == CAL ) pattern6 <= ~pattern6;
end
// cnt_cal, 5-bit counter (sequential logic, reset with arstn)
// to counter 32 cycles within each test case
always @(posedge clk or negedge arstn) begin
    if (!arstn) cnt_cal <= 0;
    else if (current_state == INIT || current_state == CAL ) cnt_cal <= cnt_cal + 1;
    else cnt_cal <= 0;
end
// bank_addr, 10-bit counter (sequential logic, reset with arstn)
// to select test case
always @(posedge clk or negedge arstn) begin
     if (!arstn) bank_addr <= 0;
     else if (bank_addr < 10'd1000 && cnt_cal== IFFT_LATENCY) bank_addr <= bank_addr + 1;
end
assign start_check = current_state == CAL;
endmodule
