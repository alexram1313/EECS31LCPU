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


module DataMem(
    input logic         clk,
    input logic         rst,
    input logic [6:0]   address,
    input logic [31:0]   write_data,
    input logic         we2,
    output logic [31:0] read_data
    );
    
     (* keep = "true" *) logic [31:0] mem [127:0];
//    logic [31:0] mem [127:0];
    
    always_ff @(posedge clk) begin
        if(rst) begin
            mem <= '{128{0}};
            end
            
       else begin 
        if (we2) begin
            mem[address] <= write_data;
        end
              
     end
   end
    assign read_data = mem[address];
endmodule

module fa(
    input a,
    input b,
    input cin,
    input [2:0] opsel,
    output s,
    output cout
    );
    
    wire b_op = (opsel == 3'b000)?b:
                (opsel == 3'b110)?b:
                (opsel == 3'b101)?1'b1:
                (opsel == 3'b001)?~b:
                (opsel == 3'b011)?~b:
                (opsel == 3'b111)?1'bz:0;
                
    assign s = a ^ b_op ^ cin;
    assign cout = (a&b_op)|(b_op&cin)|(a&cin);
endmodule

module LOGIC1BIT(
    input [2:0] opsel,
    input OP1,
    input OP2,
    input cin,
    output result,
    output cout
    );
    
    assign result =   (opsel == 3'b000)? OP1&OP2:
                      (opsel == 3'b001)? OP1|OP2:
                      (opsel == 3'b010)? OP1^OP2:
                      (opsel == 3'b011)? ~OP1:
                      (opsel == 3'b101)? cin:
                       1'bz;
                       
    assign cout =      (opsel == 3'b000)? 1'b0:
                       (opsel == 3'b001)? 1'b0:
                       (opsel == 3'b010)? 1'b0:
                       (opsel == 3'b011)? 1'b0:
                       (opsel == 3'b101)? OP1:
                       1'bz;
endmodule

module CarryOut_Result1bitALU(
    input OP1,
    input OP2,
    input cin,
    input [2:0] opsel,
    input mode,
    output result,
    output cout
    );
    
      wire resultL;
      wire resultA;
      wire carryoutA;
      wire carryoutL;
     
      fa L1(
              .a(OP1),
              .b(OP2),
              .cin(cin),
              .opsel(opsel),
              .s(resultA),
              .cout(carryoutA)
              );
            
           LOGIC1BIT L2(
              .opsel(opsel),
              .OP1(OP1),
              .OP2(OP2),
              .cin(cin),
              .result(resultL),
              .cout(carryoutL) 
           );
        
          assign cout = (mode == 1'b0)? carryoutA:
                             (mode == 1'b1)? carryoutL:
                             1'bz;
                             
          assign result =  (mode == 1'b0)? resultA:
                           (mode == 1'b1)? resultL:
                            1'bz;
            
endmodule


module alu_128bit ( op1 , op2 , opsel , mode , result , c_flag , z_flag , o_flag , s_flag );

    parameter DWIDTH = 32;

    input  logic [ DWIDTH -1:0] op1 ;
    input  logic [ DWIDTH -1:0] op2 ;
    input  logic [ 2:0]         opsel ;
    input  logic                mode ;
    output logic [ DWIDTH -1:0] result ;
    output logic                c_flag ;
    output logic                z_flag ;
    output logic                o_flag ;
    output logic                s_flag ;

    logic cin;
    logic [DWIDTH -1 :0] cout;
    

    assign cin = ((opsel == 3'b100) & (~mode))? 1'b1:
                ((opsel == 3'b110) & (~mode))? 1'b1:
                ((opsel == 3'b011) & (~mode))? 1'b1:
                ((opsel == 3'b000) & (~mode))? 1'b0:
                ((opsel == 3'b001) & (~mode))? 1'b0:
                ((opsel == 3'b010) & (~mode))? 1'b0:
                ((opsel == 3'b101) & (~mode))? 1'b0:
                ((opsel == 3'b000) & (mode))? 1'b0:
                ((opsel == 3'b001) & (mode))? 1'b0:
                ((opsel == 3'b010) & (mode))? 1'b0:
                ((opsel == 3'b011) & (mode))? 1'b0:
                ((opsel == 3'b101) & (mode))? 1'b0:
                1'bz;
                
                
                 CarryOut_Result1bitALU L5(
                               .OP1(op1[0]), 
                               .OP2(op2[0]),
                               .cin(cin),
                               .opsel(opsel),
                               .mode(mode), 
                               .result(result[0]),
                               .cout(cout[0])
                               );

        
        genvar i;
        generate
            
            for (i = 1; i < DWIDTH; ++i) begin: gen
             
                CarryOut_Result1bitALU L1( 
                .OP1(op1[i]), 
                .OP2(op2[i]),
                .cin(cout[i-1]),
                .opsel(opsel),
                .mode(mode), 
                .result(result[i]),
                .cout(cout[i])
                );

        end
        endgenerate
        
        assign c_flag = cout[DWIDTH-1];
        assign o_flag = (~mode & ((op1[DWIDTH-1] & op2[DWIDTH-1] & ~result[DWIDTH-1])|(~op1[DWIDTH-1] & ~op2[DWIDTH-1] & result[DWIDTH-1])));
        assign z_flag = result == 0;
        assign s_flag = result[DWIDTH-1];
        
endmodule

module Mux(
    input logic [31:0]  op1,
    input logic [31:0]  op2,
    input logic  sel,
    output logic[31:0]  out_data
    );
    assign out_data = (sel == 1'b1)?op1:op2;
endmodule

module sign_ex(
    input logic [14:0] in,
    output logic [31:0]  out
    );
    
    assign out = {{17{in[14]}},in[14:0]};
    
endmodule

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

    
   assign rd1 = regs[ra1];
   assign rd2 = regs[ra2];
    
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
//               rd1 <= regs[ra1];
//               rd2 <= regs[ra2];
          end
      end
endmodule

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
    
    //assign mux_sel1 = (instruction[0] == 1'b0)? 0:1;  //if LSB of instruction is 0, its a register type and selector set to 0; else 1 signifying immediate type
    //assign mux_sel2 = (instruction[16:13] == 4'b0100 | instruction[16:13] == 4'b0110)? 1:0; //if read/store memory is called, muxsel2 is set to 1; else taking alu value
    //assign regwrite = (instruction[16:13] != 4'b0110)? 1:0;
    //assign memwrite = (instruction[16:13] == 4'b0110)? 1:0;
    
    //assign alu_mode = instruction[13];
    //assign alu_opsel = instruction[16:14];
    //assign rs = instruction[6:1];
    //assign rt = instruction[22:17];
    //assign rd = instruction[12:7];
    //assign imm = instruction[31:17];
    
    
    assign mux_sel1 = (instruction[31] == 1'b0)? 0:1;  //if LSB of instruction is 0, its a register type and selector set to 0; else 1 signifying immediate type
    assign mux_sel2 = (instruction[18:15] == 4'b0100 | instruction[18:15] == 4'b0110)? 1:0; //if read/store memory is called, muxsel2 is set to 1; else taking alu value
    assign regwrite = (instruction[18:15] != 4'b0110 & instruction[18:15] != 4'b1111)? 1:0;
    assign memwrite = (instruction[18:15] == 4'b0110)? 1:0;
    
    assign alu_mode = instruction[18];
    assign alu_opsel = instruction[17:15];
    assign rs = instruction[30:25];
    assign rt = instruction[14:9];
    assign rd = instruction[24:19];
    assign imm = instruction[14:0];
    
    
    
    
    
endmodule

module Instruction_Memory(
    input logic         clk,
    //input logic rst,
    input logic [5:0]   address,
    output logic [31:0] out_data
    );
    
    logic [31:0] inst_mem [63:0];
    
    assign inst_mem[0] = 32'b00000000000001111000000000000000; //NOP
    
    assign inst_mem[1] = 32'b10000000000010000000000000000001; //R1 = R0 + 1
    
    assign inst_mem[2] = 32'b10000010000100000000000000000001; //R2 = R1 + 1
    
    assign inst_mem[3] = 32'b00000010000111010000010000000000; //R3 = R1 XOR R2
    
    assign inst_mem[4] = 32'b00000110001001101000000000000000; //R4 = SLL R3 by 1
    
    assign inst_mem[5] = 32'b00001000001111001000011000000000; //R7 = R4 OR R3
    
    assign inst_mem[6] = 32'b00001110001010011000010000000000; //R5 = R7 - R2
    
    assign inst_mem[7] = 32'b10000000001100000000000000000110; //R6 = R0 + 6
    
    assign inst_mem[8] = 32'b00001100000000110000101000000000; //Store DM(R6) <- R5
    
    assign inst_mem[9] = 32'b00001100001100100000000000000000; //Load R6 <- DM(R6)
    
    genvar i;
    generate
    
        for(i = 10; i < 64; i++) begin: gen
            
            assign inst_mem[i] = 32'b00000000000001111000000000000000;
            
            end
            endgenerate
    
    always_ff @(posedge clk) begin
        //out_data <= mem[address];
           //if (!rst) begin
                out_data <= inst_mem[address];
           //end
           //else begin
                //mem <= '{64{0}};
                //end
    end
endmodule

module PC(
    input clk,
    input rst,
    output [5:0] address
    //input enable
    );
     logic [5:0] temp;
    
    always_ff @(posedge clk) begin
        if(rst) begin
            temp <= 0;
            end else begin
                if(temp + 1 == 64) begin
                    temp <= 0;
              end else begin
                    temp <= temp + 1;
            end
        end
     end
     
     assign address = temp; 
    
endmodule


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
