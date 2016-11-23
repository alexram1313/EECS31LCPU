`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2016 04:33:39 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input logic         clk,
    input logic [5:0]   address,
    output logic [31:0] out_data
    );
    
    logic [63:0] mem [31:0];
    
    always_ff @(posedge clk) begin
        out_data <= mem[address];
    end
endmodule
