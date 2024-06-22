module Addr_Decoder (input [31:0] Addr,
                     output reg CS_MEM_N,
                     output reg CS_TC_N,
                     output reg CS_UART_N,
                     output reg CS_GPIO_N);
  
//======================================================================
//  Address      Peripheral     Peripheral Name              Size
// OxFFFF_FFFF  -------------  
//
//                Reserved
//
// OxFFFF_3000  -------------  
//                 GPIO         General Purpose IO            4KB
// OxFFFF_2000  -------------
//                              Universal 
//                  UART        Asynchronous                  4KB
//                              Receive/ Transmitter 
// OxFFFF_1000  -------------
//                  TC          Timer Conter                  4KB
// OxFFFF_0000  -------------                                
//
//                Reserved
//
// Ox0000_2000  -------------                                
//                  mem        Instruction & Data Memory      8KB
// Ox0000_0000  -------------                                
//=======================================================================

always @(*)
	begin
		if 		(Addr[31:13] == 19'h0000)		// Instruction & Data Memory
			begin
				CS_MEM_N		<=0;
				CS_TC_N 		<=1;
				CS_UART_N	<=1;
				CS_GPIO_N	<=1;
			end
    
		else if	(Addr[31:12] == 20'hFFFF0)	// Timer
			begin
				CS_MEM_N		<=1;
				CS_TC_N		<=0;
				CS_UART_N	<=1;
				CS_GPIO_N	<=1;
			end

		else if	(Addr[31:12] == 20'hFFFF1)	// UART
			begin
				CS_MEM_N    <=1;
				CS_TC_N     <=1;
				CS_UART_N   <=0;
				CS_GPIO_N   <=1;
			end

		else if  (Addr[31:12] == 20'hFFFF2)	// GPIO
			begin
				CS_MEM_N    <=1;
				CS_TC_N     <=1;
				CS_UART_N   <=1;
				CS_GPIO_N	<=0;
			end

		else 											// Nothing selected
			begin
				CS_MEM_N   <=1;
				CS_TC_N    <=1;
				CS_UART_N  <=1;
				CS_GPIO_N  <=1;
			end
	end
endmodule  
