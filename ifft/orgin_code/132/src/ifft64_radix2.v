////////////////////////////////////////////////////////////////
// input ports
// clk               -clock signal
// arstn             -reset the system (asynchronous reset, active low)
// ifft_in0_re       -from testbench, test cases for the of the 1st input (real part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in0_im       -from testbench, test cases for the of the 2nd input (imag part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in1_re       -from testbench, test cases for the of the 1st input (real part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// ifft_in1_im       -from testbench, test cases for the of the 2nd input (imag part) of the IFFT pipeline (32 elements * 16 bits = 512 bits)
// twiddle_lut_re    -from testbench, twiddle factors needed during 64IFFT calculation (32 elements * 16 bits = 512 bits)
// twiddle_lut_im    -from testbench, twiddle factors needed during 64IFFT calculation (32 elements * 16 bits = 512 bits)
// twiddle_sel1      -control signal, to select twiddle factors for the 1st layer in the 64IFFT pipeline
// twiddle_sel2      -control signal, to select twiddle factors for the 2nd layer in the 64IFFT pipeline
// twiddle_sel3      -control signal, to select twiddle factors for the 3rd layer in the 64IFFT pipeline
// twiddle_sel4      -control signal, to select twiddle factors for the 4th layer in the 64IFFT pipeline
// twiddle_sel5      -control signal, to select twiddle factors for the 5th layer in the 64IFFT pipeline
// pattern2          -control signal, to contol the communator at the 2nd layer in the 64IFFT pipeline
// pattern3          -control signal, to contol the communator at the 3rd layer in the 64IFFT pipeline
// pattern4          -control signal, to contol the communator at the 4th layer in the 64IFFT pipeline
// pattern5          -control signal, to contol the communator at the 5th layer in the 64IFFT pipeline
// pattern6          -control signal, to contol the communator at the 6th layer in the 64IFFT pipeline
// cnt_cal           -to counter 32 cycles within each test case (5 bits)

// output ports
// ifft_out0_re      -to testbench, the 1st output (real part) of the IFFT pipeline (16 bits)
// ifft_out0_im      -to testbench, the 1st output (imag part) of the IFFT pipeline (16 bits) 
// ifft_out1_re      -to testbench, the 2nd output (real part) of the IFFT pipeline (16 bits) 
// ifft_out1_im      -to testbench, the 2nd output (imag part) of the IFFT pipeline (16 bits) 
////////////////////////////////////////////////////////////////
module ifft64_radix2
    (
        //from tb
        input clk, 
        input arstn,
        input [511:0] ifft_in0_re,
        input [511:0] ifft_in0_im,
        input [511:0] ifft_in1_re,
        input [511:0] ifft_in1_im,
        input [511:0] twiddle_lut_re,
        input [511:0] twiddle_lut_im,
        //from ctrl
        input [4:0] twiddle_sel1,
        input [4:0] twiddle_sel2,
        input [4:0] twiddle_sel3,
        input [4:0] twiddle_sel4,
        input [4:0] twiddle_sel5,
        input pattern2,
        input pattern3,
        input pattern4,
        input pattern5,
        input pattern6,
        input [4:0] cnt_cal,
        //outputs
        output [15:0] ifft_out0_re,
        output [15:0] ifft_out0_im,
        output [15:0] ifft_out1_re,
        output [15:0] ifft_out1_im
    );

// wire definition
// fill in your code here
genvar i;
wire [15:0]      bf1_in_0_re; 
wire [15:0]      bf1_in_1_re;
wire [15:0]      bf1_in_0_im;
wire [15:0]      bf1_in_1_im;

wire [15:0]      bf1_out_0_re; 
wire [15:0]      bf1_out_1_re;
wire [15:0]      bf1_out_0_im;
wire [15:0]      bf1_out_1_im;

reg [15:0]       bf1_out_1_re_d1;
reg [15:0]       bf1_out_1_im_d1;
reg [15:0]       bf1_out_1_re_d2;
reg [15:0]       bf1_out_1_im_d2;
reg [15:0]       bf1_out_1_re_d3;
reg [15:0]       bf1_out_1_im_d3;
reg [15:0]       bf1_out_1_re_d4;
reg [15:0]       bf1_out_1_im_d4;
reg [15:0]       bf1_out_1_re_d5;
reg [15:0]       bf1_out_1_im_d5;
reg [15:0]       bf1_out_1_re_d6;
reg [15:0]       bf1_out_1_im_d6;
reg [15:0]       bf1_out_1_re_d7;
reg [15:0]       bf1_out_1_im_d7;
reg [15:0]       bf1_out_1_re_d8;
reg [15:0]       bf1_out_1_im_d8;
reg [15:0]       bf1_out_1_re_d9;
reg [15:0]       bf1_out_1_im_d9;
reg [15:0]       bf1_out_1_re_d10;
reg [15:0]       bf1_out_1_im_d10;
reg [15:0]       bf1_out_1_re_d11;
reg [15:0]       bf1_out_1_im_d11;
reg [15:0]       bf1_out_1_re_d12;
reg [15:0]       bf1_out_1_im_d12;
reg [15:0]       bf1_out_1_re_d13;
reg [15:0]       bf1_out_1_im_d13;
reg [15:0]       bf1_out_1_re_d14;
reg [15:0]       bf1_out_1_im_d14;
reg [15:0]       bf1_out_1_re_d15;
reg [15:0]       bf1_out_1_im_d15;
reg [15:0]       bf1_out_1_re_d16;
reg [15:0]       bf1_out_1_im_d16;

wire [15:0]      cm2_in_0_re; 
wire [15:0]      cm2_in_1_re;
wire [15:0]      cm2_in_0_im;
wire [15:0]      cm2_in_1_im;

