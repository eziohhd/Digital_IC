//--------------------------------------------------------------
// mips.v
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Single-cycle MIPS processor
//--------------------------------------------------------------

// files needed for simulation:
//  mipsttest.v
//  mipstop.v
//  mipsmem.v
//  mips.v
//  mipsparts.v

// single-cycle MIPS processor
module mips(input         clk, reset,
            output [31:0] pc,
            input  [31:0] instr,
            output        memwrite,
            output [31:0] memaddr,
            output [31:0] memwritedata,
            input  [31:0] memreaddata);

  wire        signext, shiftl16, memtoreg, branch;
  wire        pcsrc, zero;
  wire        alusrc, regdst, regwrite, jump;
  wire [2:0]  alucontrol;
  //for lh
  wire        lh_mode;
  wire        lh_sel;
  wire [31:0]  memaddr_sel; 
  wire [31:0]  memreaddata_sel1;
  wire [31:0]  memreaddata_sel2;
  wire [15:0]  memreaddata_high = memreaddata[31:16];
  wire [15:0]  memreaddata_low = memreaddata[15:0];

  assign       lh_mode = (instr[31:26] == 6'b100001);
  assign       lh_sel = memaddr_sel[0];
  assign       memreaddata_sel1 = lh_sel? {{16{memreaddata_high[15]}},memreaddata_high} : {{16{memreaddata_low[15]}},memreaddata_low};
  assign       memreaddata_sel2 = lh_mode ? memreaddata_sel1 : memreaddata;
  assign       memaddr = lh_mode ? {1'b0,memaddr_sel[15:1]} : memaddr_sel;

  // Instantiate Controller
  controller c(.op         (instr[31:26]), 
			      .funct      (instr[5:0]), 
					.zero       (zero),
               .signext    (signext), 
               .shiftl16   (shiftl16), 
               .memtoreg   (memtoreg), 
					.memwrite   (memwrite), 
					.pcsrc      (pcsrc),
               .alusrc     (alusrc), 
					.regdst     (regdst), 
					.regwrite   (regwrite), 
					.jump       (jump),
               .alucontrol (alucontrol));

  // Instantiate Datapath
  datapath dp( .clk        (clk), 
			      .reset      (reset), 
					.signext    (signext), 
					.shiftl16   (shiftl16), 
					.memtoreg   (memtoreg), 
					.pcsrc      (pcsrc),
               .alusrc     (alusrc), 
					.regdst     (regdst), 
					.regwrite   (regwrite), 
					.jump       (jump),
               .alucontrol (alucontrol),
               .zero       (zero), 
					.pc         (pc), 
					.instr      (instr),
               .aluout     (memaddr_sel), 
					.writedata  (memwritedata), 
					.readdata   (memreaddata_sel2));

endmodule


module controller(input  [5:0] op, funct,
                  input        zero,
                  output       signext,
                  output       shiftl16,
                  output       memtoreg, memwrite,
                  output       pcsrc, alusrc,
                  output       regdst, regwrite,
                  output       jump,
                  output [2:0] alucontrol);

  wire [2:0] aluop;
  wire       branch;
  


  maindec md( .op    (op), 
			     .signext   (signext), 
			     .shiftl16  (shiftl16), 
			     .memtoreg  (memtoreg), 
				  .memwrite  (memwrite), 
				  .branch    (branch),
              .alusrc    (alusrc), 
				  .regdst    (regdst), 
				  .regwrite  (regwrite), 
				  .jump      (jump),
              .aluop     (aluop));

  aludec  ad( .funct      (funct), 
			     .aluop      (aluop), 
				  .alucontrol (alucontrol));

  assign pcsrc = branch & zero;

endmodule


module maindec(input  [5:0] op,
               output       signext,
               output       shiftl16,
               output       memtoreg, memwrite,
               output       branch, alusrc,
               output       regdst, regwrite,
               output       jump,
               output [2:0] aluop);

  reg [11:0] controls;

  assign {signext, shiftl16, regwrite, regdst, 
			 alusrc, branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always @(*)
    case(op)
      6'b000000: controls <= 12'b001100000011; // Rtype
      6'b100011: controls <= 12'b101010010000; // LW
		6'b100001: controls <= 12'b101010010100; // LH
      6'b101011: controls <= 12'b100010100000; // SW
      6'b000100: controls <= 12'b100001000001; // BEQ
      6'b001110: controls <= 12'b001010000110; // XORI 
      6'b001001: controls <= 12'b101010000000; // ADDI, ADDIU: only difference is exception
      6'b001101: controls <= 12'b001010000010; // ORI
      6'b001111: controls <= 12'b011010000000; // LUI
      6'b000010: controls <= 12'b000000001000; // J
      default:   controls <= 12'bxxxxxxxxxxxx; // ???
    endcase

endmodule

module aludec(input      [5:0] funct,
              input      [2:0] aluop,
              output reg [2:0] alucontrol);

  always @(*)
    case(aluop)
      3'b000: alucontrol <= 3'b010;  // add
		3'b100: alucontrol <= 3'b010;  // add
      3'b001: alucontrol <= 3'b110;  // sub
      3'b010: alucontrol <= 3'b001;  // or
		3'b110: alucontrol <= 3'b101;  // XOR
      default: case(funct)          // RTYPE
          6'b100000,
          6'b100001: alucontrol <= 3'b010; // ADD, ADDU: only difference is exception
          6'b100010: alucontrol <= 3'b011; // NOR
          6'b100011: alucontrol <= 3'b110; // SUB, SUBU: only difference is exception
          6'b100100: alucontrol <= 3'b000; // AND
          6'b100101: alucontrol <= 3'b001; // OR
          6'b101010: alucontrol <= 3'b111; // SLT
          default:   alucontrol <= 3'bxxx; // ???
        endcase
    endcase
endmodule


module datapath(input         clk, reset,
                input         signext,
                input         shiftl16,
                input         memtoreg, pcsrc,
                input         alusrc, regdst,
                input         regwrite, jump,
                input  [2:0]  alucontrol,
                output        zero,
                output [31:0] pc,
                input  [31:0] instr,
                output [31:0] aluout, writedata,
                input  [31:0] readdata);

  wire [4:0]  writereg;
  wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  wire [31:0] signimm, signimmsh, shiftedimm;
  wire [31:0] srca, srcb;
  wire [31:0] result;
  wire        shift;

  // next PC logic
  flopr #(32) pcreg (.clk   (clk), 
			            .reset (reset), 
						   .d     (pcnext), 
						   .q     (pc));

  adder       pcadd1 (.a (pc), 
			             .b (32'b100), 
						 	 .y (pcplus4));

  sl2         immsh (.a (signimm), 
			            .y (signimmsh));
				 
  adder       pcadd2 (.a (pcplus4), 
			             .b (signimmsh), 
							 .y (pcbranch));

  mux2 #(32)  pcbrmux(.d0  (pcplus4), 
			             .d1  (pcbranch), 
							 .s   (pcsrc), 
							 .y   (pcnextbr));

  mux2 #(32)  pcmux (.d0   (pcnextbr), 
			            .d1   ({pcplus4[31:28], instr[25:0], 2'b00}), 
                     .s    (jump), 
							.y    (pcnext));

  // register file logic
  regfile     rf(.clk     (clk), 
			        .we      (regwrite), 
					  .ra1     (instr[25:21]),
					  .ra2     (instr[20:16]), 
					  .wa      (writereg),
                 .wd      (result), 
					  .rd1     (srca), 
					  .rd2     (writedata));

  mux2 #(5)   wrmux(.d0  (instr[20:16]), 
			           .d1  (instr[15:11]), 
						  .s   (regdst), 
						  .y   (writereg));

  mux2 #(32)  resmux(.d0 (aluout), 
			            .d1 (readdata), 
							.s  (memtoreg), 
							.y  (result));

  sign_zero_ext  sze(.a       (instr[15:0]), 
			            .signext (signext),
			            .y       (signimm[31:0]));

  shift_left_16 sl16(.a         (signimm[31:0]), 
			            .shiftl16  (shiftl16),
			            .y         (shiftedimm[31:0]));

  // ALU logic
  mux2 #(32)  srcbmux(.d0 (writedata), 
			             .d1 (shiftedimm[31:0]), 
							 .s  (alusrc), 
							 .y  (srcb));

  alu         alu( .a       (srca), 
			          .b       (srcb), 
						 .alucont (alucontrol),
						 .result  (aluout), 
						 .zero    (zero));
endmodule
