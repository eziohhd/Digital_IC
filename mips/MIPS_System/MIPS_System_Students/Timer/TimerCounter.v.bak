`timescale 1ns/1ps

module TimerCounter(
  input clk,
  input reset,
  input CS_N,
  input RD_N,
  input WR_N,
  input [11:0] Addr,
  input [31:0] DataIn,
  output reg [31:0] DataOut,
  output Intr);
  

  reg [31:0] CompareR;
  reg [31:0] CounterR;
  reg [31:0] StatusR; 
  
    
//  ==============================
//  Timer registers 
//  ==============================
//  FFFF_0200 Status register  (Read-Only)
//  FFFF_0100 Counter register (Read-Only)
//  ------------------------------
//  FFFF_0000 Compare register (Read/Write)
//  ==============================


  // Compare Register Write
  always @(posedge clk)
  begin
    if(reset)                                        
          CompareR <=32'hFFFF_FFFF;
          
    else if(~CS_N && ~WR_N && (Addr[11:0]==12'h000))     
          CompareR <= DataIn;
          
  end
    

  // Status Register
  always @(posedge clk)
  begin      
    if (reset)
         StatusR <= 32'b0; 
    
    else if (CompareR == CounterR)
         StatusR[0] <= 1'b1;
         
    else if (~CS_N && ~RD_N && Addr[11:0] == 12'h200)
         StatusR[0] <= 1'b0;
    
  end   

  assign  Intr = ~StatusR[0];


  // Increment Counter in the Counter Register 
  // Reset conditions: 1. reset 2. when the counter value is equal to the compare register
  always @(posedge clk)
  begin      
    if(reset | StatusR[0])   CounterR <= 32'b0;
    else                      CounterR <= CounterR + 32'b1; 
  end


  // Register Read
  always @(*)
  begin
    if(~CS_N && ~RD_N)
    begin
      if      (Addr[11:0] == 12'h000) DataOut <= CompareR;
      else if (Addr[11:0] == 12'h100) DataOut <= CounterR;
      else if (Addr[11:0] == 12'h200) DataOut <= StatusR;
      else                            DataOut <= 32'b0;
     end
     else                             DataOut <= 32'b0;
  end
  
endmodule
