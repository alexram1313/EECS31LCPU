`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2016 10:50:50 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input logic         clk,
    input logic [6:0]   Address,
    input logic [31:0]   Write_Data,
    input logic         WE2,
    output logic [31:0] Read_Data
    //output logic        out
    );
    
    logic [31:0] mem [128:0];
    
    always_ff @(posedge clk) begin
        if (WE2) begin
            mem[Address] <= Write_Data;
        end
        
        else begin
            Read_Data <= mem[Address];
        end
    end
    //assign out = Read_Data;
endmodule
