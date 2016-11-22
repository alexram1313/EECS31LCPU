`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2016 07:40:47 PM
// Design Name: 
// Module Name: alu_128bit
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