wire [15:0]      cm2_out_0_re; 
wire [15:0]      cm2_out_1_re;
wire [15:0]      cm2_out_0_im;
wire [15:0]      cm2_out_1_im;

reg [15:0]       cm2_out_0_re_d1;
reg [15:0]       cm2_out_0_im_d1;
reg [15:0]       cm2_out_0_re_d2;
reg [15:0]       cm2_out_0_im_d2;
reg [15:0]       cm2_out_0_re_d3;
reg [15:0]       cm2_out_0_im_d3;
reg [15:0]       cm2_out_0_re_d4;
reg [15:0]       cm2_out_0_im_d4;
reg [15:0]       cm2_out_0_re_d5;
reg [15:0]       cm2_out_0_im_d5;
reg [15:0]       cm2_out_0_re_d6;
reg [15:0]       cm2_out_0_im_d6;
reg [15:0]       cm2_out_0_re_d7;
reg [15:0]       cm2_out_0_im_d7;
reg [15:0]       cm2_out_0_re_d8;
reg [15:0]       cm2_out_0_im_d8;
reg [15:0]       cm2_out_0_re_d9;
reg [15:0]       cm2_out_0_im_d9;
reg [15:0]       cm2_out_0_re_d10;
reg [15:0]       cm2_out_0_im_d10;
reg [15:0]       cm2_out_0_re_d11;
reg [15:0]       cm2_out_0_im_d11;
reg [15:0]       cm2_out_0_re_d12;
reg [15:0]       cm2_out_0_im_d12;
reg [15:0]       cm2_out_0_re_d13;
reg [15:0]       cm2_out_0_im_d13;
reg [15:0]       cm2_out_0_re_d14;
reg [15:0]       cm2_out_0_im_d14;
reg [15:0]       cm2_out_0_re_d15;
reg [15:0]       cm2_out_0_im_d15;
reg [15:0]       cm2_out_0_re_d16;
reg [15:0]       cm2_out_0_im_d16;

wire [15:0]      bf2_in_0_re; 
wire [15:0]      bf2_in_1_re;
wire [15:0]      bf2_in_0_im;
wire [15:0]      bf2_in_1_im;

wire [15:0]      bf2_out_0_re; 
wire [15:0]      bf2_out_1_re;
wire [15:0]      bf2_out_0_im;
wire [15:0]      bf2_out_1_im;

reg [15:0]       bf2_out_1_re_d1;
reg [15:0]       bf2_out_1_im_d1;
reg [15:0]       bf2_out_1_re_d2;
reg [15:0]       bf2_out_1_im_d2;
reg [15:0]       bf2_out_1_re_d3;
reg [15:0]       bf2_out_1_im_d3;
reg [15:0]       bf2_out_1_re_d4;
reg [15:0]       bf2_out_1_im_d4;
reg [15:0]       bf2_out_1_re_d5;
reg [15:0]       bf2_out_1_im_d5;
reg [15:0]       bf2_out_1_re_d6;
reg [15:0]       bf2_out_1_im_d6;
reg [15:0]       bf2_out_1_re_d7;
reg [15:0]       bf2_out_1_im_d7;
reg [15:0]       bf2_out_1_re_d8;
reg [15:0]       bf2_out_1_im_d8;

wire [15:0]      cm3_in_0_re; 
wire [15:0]      cm3_in_1_re;
wire [15:0]      cm3_in_0_im;
wire [15:0]      cm3_in_1_im;

wire [15:0]      cm3_out_0_re; 
wire [15:0]      cm3_out_1_re;
wire [15:0]      cm3_out_0_im;
wire [15:0]      cm3_out_1_im;

reg [15:0]       cm3_out_0_re_d1;
reg [15:0]       cm3_out_0_im_d1;
reg [15:0]       cm3_out_0_re_d2;
reg [15:0]       cm3_out_0_im_d2;
reg [15:0]       cm3_out_0_re_d3;
reg [15:0]       cm3_out_0_im_d3;
reg [15:0]       cm3_out_0_re_d4;
reg [15:0]       cm3_out_0_im_d4;
reg [15:0]       cm3_out_0_re_d5;
reg [15:0]       cm3_out_0_im_d5;
reg [15:0]       cm3_out_0_re_d6;
reg [15:0]       cm3_out_0_im_d6;
reg [15:0]       cm3_out_0_re_d7;
reg [15:0]       cm3_out_0_im_d7;
reg [15:0]       cm3_out_0_re_d8;
reg [15:0]       cm3_out_0_im_d8;

wire [15:0]      bf3_in_0_re; 
wire [15:0]      bf3_in_1_re;
wire [15:0]      bf3_in_0_im;
wire [15:0]      bf3_in_1_im;

wire [15:0]      bf3_out_0_re; 
wire [15:0]      bf3_out_1_re;
wire [15:0]      bf3_out_0_im;
wire [15:0]      bf3_out_1_im;

reg [15:0]       bf3_out_1_re_d1;
reg [15:0]       bf3_out_1_im_d1;
reg [15:0]       bf3_out_1_re_d2;
reg [15:0]       bf3_out_1_im_d2;
reg [15:0]       bf3_out_1_re_d3;
reg [15:0]       bf3_out_1_im_d3;
reg [15:0]       bf3_out_1_re_d4;
reg [15:0]       bf3_out_1_im_d4;

wire [15:0]      cm4_in_0_re; 
wire [15:0]      cm4_in_1_re;
wire [15:0]      cm4_in_0_im;
wire [15:0]      cm4_in_1_im;
                   
