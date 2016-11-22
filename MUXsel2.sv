`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2016 02:30:32 PM
// Design Name: 
// Module Name: MUXsel2
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


module MUXsel2(
    input logic [31:0]  Read_Data,
    input logic [31:0]  ALUresult,
    input logic [1:0]   MUXsel2,
    output logic[31:0]  Out_Data
    );
    assign Out_Data = (MUXsel2 == 1'b1)?Read_Data:ALUresult;
endmodule
