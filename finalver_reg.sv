`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2016 10:59:10 AM
// Design Name: 
// Module Name: reg
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


module regfile(
    input logic clk,
    input logic rst,
    input logic we1,
    input logic [5:0] ra1,
    input logic [5:0] ra2,
    input logic [5:0] wa,
    input logic [31:0] wd,
    output logic [31:0] rd1,
    output logic [31:0] rd2);
    
    (* keep = "true" *) reg [31:0] regs [63:0] = '{default:'0};
//    reg [31:0] regs [63:0] = '{default:'0};
    //reg [31:0] regs [63:0] = '{64{'0}};
//    reg [31:0] regs [63:0];

    
//    assign rd1 = regs[ra1];
//    assign rd2 = regs[ra2];
    
    always_ff @(posedge clk) begin
          if (rst) begin
              //regs <= '{64{0}};
              regs <= '{64{'0}};
//            for(int i=0;i<64;++i) begin
//                regs[i] = 0;
//            end
          end else begin
              if (we1) begin
                regs[wa] <= wd;
              end
              rd1 <= regs[ra1];
              rd2 <= regs[ra2];
          end
      end
    
