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

module MIPS_System(
  input 				CLOCK_50,
  input	[3:0] 	KEY,
  input	[17:0] 	SW,
  output [6:0] 	HEX7,
  output [6:0] 	HEX6,
  output [6:0] 	HEX5,
  output [6:0]  	HEX4,
  output [6:0]  	HEX3,
  output [6:0]  	HEX2,
  output [6:0]  	HEX1,
  output [6:0]  	HEX0,
  output [17:0] 	LEDR,
  output [8:0]  	LEDG);

  wire 				reset;
  wire 				reset_poweron;
  reg  				reset_ff;
  wire 				clk0;
  wire 				locked;
  wire [31:0] 		inst_addr;
  wire [31:0] 		inst;
  wire [31:0] 		data_addr;
  wire [31:0] 		write_data;
  wire [31:0] 		read_data_timer;
  wire [31:0] 		read_data_uart;
  wire [31:0] 		read_data_gpio;
  wire [31:0] 		read_data_mem;
  reg  [31:0] 		read_data;
  wire        		cs_mem_n;
  wire        		cs_timer_n;
  wire        		cs_gpio_n;
  wire        		data_we;

  wire 				clk90;
  wire 				clk180;
  wire 				data_re;
  
  // reset =  KEY[0]
  // if KEY[0] is pressed, the reset goes down to "0"
  // reset is a low-active signal
  assign  reset_poweron = KEY[0];
  assign  reset = reset_poweron & locked;

  always @(posedge clk0)  reset_ff <= reset;

  ALTPLL_clkgen pll0(
			 .inclk0   (CLOCK_50), 
			 .c0       (clk0), 
			 .c1       (clk90), 
			 .c2       (clk180), 
			 .locked   (locked)); 


  always @(*)
  begin
	  if      (~cs_timer_n) read_data <= read_data_timer;
	  else if (~cs_gpio_n)  read_data <= read_data_gpio;
	  else                  read_data <= read_data_mem;
  end


  mips mips_cpu (
		.clk           (clk0), 
		.reset         (~reset_ff),
		.pc            (inst_addr),
		.instr         (inst),
		.memwrite      (data_we),  // data_we: active high
		.memaddr       (data_addr), 
		.memwritedata  (write_data),
		.memreaddata   (read_data));

	assign data_re = ~data_we;


	// Port A: Instruction
	// Port B: Data
   ram2port_inst_data Inst_Data_Mem (
		.address_a   (inst_addr[12:2]),
		.address_b   (data_addr[12:2]),
		.byteena_b   (4'b1111),
		.clock_a     (clk90),		//was clk90
		.clock_b     (clk180),		//was clk180
		.data_a      (),
		.data_b      (write_data),
		.enable_a    (1'b1),
		.enable_b    (~cs_mem_n),
		.wren_a      (1'b0),
		.wren_b      (data_we),
		.q_a         (inst),
		.q_b         (read_data_mem));


  Addr_Decoder Decoder ( 
		 .Addr        (data_addr),
       .CS_MEM_N    (cs_mem_n) ,
       .CS_TC_N     (cs_timer_n),
       .CS_UART_N   (),
       .CS_GPIO_N   (cs_gpio_n));


  TimerCounter Timer (
       .clk     (clk0),
       .reset   (~reset_ff),
       .CS_N    (cs_timer_n),
       .RD_N    (~data_re),
       .WR_N    (~data_we),
       .Addr    (data_addr[11:0]),
       .DataIn  (write_data),
       .DataOut (read_data_timer),
		 .Intr    ());


   GPIO uGPIO ( 
	    .clk (clk0),
       .reset    (~reset_ff),
       .CS_N     (cs_gpio_n),
       .RD_N     (~data_re),
       .WR_N     (~data_we),
       .Addr     (data_addr[11:0]),
       .DataIn   (write_data),
       .DataOut  (read_data_gpio),
       .Intr     (),

       .KEY     (KEY[3:1]),
       .SW      (SW),
       .HEX7    (HEX7),
       .HEX6    (HEX6),
       .HEX5    (HEX5),
       .HEX4    (HEX4),
       .HEX3    (HEX3),
       .HEX2    (HEX2),
       .HEX1    (HEX1),
       .HEX0    (HEX0),
       .LEDR    (LEDR),
       .LEDG    (LEDG));
 
endmodule