wire [15:0]      cm4_out_0_re; 
wire [15:0]      cm4_out_1_re;
wire [15:0]      cm4_out_0_im;
wire [15:0]      cm4_out_1_im;

reg [15:0]       cm4_out_0_re_d1;
reg [15:0]       cm4_out_0_im_d1;
reg [15:0]       cm4_out_0_re_d2;
reg [15:0]       cm4_out_0_im_d2;
reg [15:0]       cm4_out_0_re_d3;
reg [15:0]       cm4_out_0_im_d3;
reg [15:0]       cm4_out_0_re_d4;
reg [15:0]       cm4_out_0_im_d4;

wire [15:0]      bf4_in_0_re; 
wire [15:0]      bf4_in_1_re;
wire [15:0]      bf4_in_0_im;
wire [15:0]      bf4_in_1_im;
                   
wire [15:0]      bf4_out_0_re; 
wire [15:0]      bf4_out_1_re;
wire [15:0]      bf4_out_0_im;
wire [15:0]      bf4_out_1_im;

reg [15:0]       bf4_out_1_re_d1;
reg [15:0]       bf4_out_1_im_d1;
reg [15:0]       bf4_out_1_re_d2;
reg [15:0]       bf4_out_1_im_d2;

wire [15:0]      cm5_in_0_re; 
wire [15:0]      cm5_in_1_re;
wire [15:0]      cm5_in_0_im;
wire [15:0]      cm5_in_1_im;
                   
wire [15:0]      cm5_out_0_re; 
wire [15:0]      cm5_out_1_re;
wire [15:0]      cm5_out_0_im;
wire [15:0]      cm5_out_1_im;

reg [15:0]       cm5_out_0_re_d1;
reg [15:0]       cm5_out_0_im_d1;
reg [15:0]       cm5_out_0_re_d2;
reg [15:0]       cm5_out_0_im_d2;

wire [15:0]      bf5_in_0_re; 
wire [15:0]      bf5_in_1_re;
wire [15:0]      bf5_in_0_im;
wire [15:0]      bf5_in_1_im;
                   
wire [15:0]      bf5_out_0_re; 
wire [15:0]      bf5_out_1_re;
wire [15:0]      bf5_out_0_im;
wire [15:0]      bf5_out_1_im;

reg [15:0]       bf5_out_1_re_d1;
reg [15:0]       bf5_out_1_im_d1;

wire [15:0]      cm6_in_0_re; 
wire [15:0]      cm6_in_1_re;
wire [15:0]      cm6_in_0_im;
wire [15:0]      cm6_in_1_im;
                   
wire [15:0]      cm6_out_0_re; 
wire [15:0]      cm6_out_1_re;
wire [15:0]      cm6_out_0_im;
wire [15:0]      cm6_out_1_im;

reg [15:0]       cm6_out_0_re_d1;
reg [15:0]       cm6_out_0_im_d1;

wire [15:0]      bf6_in_0_re; 
wire [15:0]      bf6_in_1_re;
wire [15:0]      bf6_in_0_im;
wire [15:0]      bf6_in_1_im;

wire [15:0]      twiddle1_re;
wire [15:0]      twiddle1_im;

wire [15:0]      twiddle2_re;
wire [15:0]      twiddle2_im;

wire [15:0]      twiddle3_re;
wire [15:0]      twiddle3_im;

wire [15:0]      twiddle4_re;
wire [15:0]      twiddle4_im;

wire [15:0]      twiddle5_re;
wire [15:0]      twiddle5_im;                
// input MUX, depends on cnt_cal, to select inputs for the IFFT pipeline at each cycle
// input: 512 bits, ifft_in0_re, ifft_in0_im, ifft_in1_re, ifft_in1_im
// output: 16 bits, bf1_in0_re, bf1_in0_im, bf1_in1_re, bf1_in1_im
// selection signal: cnt_cal (e.g. when cnt_cal = 0,  bf1_in0_re = ifft_in0_re[32*16-1:31*16], ..., bf1_in0_im = ifft_in0_im[32*16-1:31*16], ...
//                                 when cnt_cal = 31, bf1_in0_re = ifft_in0_re[ 1*16-1: 0*16], ..., bf1_in0_im = ifft_in0_im[ 1*16-1: 0*16], ...)
// fill in your code here
data_mux u_data_mux_bf1_in_0_re (.data_in(ifft_in0_re), .data_sel(cnt_cal),.data_out(bf1_in_0_re));
data_mux u_data_mux_bf1_in_0_im (.data_in(ifft_in0_im), .data_sel(cnt_cal),.data_out(bf1_in_0_im));
data_mux u_data_mux_bf1_in_1_re (.data_in(ifft_in1_re), .data_sel(cnt_cal),.data_out(bf1_in_1_re));
data_mux u_data_mux_bf1_in_1_im (.data_in(ifft_in1_im), .data_sel(cnt_cal),.data_out(bf1_in_1_im));
// layer 1
    // twiddle factor MUX, depends on twiddle_sel1, to select twiddle factors for the 1st layer of the 64IFFT pipeline
    // input: 512 bits, twiddle_lut_re, twiddle_lut_im
    // output: 16 bits, twiddle1_re, twiddle1_im
    // fill in your code here
data_mux u_data_mux_twiddle1_re (.data_in(twiddle_lut_re), .data_sel(twiddle_sel1),.data_out(twiddle1_re));
data_mux u_data_mux_twiddle1_im (.data_in(twiddle_lut_im), .data_sel(twiddle_sel1),.data_out(twiddle1_im));

    // butterfly radix calculation with twiddle factor
    // Y0 = A + B
    // Y1 = (A - B)*W
    // instantiate your bf_radix2.v here
    // fill in your code here
