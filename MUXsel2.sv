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
    input logic [31:0]  read_data,
    input logic [31:0]  alu_result,
    input logic [1:0]   muxsel2,
    output logic[31:0]  out_data
    );
    assign out_data = (muxsel2 == 1'b1)?read_data:alu_result;
endmodule
