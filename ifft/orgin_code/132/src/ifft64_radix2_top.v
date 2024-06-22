////////////////////////////////////////////////////////////////
// input ports
// clk               -clock signal
// arstn             -asynchronous reset, to reset the system (active low)
// start             -start IFFT calculation
// ifft_in0_re       -from testbench, test cases for the of the 1st input (real part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in0_im       -from testbench, test cases for the of the 2nd input (imag part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in1_re       -from testbench, test cases for the of the 1st input (real part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in1_im       -from testbench, test cases for the of the 2nd input (imag part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// twiddle_lut_re    -from testbench, twiddle factors needed during 64IFFT calculation (32 elements * 16 bits = 512 bits)
// twiddle_lut_im    -from testbench, twiddle factors needed during 64IFFT calculation (32 elements * 16 bits = 512 bits)

// output ports
// ifft_out0_re      -to testbench, the 1st output (real part) of the IFFT pipeline (1 elements * 16 bits = 16 bits)
// ifft_out0_im      -to testbench, the 1st output (imag part) of the IFFT pipeline (1 elements * 16 bits = 16 bits) 
// ifft_out1_re      -to testbench, the 2nd output (real part) of the IFFT pipeline (1 elements * 16 bits = 16 bits) 
// ifft_out1_im      -to testbench, the 2nd output (imag part) of the IFFT pipeline (1 elements * 16 bits = 16 bits) 
// start_check       -to testbench, to be activated when the first effective result is generated at the output of the IFFT papeline (active high)
// bank_addr         -to testbench, to select test case (10 bits)
////////////////////////////////////////////////////////////////
module ifft64_radix2_top
    (   
        input clk, 
        input arstn,
        input start,
        input [511:0] ifft_in0_re,
        input [511:0] ifft_in0_im,
        input [511:0] ifft_in1_re,
        input [511:0] ifft_in1_im,
        input [511:0] twiddle_lut_re,
        input [511:0] twiddle_lut_im,
        output [15:0] ifft_out0_re,
        output [15:0] ifft_out0_im,
        output [15:0] ifft_out1_re,
        output [15:0] ifft_out1_im,
        output start_check,
        output [9:0] bank_addr
    );
    
// wire definition
// fill in your code here
wire                start_check;
wire   [4:0]        twiddle_sel1;
wire   [4:0]        twiddle_sel2;
wire   [4:0]        twiddle_sel3;
wire   [4:0]        twiddle_sel4;
wire   [4:0]        twiddle_sel5;
wire                pattern2;
wire                pattern3;
wire                pattern4;
wire                pattern5;
wire                pattern6;
wire   [4:0]        cnt_cal;
// instantiate your ifft_ctrl.v and ifft64_radix2.v here
// fill in your code here


// ifft_ctrl.v
// fill in your code here
ifft_ctrl 
u_ifft_ctrl
(
    .clk(clk),
    .arstn(arstn),
    .start(start),
    .start_check(start_check),
    .bank_addr(bank_addr),
    .twiddle_sel1(twiddle_sel1),
    .twiddle_sel2(twiddle_sel2),
    .twiddle_sel3(twiddle_sel3),
    .twiddle_sel4(twiddle_sel4),
    .twiddle_sel5(twiddle_sel5),
    .pattern2(pattern2),
    .pattern3(pattern3),
    .pattern4(pattern4),
    .pattern5(pattern5),
    .pattern6(pattern6),
    .cnt_cal(cnt_cal)
);
    
// ifft64_radix2.v
// fill in your code here
ifft64_radix2 
u_ifft64_radix2
(
 .clk(clk),                   
 .arstn(arstn),                 
 .ifft_in0_re(ifft_in0_re),   
 .ifft_in0_im(ifft_in0_im),   
 .ifft_in1_re(ifft_in1_re),   
 .ifft_in1_im(ifft_in1_im),   
 .twiddle_lut_re(twiddle_lut_re),
 .twiddle_lut_im(twiddle_lut_im),    
 .twiddle_sel1(twiddle_sel1),    
 .twiddle_sel2(twiddle_sel2),    
 .twiddle_sel3(twiddle_sel3),    
 .twiddle_sel4(twiddle_sel4),    
 .twiddle_sel5(twiddle_sel5),    
 .pattern2(pattern2),              
 .pattern3(pattern3),              
 .pattern4(pattern4),              
 .pattern5(pattern5),              
 .pattern6(pattern6),              
 .cnt_cal(cnt_cal),          
 .ifft_out0_re(ifft_out0_re),  
 .ifft_out0_im(ifft_out0_im),  
 .ifft_out1_re(ifft_out1_re),  
 .ifft_out1_im(ifft_out1_im)   
);

endmodule
