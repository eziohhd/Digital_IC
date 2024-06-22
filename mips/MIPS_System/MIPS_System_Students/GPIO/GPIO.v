//
//
//  HEX:  To turn off, write "1"
//        To turn on, write "0" 
//
//  LEDR, LEDG : To turn off, write "0"
//				 To turn on,  write "1"
//
//         _0_
//       5|_6_|1
//       4|___|2
//          3
//
//  KEY:  Push --> "0" 
//        Release --> "1"
//
//  SW:   Down (towards the edge of the board)  --> "0"
//        Up --> "1"
//
module GPIO(
  input clk,
  input reset,
  input CS_N,
  input RD_N,
  input WR_N,
  input [11:0] Addr,
  input [31:0] DataIn,
  input [3:1] KEY,
  input [17:0] SW,
  
  output reg [31:0] DataOut,
  output Intr,
  output [6:0] HEX7,
  output [6:0] HEX6,
  output [6:0] HEX5,
  output [6:0] HEX4,
  output [6:0] HEX3,
  output [6:0] HEX2,
  output [6:0] HEX1,
  output [6:0] HEX0,
  output [17:0] LEDR,
  output [8:0] LEDG
  );

  reg [31:0] SW_StatusR;
  reg [31:0] KEY_StatusR;
  reg [31:0] LEDG_R;
  reg [31:0] LEDR_R;
  reg [31:0] HEX0_R;
  reg [31:0] HEX1_R;
  reg [31:0] HEX2_R;
  reg [31:0] HEX3_R;
  reg [31:0] HEX4_R;
  reg [31:0] HEX5_R;
  reg [31:0] HEX6_R;
  reg [31:0] HEX7_R;
  
  wire key1_pressed;
  wire key2_pressed;
  wire key3_pressed;

  wire sw0_pressed;
  wire sw1_pressed;
  wire sw2_pressed;
  wire sw3_pressed;
  wire sw4_pressed;
  wire sw5_pressed;
  wire sw6_pressed;
  wire sw7_pressed;
  wire sw8_pressed;
  wire sw9_pressed;
  wire sw10_pressed;
  wire sw11_pressed;
  wire sw12_pressed;
  wire sw13_pressed;
  wire sw14_pressed;
  wire sw15_pressed;
  wire sw16_pressed;
  wire sw17_pressed;
  
