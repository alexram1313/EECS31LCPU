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


module Mux(
    input logic [31:0]  op1,
    input logic [31:0]  op2,
    input logic  sel,
    output logic[31:0]  out_data
    );
    assign out_data = (sel == 1'b1)?op1:op2;
endmodule
