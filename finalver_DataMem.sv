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
    input logic         reset,
    input logic [6:0]   address,
    input logic [31:0]   write_data,
    input logic         we2,
    output logic [31:0] read_data
    );
    
     (* keep = "true" *) logic [31:0] mem [127:0];
//    logic [31:0] mem [127:0];
    
    always_ff @(posedge clk) begin
        if(reset) begin
            mem <= '{128{0}};
            end
            
       else begin 
        if (we2) begin
            mem[address] <= write_data;
        end
        
        assign read_data = mem[address];
        
     end
   end
endmodule
