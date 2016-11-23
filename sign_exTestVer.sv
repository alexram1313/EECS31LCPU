`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2016 04:33:05 PM
// Design Name: 
// Module Name: sign_ex
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


module sign_ex(
    input logic [14:0] in,
    output logic [31:0]  out
    );
    
    assign out = {{17{in[14]}},in[14:0]};
    
endmodule