bf_radix2
u_bf_radix2_layer1
    (
        .A_re(bf1_in_0_re),
        .B_re(bf1_in_1_re),
        .W_re(twiddle1_re),
        .A_im(bf1_in_0_im),
        .B_im(bf1_in_1_im),
        .W_im(twiddle1_im),
        .Y0_re(bf1_out_0_re),
        .Y1_re(bf1_out_1_re),
        .Y0_im(bf1_out_0_im),
        .Y1_im(bf1_out_1_im)
    );

//layer 2
    // twiddle factor MUX, depends on twiddle_sel2, to select twiddle factors for the 2nd layer of the 64IFFT pipeline
    // input: 512 bits, twiddle_lut_re, twiddle_lut_im
    // output: 16 bits, twiddle2_re, twiddle2_im
    // fill in your code here
data_mux u_data_mux_twiddle2_re (.data_in(twiddle_lut_re), .data_sel(twiddle_sel2),.data_out(twiddle2_re));
data_mux u_data_mux_twiddle2_im (.data_in(twiddle_lut_im), .data_sel(twiddle_sel2),.data_out(twiddle2_im));
    //re-arrange data
        // delay before commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        bf1_out_1_re_d1<= 'd0;
        bf1_out_1_im_d1<= 'd0; 
        bf1_out_1_re_d2<= 'd0; 
        bf1_out_1_im_d2<= 'd0;  
        bf1_out_1_re_d3<= 'd0; 
        bf1_out_1_im_d3<= 'd0; 
        bf1_out_1_re_d4<= 'd0; 
        bf1_out_1_im_d4<= 'd0; 
        bf1_out_1_re_d5<= 'd0; 
        bf1_out_1_im_d5<= 'd0; 
        bf1_out_1_re_d6<= 'd0; 
        bf1_out_1_im_d6<= 'd0; 
        bf1_out_1_re_d7<= 'd0; 
        bf1_out_1_im_d7<= 'd0; 
        bf1_out_1_re_d8<= 'd0; 
        bf1_out_1_im_d8<= 'd0; 
        bf1_out_1_re_d9<= 'd0; 
        bf1_out_1_im_d9<= 'd0; 
        bf1_out_1_re_d10 <= 'd0;
        bf1_out_1_im_d10 <= 'd0;
        bf1_out_1_re_d11 <= 'd0;
        bf1_out_1_im_d11 <= 'd0;
        bf1_out_1_re_d12 <= 'd0;
        bf1_out_1_im_d12 <= 'd0;
        bf1_out_1_re_d13 <= 'd0;
        bf1_out_1_im_d13 <= 'd0;
        bf1_out_1_re_d14 <= 'd0;
        bf1_out_1_im_d14 <= 'd0;
        bf1_out_1_re_d15 <= 'd0;
        bf1_out_1_im_d15 <= 'd0;
        bf1_out_1_re_d16 <= 'd0;
        bf1_out_1_im_d16 <= 'd0;
    end
    else begin
        bf1_out_1_re_d1<= bf1_out_1_re;
        bf1_out_1_im_d1<= bf1_out_1_im; 
        bf1_out_1_re_d2<= bf1_out_1_re_d1; 
        bf1_out_1_im_d2<= bf1_out_1_im_d1;  
        bf1_out_1_re_d3<= bf1_out_1_re_d2; 
        bf1_out_1_im_d3<= bf1_out_1_im_d2; 
        bf1_out_1_re_d4<= bf1_out_1_re_d3; 
        bf1_out_1_im_d4<= bf1_out_1_im_d3; 
        bf1_out_1_re_d5<= bf1_out_1_re_d4; 
        bf1_out_1_im_d5<= bf1_out_1_im_d4; 
        bf1_out_1_re_d6<= bf1_out_1_re_d5; 
        bf1_out_1_im_d6<= bf1_out_1_im_d5; 
        bf1_out_1_re_d7<= bf1_out_1_re_d6; 
        bf1_out_1_im_d7<= bf1_out_1_im_d6; 
        bf1_out_1_re_d8<= bf1_out_1_re_d7; 
        bf1_out_1_im_d8<= bf1_out_1_im_d7; 
        bf1_out_1_re_d9<= bf1_out_1_re_d8; 
        bf1_out_1_im_d9<= bf1_out_1_im_d8; 
        bf1_out_1_re_d10 <= bf1_out_1_re_d9;
        bf1_out_1_im_d10 <= bf1_out_1_im_d9;
        bf1_out_1_re_d11 <= bf1_out_1_re_d10;
        bf1_out_1_im_d11 <= bf1_out_1_im_d10;
        bf1_out_1_re_d12 <= bf1_out_1_re_d11;
        bf1_out_1_im_d12 <= bf1_out_1_im_d11;
        bf1_out_1_re_d13 <= bf1_out_1_re_d12;
        bf1_out_1_im_d13 <= bf1_out_1_im_d12;
        bf1_out_1_re_d14 <= bf1_out_1_re_d13;
        bf1_out_1_im_d14 <= bf1_out_1_im_d13;
        bf1_out_1_re_d15 <= bf1_out_1_re_d14;
        bf1_out_1_im_d15 <= bf1_out_1_im_d14;
        bf1_out_1_re_d16 <= bf1_out_1_re_d15;
        bf1_out_1_im_d16 <= bf1_out_1_im_d15;
    end
end
        // commutator
        // fill in your code here
