////////////////////////////////////////////////////////////////
// input ports
// A_re    -the 1st input (real part) of the radix butterfly unit (16 bits)
// B_re    -the 2nd input (real part) of the radix butterfly unit (16 bits)
// A_im    -the 1st input (imag part) of the radix butterfly unit (16 bits)
// B_im    -the 2nd input (imag part) of the radix butterfly unit (16 bits)

// output ports
// Y0_re    -the 1st output (real part) of the radix butterfly unit (16 bits)
// Y1_re    -the 2nd output (real part) of the radix butterfly unit (16 bits)
// Y0_im    -the 1st output (imag part) of the radix butterfly unit (16 bits)
// Y1_im    -the 2nd output (imag part) of the radix butterfly unit (16 bits)
////////////////////////////////////////////////////////////////
module bf_radix2_noW
    (
        input signed [15:0] A_re,
        input signed [15:0] B_re,
        input signed [15:0] A_im,
        input signed [15:0] B_im,
        output signed [15:0] Y0_re,
        output signed [15:0] Y1_re,
        output signed [15:0] Y0_im,
        output signed [15:0] Y1_im
    );
 
// wire definition
// fill in your code here


// Y0 = A + B
// Y1 = A - B
// A, B, Y0, Y1 are complex number whose real and imag parts are represented with 1 sign bit, 7 integer bits, and 8 fractional bits
// fill in your code here
assign Y0_re = A_re + B_re;
assign Y1_re = A_re - B_re;
assign Y0_im = A_im + B_im;
assign Y1_im = A_im - B_im;


endmodule
