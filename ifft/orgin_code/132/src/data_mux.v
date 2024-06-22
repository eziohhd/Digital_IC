`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 08:39:19 PM
// Design Name: 
// Module Name: data_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mux(

    input [511:0] data_in,
    input [4:0] data_sel,
    output reg [15:0] data_out
    );
    
always@(*) begin
    case(data_sel)
        0:begin
            data_out = data_in[32*16-1:31*16];
        end
        1:begin
            data_out = data_in[31*16-1:30*16];
        end
        2:begin
            data_out = data_in[30*16-1:29*16];
        end 
        3:begin
            data_out = data_in[29*16-1:28*16];
        end
        4:begin
            data_out = data_in[28*16-1:27*16];
        end
        5:begin
            data_out = data_in[27*16-1:26*16];
        end     
        6:begin
            data_out = data_in[26*16-1:25*16];
        end
        7:begin
            data_out = data_in[25*16-1:24*16];
        end
        8:begin
            data_out = data_in[24*16-1:23*16];
        end 
        9:begin
            data_out = data_in[23*16-1:22*16];
        end
        10:begin
            data_out = data_in[22*16-1:21*16];
        end
        11:begin
            data_out = data_in[21*16-1:20*16];
        end
        12:begin
            data_out = data_in[20*16-1:19*16];
        end
        13:begin
            data_out = data_in[19*16-1:18*16];
        end 
        14:begin
            data_out = data_in[18*16-1:17*16];
        end
        15:begin
            data_out = data_in[17*16-1:16*16];
        end
        16:begin
            data_out = data_in[16*16-1:15*16];
        end
        17:begin
            data_out = data_in[15*16-1:14*16];
        end
        18:begin
            data_out = data_in[14*16-1:13*16];
        end 
        19:begin
            data_out = data_in[13*16-1:12*16];
        end
        20:begin
            data_out = data_in[12*16-1:11*16];
        end
        21:begin
            data_out = data_in[11*16-1:10*16];
        end     
        22:begin
            data_out = data_in[10*16-1:9*16];
        end
        23:begin
            data_out = data_in[9*16-1:8*16];
        end
        24:begin
            data_out = data_in[8*16-1:7*16];
        end 
        25:begin
            data_out = data_in[7*16-1:6*16];
        end
        26:begin
            data_out = data_in[6*16-1:5*16];
        end
        27:begin
            data_out = data_in[5*16-1:4*16];
        end
        28:begin
            data_out = data_in[4*16-1:3*16];
        end
        29:begin
            data_out = data_in[3*16-1:2*16];
        end 
        30:begin
            data_out = data_in[2*16-1:1*16];
        end
        31:begin
            data_out = data_in[1*16-1:0*16];
        end                
    endcase
end

endmodule
