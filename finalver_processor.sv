`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2016 01:42:39 PM
// Design Name: 
// Module Name: processor
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


module processor(
    input logic clk,
    input logic rst,
    output logic [31:0] reg_write_data
    );
    //output of PC
    logic [5:0] address;
    //output of instruction mem
    logic [31:0] instruction;
    //output for controller
    logic mux_sel1;
    logic mux_sel2;
    logic regwrite;
    logic [14:0] immediate;
    logic memwrite;
    logic [5:0] rs;
    logic [5:0] rt;
    logic [5:0] rd;
    logic alumode;
    logic [2:0] aluopsel;
    
    //output for regfile
    logic [31:0] op1;
    logic [31:0] op2;
    
    //output for sign extend
    logic [31:0] sign_ex;
    
    //output for mux1
    logic [31:0] mux1_out;
    
    //output for ALU
    logic [31:0] alu_result;
    
    //output for Data Memory
    logic [31:0] data_mem_out;
    
    //output for mux2
    logic [31:0] mux2_out;
    
    PC L1(
        .clk(clk),
        .rst(rst),
        .address(address)
    );
    
    Instruction_Memory L2(
        .address(address),
        .clk(clk),
        //.rst(rst),
        .out_data(instruction)
    );
    
    Controller L3(
        .instruction(instruction),
        .mux_sel1(mux_sel1),
        .mux_sel2(mux_sel2),
        .regwrite(regwrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .imm(immediate),
        .memwrite(memwrite),
        .alu_mode(alumode),
        .alu_opsel(aluopsel)
    );
    
    regfile L4(
        .clk(clk),
        .ra1(rs),
        .ra2(rt),
        .wa(rd),
        .wd(mux2_out), 
        .we1(regwrite),
        .rd1(op1),
        .rd2(op2),
        .rst(rst)
    
    );
    
    sign_ex L5(
        .in(immediate),
        .out(sign_ex)

    );
    
    
    Mux L6(
        .op1(sign_ex),
        .op2(op2),
        .out_data(mux1_out),
        .sel(mux_sel1)
    );
    
    wire c_flag, o_flag, z_flag,s_flag;
    
    alu_128bit L7(
        .op1(op1),
        .op2(mux1_out),
        .mode(alumode),
        .opsel(aluopsel),
        .result(alu_result),
        .c_flag(c_flag),
        .o_flag(o_flag),
        .z_flag(z_flag),
        .s_flag(s_flag)
        
    );
    
    DataMem L8(
        .clk(clk),
        .address(op1[6:0]),
        .write_data(op2),
        .we2(memwrite),
        .read_data(data_mem_out),
        .rst(rst)
    );
    
    Mux L9(
      .op1(data_mem_out),
      .op2(alu_result),
      .sel(mux_sel2),
      .out_data(mux2_out)
    );
    
    assign reg_write_data = mux2_out;
    
endmodule
