`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2016 02:29:15 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    output [5:0] address,
    input enable
    );
     logic [5:0] temp;
    
    always_ff @(posedge clk) begin
        if(reset) begin
            temp <= 0;
            end else begin
                if(temp == 64) begin
                    temp <= 0;
              end else begin
                    temp <= temp + 1;
            end
        end
     end
     
     assign address = temp; 
    
endmodule