assign cm2_in_0_re = bf1_out_0_re;
assign cm2_in_1_re = bf1_out_1_re_d16;
assign cm2_in_0_im = bf1_out_0_im;
assign cm2_in_1_im = bf1_out_1_im_d16;
commutator_radix2
u_commutator_radix2_layer2
(
    .in_0_re(cm2_in_0_re),
    .in_0_im(cm2_in_0_im),
    .in_1_re(cm2_in_1_re),
    .in_1_im(cm2_in_1_im),
    .pattern(pattern2),
    .out_0_re(cm2_out_0_re),
    .out_0_im(cm2_out_0_im),
    .out_1_re(cm2_out_1_re),
    .out_1_im(cm2_out_1_im)
);
        // delay after commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        cm2_out_0_re_d1<= 'd0;
        cm2_out_0_im_d1<= 'd0; 
        cm2_out_0_re_d2<= 'd0; 
        cm2_out_0_im_d2<= 'd0;  
        cm2_out_0_re_d3<= 'd0; 
        cm2_out_0_im_d3<= 'd0; 
        cm2_out_0_re_d4<= 'd0; 
        cm2_out_0_im_d4<= 'd0; 
        cm2_out_0_re_d5<= 'd0; 
        cm2_out_0_im_d5<= 'd0; 
        cm2_out_0_re_d6<= 'd0; 
        cm2_out_0_im_d6<= 'd0; 
        cm2_out_0_re_d7<= 'd0; 
        cm2_out_0_im_d7<= 'd0; 
        cm2_out_0_re_d8<= 'd0; 
        cm2_out_0_im_d8<= 'd0; 
        cm2_out_0_re_d9<= 'd0; 
        cm2_out_0_im_d9<= 'd0; 
        cm2_out_0_re_d10 <= 'd0;
        cm2_out_0_im_d10 <= 'd0;
        cm2_out_0_re_d11 <= 'd0;
        cm2_out_0_im_d11 <= 'd0;
        cm2_out_0_re_d12 <= 'd0;
        cm2_out_0_im_d12 <= 'd0;
        cm2_out_0_re_d13 <= 'd0;
        cm2_out_0_im_d13 <= 'd0;
        cm2_out_0_re_d14 <= 'd0;
        cm2_out_0_im_d14 <= 'd0;
        cm2_out_0_re_d15 <= 'd0;
        cm2_out_0_im_d15 <= 'd0;
        cm2_out_0_re_d16 <= 'd0;
        cm2_out_0_im_d16 <= 'd0;
    end
    else begin
        cm2_out_0_re_d1<= cm2_out_0_re;
        cm2_out_0_im_d1<= cm2_out_0_im; 
        cm2_out_0_re_d2<= cm2_out_0_re_d1; 
        cm2_out_0_im_d2<= cm2_out_0_im_d1;  
        cm2_out_0_re_d3<= cm2_out_0_re_d2; 
        cm2_out_0_im_d3<= cm2_out_0_im_d2; 
        cm2_out_0_re_d4<= cm2_out_0_re_d3; 
        cm2_out_0_im_d4<= cm2_out_0_im_d3; 
        cm2_out_0_re_d5<= cm2_out_0_re_d4; 
        cm2_out_0_im_d5<= cm2_out_0_im_d4; 
        cm2_out_0_re_d6<= cm2_out_0_re_d5; 
        cm2_out_0_im_d6<= cm2_out_0_im_d5; 
        cm2_out_0_re_d7<= cm2_out_0_re_d6; 
        cm2_out_0_im_d7<= cm2_out_0_im_d6; 
        cm2_out_0_re_d8<= cm2_out_0_re_d7; 
        cm2_out_0_im_d8<= cm2_out_0_im_d7; 
        cm2_out_0_re_d9<= cm2_out_0_re_d8; 
        cm2_out_0_im_d9<= cm2_out_0_im_d8; 
        cm2_out_0_re_d10 <= cm2_out_0_re_d9;
        cm2_out_0_im_d10 <= cm2_out_0_im_d9;
        cm2_out_0_re_d11 <= cm2_out_0_re_d10;
        cm2_out_0_im_d11 <= cm2_out_0_im_d10;
        cm2_out_0_re_d12 <= cm2_out_0_re_d11;
        cm2_out_0_im_d12 <= cm2_out_0_im_d11;
        cm2_out_0_re_d13 <= cm2_out_0_re_d12;
        cm2_out_0_im_d13 <= cm2_out_0_im_d12;
        cm2_out_0_re_d14 <= cm2_out_0_re_d13;
        cm2_out_0_im_d14 <= cm2_out_0_im_d13;
        cm2_out_0_re_d15 <= cm2_out_0_re_d14;
        cm2_out_0_im_d15 <= cm2_out_0_im_d14;
        cm2_out_0_re_d16 <= cm2_out_0_re_d15;
        cm2_out_0_im_d16 <= cm2_out_0_im_d15;
    end
end
    // butterfly radix calculation with twiddle factor
    // Y0 = A + B
    // Y1 = (A - B)*W
    // instantiate your bf_radix2.v here
    // fill in your code here
assign bf2_in_0_re = cm2_out_0_re_d16;
assign bf2_in_0_im = cm2_out_0_im_d16;
assign bf2_in_1_re = cm2_out_1_re;
assign bf2_in_1_im = cm2_out_1_im;
bf_radix2
u_bf_radix2_layer2
    (
        .A_re(bf2_in_0_re),
        .B_re(bf2_in_1_re),
        .W_re(twiddle2_re),
        .A_im(bf2_in_0_im),
        .B_im(bf2_in_1_im),
        .W_im(twiddle2_im),
        .Y0_re(bf2_out_0_re),
        .Y1_re(bf2_out_1_re),
        .Y0_im(bf2_out_0_im),
        .Y1_im(bf2_out_1_im)
    );

