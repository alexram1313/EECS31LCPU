`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 06:28:16 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input logic [31:0] instruction,
    output logic [2:0] alu_opsel,
    output logic alu_mode,
    output logic mux_sel1,
    output logic mux_sel2,
    output logic regwrite,
    output logic [5:0] rs,
    output logic [5:0] rt,
    output logic [5:0] rd,
    output logic [14:0] imm,
    output logic memwrite
    );
    
    //wire inst;
    //logic [31:0] instruct;
    //logic = instructionmem(inst);
    
    assign mux_sel1 = (instruction[0] == 1'b0)? 0:1;  //if LSB of instruction is 0, its a register type and selector set to 0; else 1 signifying immediate type
    assign mux_sel2 = (instruction[16:13] == 4'b0100 | instruction[15:12] == 4'b0110)? 1:0; //if read/store memory is called, muxsel2 is set to 1; else taking alu value
    assign regwrite = (instruction[16:13] != 4'b0110)? 1:0;
    assign memwrite = (instruction[16:13] == 4'b0110)? 1:0;
    
    assign alu_mode = instruction[12];
    assign alu_opsel = instruction[16:14];
    assign rs = instruction[6:1];
    assign rt = instruction[22:17];
    assign rd = instruction[12:7];
    assign imm = instruction[31:17];
    
    
    
    
    
    
endmodule