//  Register  
//  ========================================================
//  FFFF_202C   HEX7_R
//  FFFF_2028   HEX6_R
//  FFFF_2024   HEX5_R
//  FFFF_2020   HEX4_R
//  FFFF_201C   HEX3_R
//  FFFF_2018   HEX2_R
//  FFFF_2014   HEX1_R
//  FFFF_2010   HEX0_R
//  FFFF_200C   LEDG_R
//  FFFF_2008   LEDR_R
//  FFFF_2004   SW_StatusR
//  FFFF_2000   KEY_StatusR
//  --------------------------------------------------------
//  LEDG register (32bit) 
//  ZZZZ_ZZZ|LEDG8|_|LEDG7|LEDG6|LEDG5|LEDG4|_
//          |LEDG3|LEDG2|LEDG1|LEDG0|
//  --------------------------------------------------------
//  LEDR register(32 bit)
//  ZZZZ_ZZZZ_ZZZZ_ZZ|SLEDR17|LEDR16|_
//          |LEDR15|LEDR14|LEDR13|LEDR12|_
//          |LEDR11|LEDR10|LEDR9|LEDR8|_
//          |LEDR7|LEDR6|LEDR5|LEDR4|_
//          |LEDR3|LEDR2|LEDR1|LEDR0| 
//  --------------------------------------------------------
//  SW Status register(32 bit)
//  ZZZZ_ZZZZ_ZZZZ_ZZ|SW17|SW16|_
//          |SW15|SW14|SW13|SW12|_|SW11|SW10|SW9|SW8|_
//          |SW7|SW6|SW5|SW4|_|SW3|SW2|SW1|SW0|
//  --------------------------------------------------------
//  KEY Status register(32 bit)
//  ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_|key3|key2|key1|key0|
//  ========================================================

   key_detect  key1 (clk, reset, KEY[1], key1_pressed);
   key_detect  key2 (clk, reset, KEY[2], key2_pressed);
   key_detect  key3 (clk, reset, KEY[3], key3_pressed);
   
   key_detect  sw0  (clk, reset, ~SW[0],  sw0_pressed);
   key_detect  sw1  (clk, reset, ~SW[1],  sw1_pressed);
   key_detect  sw2  (clk, reset, ~SW[2],  sw2_pressed);
   key_detect  sw3  (clk, reset, ~SW[3],  sw3_pressed);
   key_detect  sw4  (clk, reset, ~SW[4],  sw4_pressed);
   key_detect  sw5  (clk, reset, ~SW[5],  sw5_pressed);
   key_detect  sw6  (clk, reset, ~SW[6],  sw6_pressed);
   key_detect  sw7  (clk, reset, ~SW[7],  sw7_pressed);
   key_detect  sw8  (clk, reset, ~SW[8],  sw8_pressed);
   key_detect  sw9  (clk, reset, ~SW[9],  sw9_pressed);
   key_detect  sw10 (clk, reset, ~SW[10], sw10_pressed);
   key_detect  sw11 (clk, reset, ~SW[11], sw11_pressed);
   key_detect  sw12 (clk, reset, ~SW[12], sw12_pressed);
   key_detect  sw13 (clk, reset, ~SW[13], sw13_pressed);
   key_detect  sw14 (clk, reset, ~SW[14], sw14_pressed);
   key_detect  sw15 (clk, reset, ~SW[15], sw15_pressed);
   key_detect  sw16 (clk, reset, ~SW[16], sw16_pressed);
   key_detect  sw17 (clk, reset, ~SW[17], sw17_pressed);
   
  //KEY Status Register Write
  always @(posedge clk)
  begin
    if(reset)    KEY_StatusR  <= 0;
    else
    begin
      //KEY             
      if (~CS_N && ~RD_N && Addr[11:0] == 12'h000)
          KEY_StatusR  <= 0;
      else
      begin
         if(key1_pressed)   KEY_StatusR[1] <= 1'b1;
         if(key2_pressed)   KEY_StatusR[2] <= 1'b1;
         if(key3_pressed)   KEY_StatusR[3] <= 1'b1;
      end
    end
  end



  //SW Status Register Write
  always @(posedge clk)
  begin
    if(reset)   SW_StatusR   <= 0;
    else
    begin
      if (~CS_N && ~RD_N && Addr[11:0] == 12'h004)
          SW_StatusR  <= 0;
      else
      begin
           //SW
           if(sw0_pressed)         SW_StatusR[0] <= 1'b1;
           if(sw1_pressed)         SW_StatusR[1] <= 1'b1;
           if(sw2_pressed)         SW_StatusR[2] <= 1'b1;
           if(sw3_pressed)         SW_StatusR[3] <= 1'b1;
           if(sw4_pressed)         SW_StatusR[4] <= 1'b1;
           if(sw5_pressed)         SW_StatusR[5] <= 1'b1;
           if(sw6_pressed)         SW_StatusR[6] <= 1'b1;
           if(sw7_pressed)         SW_StatusR[7] <= 1'b1;
           if(sw8_pressed)         SW_StatusR[8] <= 1'b1;
           if(sw9_pressed)         SW_StatusR[9] <= 1'b1;
           if(sw10_pressed)        SW_StatusR[10] <= 1'b1;
           if(sw11_pressed)        SW_StatusR[11] <= 1'b1;
           if(sw12_pressed)        SW_StatusR[12] <= 1'b1;
           if(sw13_pressed)        SW_StatusR[13] <= 1'b1;
           if(sw14_pressed)        SW_StatusR[14] <= 1'b1;
           if(sw15_pressed)        SW_StatusR[15] <= 1'b1;
           if(sw16_pressed)        SW_StatusR[16] <= 1'b1;
           if(sw17_pressed)        SW_StatusR[17] <= 1'b1;
      end
    end
  end
  
  
  
  // Register Read
  always @(*)
  begin
      if (~CS_N && ~RD_N) 
      begin
        if      (Addr[11:0] == 12'h000) DataOut <= KEY_StatusR;
        else if (Addr[11:0] == 12'h004) DataOut <= SW_StatusR;
        else                            DataOut <= 32'b0;
      end
      else                              DataOut <= 32'b0;
  end
  

  //write output Register
  always @(posedge clk)
  begin
    if(reset)
    begin                                        
        LEDR_R[17:0] <=18'b0;
        LEDG_R[8:0]  <=9'h1FF;
        HEX0_R <= 7'b1000000;
        HEX1_R <= 7'b1000000;
        HEX2_R <= 7'b1000000;
        HEX3_R <= 7'b1000000;
        HEX4_R <= 7'b1000000;
        HEX5_R <= 7'b1000000;
        HEX6_R <= 7'b1000000;
        HEX7_R <= 7'b1000000;
    end
  
    else if(~CS_N && ~WR_N) 
    begin                                        
	        if       (Addr[11:0] == 12'h008)  LEDR_R       <= DataIn;
           else if  (Addr[11:0] == 12'h00C)  LEDG_R       <= DataIn;
           else if  (Addr[11:0] == 12'h010)  HEX0_R       <= DataIn;
           else if  (Addr[11:0] == 12'h014)  HEX1_R       <= DataIn;
           else if  (Addr[11:0] == 12'h018)  HEX2_R       <= DataIn;
           else if  (Addr[11:0] == 12'h01C)  HEX3_R       <= DataIn;
           else if  (Addr[11:0] == 12'h020)  HEX4_R       <= DataIn;
           else if  (Addr[11:0] == 12'h024)  HEX5_R       <= DataIn;
           else if  (Addr[11:0] == 12'h028)  HEX6_R       <= DataIn;
           else if  (Addr[11:0] == 12'h02C)  HEX7_R       <= DataIn;
    end
  end         
   
	//output 
	assign LEDR[17:0] = LEDR_R[17:0];
	assign LEDG[8:0]  = LEDG_R[8:0];
	assign HEX0       = HEX0_R[6:0];
	assign HEX1       = HEX1_R[6:0];
	assign HEX2       = HEX2_R[6:0];
	assign HEX3       = HEX3_R[6:0];
	assign HEX4       = HEX4_R[6:0];
	assign HEX5       = HEX5_R[6:0];
	assign HEX6       = HEX6_R[6:0];
	assign HEX7       = HEX7_R[6:0];
   
  
	assign Intr = ~((|KEY_StatusR[3:0]) || (|SW_StatusR[17:0])); 

endmodule


module key_detect(input clk, input reset, input key, output key_pressed);

			reg [3:0] c_state;
			reg [3:0] n_state;

			parameter  S0  =  4'b0000;
			parameter  S1  =  4'b0001;
			parameter  S2  =  4'b0010;
			parameter  S3  =  4'b0011;
			parameter  S4  =  4'b0100;
			parameter  S5  =  4'b0101;
			parameter  S6  =  4'b0110;
			parameter  S7  =  4'b0111;
			parameter  S8  =  4'b1000;
			parameter  S9  =  4'b1001;
			parameter  S10 =  4'b1010;
			parameter  S11 =  4'b1011;
			parameter  S12 =  4'b1100;
			parameter  S13 =  4'b1101;
			parameter  S14 =  4'b1110;
			parameter  S15 =  4'b1111;

			always@ (posedge clk) // synchronous resettable flop-flops
			begin
				if(reset) c_state <= S0;
				else       c_state <= n_state;
			end
			
			always@(*) // Next state logic
			begin
			case(c_state)
			S0 :  if(~key) n_state <= S1;
					else     n_state <= S0;

			S1 :  if(~key) n_state <= S2;
					else     n_state <= S0;

			S2 :  if(~key) n_state <= S3;
					else     n_state <= S0;

			S3 :  if(~key) n_state <= S4;
					else     n_state <= S0;

			S4 :  if(~key) n_state <= S5;
					else     n_state <= S0;

			S5 :  if(~key) n_state <= S6;
					else     n_state <= S0;

			S6 :  if(~key) n_state <= S7;
					else     n_state <= S0;

			S7 :  if(~key) n_state <= S8;
					else     n_state <= S0;

			S8 :  if(~key) n_state <= S9;
					else     n_state <= S0;

			S9 :  if(~key) n_state <= S10;
					else     n_state <= S0;

			S10:  if(~key) n_state <= S11;
					else     n_state <= S0;

			S11:  if(~key) n_state <= S12;
					else     n_state <= S0;

			S12:  if(~key) n_state <= S13;
					else     n_state <= S0;

			S13:  if(~key) n_state <= S14;
					else     n_state <= S0;

			S14:  if(~key) n_state <= S15;
					else     n_state <= S0;

			S15:  if(key)  n_state <= S0;
					else     n_state <= S15;

			default:       n_state <= S0;
			endcase
         end

			assign  key_pressed =  (c_state == S14);

endmodule