//layer 3
    // twiddle factor MUX, depends on twiddle_sel3, to select twiddle factors for the 3rd layer of the 64IFFT pipeline
    // input: 512 bits, twiddle_lut_re, twiddle_lut_im
    // output: 16 bits, twiddle3_re, twiddle3_im
    // fill in your code here
data_mux u_data_mux_twiddle3_re (.data_in(twiddle_lut_re), .data_sel(twiddle_sel3),.data_out(twiddle3_re));
data_mux u_data_mux_twiddle3_im (.data_in(twiddle_lut_im), .data_sel(twiddle_sel3),.data_out(twiddle3_im));

    //re-arrange data
        // delay before commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        bf2_out_1_re_d1<= 'd0;
        bf2_out_1_im_d1<= 'd0; 
        bf2_out_1_re_d2<= 'd0; 
        bf2_out_1_im_d2<= 'd0;  
        bf2_out_1_re_d3<= 'd0; 
        bf2_out_1_im_d3<= 'd0; 
        bf2_out_1_re_d4<= 'd0; 
        bf2_out_1_im_d4<= 'd0; 
        bf2_out_1_re_d5<= 'd0; 
        bf2_out_1_im_d5<= 'd0; 
        bf2_out_1_re_d6<= 'd0; 
        bf2_out_1_im_d6<= 'd0; 
        bf2_out_1_re_d7<= 'd0; 
        bf2_out_1_im_d7<= 'd0; 
        bf2_out_1_re_d8<= 'd0; 
        bf2_out_1_im_d8<= 'd0; 
    end
    else begin
        bf2_out_1_re_d1<= bf2_out_1_re;
        bf2_out_1_im_d1<= bf2_out_1_im; 
        bf2_out_1_re_d2<= bf2_out_1_re_d1; 
        bf2_out_1_im_d2<= bf2_out_1_im_d1;  
        bf2_out_1_re_d3<= bf2_out_1_re_d2; 
        bf2_out_1_im_d3<= bf2_out_1_im_d2; 
        bf2_out_1_re_d4<= bf2_out_1_re_d3; 
        bf2_out_1_im_d4<= bf2_out_1_im_d3; 
        bf2_out_1_re_d5<= bf2_out_1_re_d4; 
        bf2_out_1_im_d5<= bf2_out_1_im_d4; 
        bf2_out_1_re_d6<= bf2_out_1_re_d5; 
        bf2_out_1_im_d6<= bf2_out_1_im_d5; 
        bf2_out_1_re_d7<= bf2_out_1_re_d6; 
        bf2_out_1_im_d7<= bf2_out_1_im_d6; 
        bf2_out_1_re_d8<= bf2_out_1_re_d7; 
        bf2_out_1_im_d8<= bf2_out_1_im_d7; 
    end
end
        // commutator
        // fill in your code here
assign cm3_in_0_re = bf2_out_0_re;
assign cm3_in_0_im = bf2_out_0_im;
assign cm3_in_1_re = bf2_out_1_re_d8;
assign cm3_in_1_im = bf2_out_1_im_d8;
commutator_radix2
u_commutator_radix2_layer3
(
    .in_0_re(cm3_in_0_re),
    .in_0_im(cm3_in_0_im),
    .in_1_re(cm3_in_1_re),
    .in_1_im(cm3_in_1_im),
    .pattern(pattern3),
    .out_0_re(cm3_out_0_re),
    .out_0_im(cm3_out_0_im),
    .out_1_re(cm3_out_1_re),
    .out_1_im(cm3_out_1_im)
);
        // delay after commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        cm3_out_0_re_d1<= 'd0;
        cm3_out_0_im_d1<= 'd0; 
        cm3_out_0_re_d2<= 'd0; 
        cm3_out_0_im_d2<= 'd0;  
        cm3_out_0_re_d3<= 'd0; 
        cm3_out_0_im_d3<= 'd0; 
        cm3_out_0_re_d4<= 'd0; 
        cm3_out_0_im_d4<= 'd0; 
        cm3_out_0_re_d5<= 'd0; 
        cm3_out_0_im_d5<= 'd0; 
        cm3_out_0_re_d6<= 'd0; 
        cm3_out_0_im_d6<= 'd0; 
        cm3_out_0_re_d7<= 'd0; 
        cm3_out_0_im_d7<= 'd0; 
        cm3_out_0_re_d8<= 'd0; 
        cm3_out_0_im_d8<= 'd0; 
    end
    else begin
        cm3_out_0_re_d1<= cm3_out_0_re;
        cm3_out_0_im_d1<= cm3_out_0_im; 
        cm3_out_0_re_d2<= cm3_out_0_re_d1; 
        cm3_out_0_im_d2<= cm3_out_0_im_d1;  
        cm3_out_0_re_d3<= cm3_out_0_re_d2; 
        cm3_out_0_im_d3<= cm3_out_0_im_d2; 
        cm3_out_0_re_d4<= cm3_out_0_re_d3; 
        cm3_out_0_im_d4<= cm3_out_0_im_d3; 
        cm3_out_0_re_d5<= cm3_out_0_re_d4; 
        cm3_out_0_im_d5<= cm3_out_0_im_d4; 
        cm3_out_0_re_d6<= cm3_out_0_re_d5; 
        cm3_out_0_im_d6<= cm3_out_0_im_d5; 
        cm3_out_0_re_d7<= cm3_out_0_re_d6; 
        cm3_out_0_im_d7<= cm3_out_0_im_d6; 
        cm3_out_0_re_d8<= cm3_out_0_re_d7; 
        cm3_out_0_im_d8<= cm3_out_0_im_d7; 
    end
end
    // butterfly radix calculation with twiddle factor
    // Y0 = A + B
    // Y1 = (A - B)*W
    // instantiate your bf_radix2.v here
    // fill in your code here
assign bf3_in_0_re = cm3_out_0_re_d8;
assign bf3_in_0_im = cm3_out_0_im_d8;
assign bf3_in_1_re = cm3_out_1_re;
assign bf3_in_1_im = cm3_out_1_im;
bf_radix2
u_bf_radix2_layer3
    (
        .A_re(bf3_in_0_re),
        .B_re(bf3_in_1_re),
        .W_re(twiddle3_re),
        .A_im(bf3_in_0_im),
        .B_im(bf3_in_1_im),
        .W_im(twiddle3_im),
        .Y0_re(bf3_out_0_re),
        .Y1_re(bf3_out_1_re),
        .Y0_im(bf3_out_0_im),
        .Y1_im(bf3_out_1_im)
    );

//layer 4
    // twiddle factor MUX, depends on twiddle_sel4, to select twiddle factors for the 4th layer of the 64IFFT pipeline
    // input: 512 bits, twiddle_lut_re, twiddle_lut_im
    // output: 16 bits, twiddle4_re, twiddle4_im
    // fill in your code here
data_mux u_data_mux_twiddle4_re (.data_in(twiddle_lut_re), .data_sel(twiddle_sel4),.data_out(twiddle4_re));
data_mux u_data_mux_twiddle4_im (.data_in(twiddle_lut_im), .data_sel(twiddle_sel4),.data_out(twiddle4_im));

    //re-arrange data
        // delay before commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        bf3_out_1_re_d1<= 'd0;
        bf3_out_1_im_d1<= 'd0; 
        bf3_out_1_re_d2<= 'd0; 
        bf3_out_1_im_d2<= 'd0;  
        bf3_out_1_re_d3<= 'd0; 
        bf3_out_1_im_d3<= 'd0; 
        bf3_out_1_re_d4<= 'd0; 
        bf3_out_1_im_d4<= 'd0; 
    end
    else begin
        bf3_out_1_re_d1<= bf3_out_1_re;
        bf3_out_1_im_d1<= bf3_out_1_im; 
        bf3_out_1_re_d2<= bf3_out_1_re_d1; 
        bf3_out_1_im_d2<= bf3_out_1_im_d1;  
        bf3_out_1_re_d3<= bf3_out_1_re_d2; 
        bf3_out_1_im_d3<= bf3_out_1_im_d2; 
        bf3_out_1_re_d4<= bf3_out_1_re_d3; 
        bf3_out_1_im_d4<= bf3_out_1_im_d3; 
    end
end
        // commutator
        // fill in your code here
assign cm4_in_0_re = bf3_out_0_re;
assign cm4_in_0_im = bf3_out_0_im;
assign cm4_in_1_re = bf3_out_1_re_d4;
assign cm4_in_1_im = bf3_out_1_im_d4;
commutator_radix2
u_commutator_radix2_layer4
(
    .in_0_re(cm4_in_0_re),
    .in_0_im(cm4_in_0_im),
    .in_1_re(cm4_in_1_re),
    .in_1_im(cm4_in_1_im),
    .pattern(pattern4),
    .out_0_re(cm4_out_0_re),
    .out_0_im(cm4_out_0_im),
    .out_1_re(cm4_out_1_re),
    .out_1_im(cm4_out_1_im)
);

        // delay after commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        cm4_out_0_re_d1<= 'd0;
        cm4_out_0_im_d1<= 'd0; 
        cm4_out_0_re_d2<= 'd0; 
        cm4_out_0_im_d2<= 'd0;  
        cm4_out_0_re_d3<= 'd0; 
        cm4_out_0_im_d3<= 'd0; 
        cm4_out_0_re_d4<= 'd0; 
        cm4_out_0_im_d4<= 'd0; 
    end
    else begin
        cm4_out_0_re_d1<= cm4_out_0_re;
        cm4_out_0_im_d1<= cm4_out_0_im; 
        cm4_out_0_re_d2<= cm4_out_0_re_d1; 
        cm4_out_0_im_d2<= cm4_out_0_im_d1;  
        cm4_out_0_re_d3<= cm4_out_0_re_d2; 
        cm4_out_0_im_d3<= cm4_out_0_im_d2; 
        cm4_out_0_re_d4<= cm4_out_0_re_d3; 
        cm4_out_0_im_d4<= cm4_out_0_im_d3; 
    end
end
    // butterfly radix calculation with twiddle factor
    // Y0 = A + B
    // Y1 = (A - B)*W
    // instantiate your bf_radix2.v here
    // fill in your code here
assign bf4_in_0_re = cm4_out_0_re_d4;
assign bf4_in_0_im = cm4_out_0_im_d4;
assign bf4_in_1_re = cm4_out_1_re;
assign bf4_in_1_im = cm4_out_1_im;
bf_radix2
u_bf_radix2_layer4
    (
        .A_re(bf4_in_0_re),
        .B_re(bf4_in_1_re),
        .W_re(twiddle4_re),
        .A_im(bf4_in_0_im),
        .B_im(bf4_in_1_im),
        .W_im(twiddle4_im),
        .Y0_re(bf4_out_0_re),
        .Y1_re(bf4_out_1_re),
        .Y0_im(bf4_out_0_im),
        .Y1_im(bf4_out_1_im)
    );

//layer 5
    // twiddle factor MUX, depends on twiddle_sel5, to select twiddle factors for the 5th layer of the 64IFFT pipeline
    // input: 512 bits, twiddle_lut_re, twiddle_lut_im
    // output: 16 bits, twiddle5_re, twiddle5_im
    // fill in your code here
data_mux u_data_mux_twiddle5_re (.data_in(twiddle_lut_re),.data_sel(twiddle_sel5),.data_out(twiddle5_re));
data_mux u_data_mux_twiddle5_im (.data_in(twiddle_lut_im),.data_sel(twiddle_sel5),.data_out(twiddle5_im));


    //re-arrange data
        // delay before commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        bf4_out_1_re_d1<= 'd0;
        bf4_out_1_im_d1<= 'd0; 
        bf4_out_1_re_d2<= 'd0; 
        bf4_out_1_im_d2<= 'd0;  
    end
    else begin
        bf4_out_1_re_d1<= bf4_out_1_re;
        bf4_out_1_im_d1<= bf4_out_1_im; 
        bf4_out_1_re_d2<= bf4_out_1_re_d1; 
        bf4_out_1_im_d2<= bf4_out_1_im_d1;  
    end
end
        // commutator
        // fill in your code here
assign cm5_in_0_re = bf4_out_0_re;
assign cm5_in_0_im = bf4_out_0_im;
assign cm5_in_1_re = bf4_out_1_re_d2;
assign cm5_in_1_im = bf4_out_1_im_d2;
commutator_radix2
u_commutator_radix2_layer5
(
    .in_0_re(cm5_in_0_re),
    .in_0_im(cm5_in_0_im),
    .in_1_re(cm5_in_1_re),
    .in_1_im(cm5_in_1_im),
    .pattern(pattern5),
    .out_0_re(cm5_out_0_re),
    .out_0_im(cm5_out_0_im),
    .out_1_re(cm5_out_1_re),
    .out_1_im(cm5_out_1_im)
);

        // delay after commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        cm5_out_0_re_d1<= 'd0;
        cm5_out_0_im_d1<= 'd0; 
        cm5_out_0_re_d2<= 'd0; 
        cm5_out_0_im_d2<= 'd0;  
    end
    else begin
        cm5_out_0_re_d1<= cm5_out_0_re;
        cm5_out_0_im_d1<= cm5_out_0_im; 
        cm5_out_0_re_d2<= cm5_out_0_re_d1; 
        cm5_out_0_im_d2<= cm5_out_0_im_d1;  
    end
end

    // butterfly radix calculation with twiddle factor
    // Y0 = A + B
    // Y1 = (A - B)*W
    // instantiate your bf_radix2.v here
    // fill in your code here
assign bf5_in_0_re = cm5_out_0_re_d2;
assign bf5_in_0_im = cm5_out_0_im_d2;
assign bf5_in_1_re = cm5_out_1_re;
assign bf5_in_1_im = cm5_out_1_im;
bf_radix2
u_bf_radix2_layer5
    (
        .A_re(bf5_in_0_re),
        .B_re(bf5_in_1_re),
        .W_re(twiddle5_re),
        .A_im(bf5_in_0_im),
        .B_im(bf5_in_1_im),
        .W_im(twiddle5_im),
        .Y0_re(bf5_out_0_re),
        .Y1_re(bf5_out_1_re),
        .Y0_im(bf5_out_0_im),
        .Y1_im(bf5_out_1_im)
    );

//layer 6
    //re-arrange data
        // delay before commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        bf5_out_1_re_d1<= 'd0;
        bf5_out_1_im_d1<= 'd0;  
    end
    else begin
        bf5_out_1_re_d1<= bf5_out_1_re;
        bf5_out_1_im_d1<= bf5_out_1_im; 
    end
end
        // commutator
        // fill in your code here
assign cm6_in_0_re = bf5_out_0_re;
assign cm6_in_0_im = bf5_out_0_im;
assign cm6_in_1_re = bf5_out_1_re_d1;
assign cm6_in_1_im = bf5_out_1_im_d1;
commutator_radix2
u_commutator_radix2_layer6
(
    .in_0_re(cm6_in_0_re),
    .in_0_im(cm6_in_0_im),
    .in_1_re(cm6_in_1_re),
    .in_1_im(cm6_in_1_im),
    .pattern(pattern6),
    .out_0_re(cm6_out_0_re),
    .out_0_im(cm6_out_0_im),
    .out_1_re(cm6_out_1_re),
    .out_1_im(cm6_out_1_im)
);

        // delay after commutator
        // fill in your code here
always@(posedge clk or negedge arstn) begin
    if(!arstn) begin
        cm6_out_0_re_d1<= 'd0;
        cm6_out_0_im_d1<= 'd0;  
    end
    else begin
        cm6_out_0_re_d1<= cm6_out_0_re;
        cm6_out_0_im_d1<= cm6_out_0_im; 
    end
end

    // butterfly radix calculation without twiddle factor
    // Y0 = A + B
    // Y1 = A - B
    // instantiate your bf_radix2_noW.v here
    // fill in your code here
assign bf6_in_0_re = cm6_out_0_re_d1;
assign bf6_in_0_im = cm6_out_0_im_d1;
assign bf6_in_1_re = cm6_out_1_re;
assign bf6_in_1_im = cm6_out_1_im;
bf_radix2_noW
u_bf_radix2_noW_layer6
    (
        .A_re(bf6_in_0_re),
        .B_re(bf6_in_1_re),
        .A_im(bf6_in_0_im),
        .B_im(bf6_in_1_im),
        .Y0_re(ifft_out0_re),
        .Y1_re(ifft_out1_re),
        .Y0_im(ifft_out0_im),
        .Y1_im(ifft_out1_im)
    );


endmodule
