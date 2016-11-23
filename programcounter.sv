module programcounter
	(	input			clk,
		input			rst,
	 output logic [4:0]  		count
	);
logic [5:0] pr_state;
logic  [4:0] nx_state;

always_ff @ ( posedge clk, negedge rst) 
	begin
	if ( !rst )
		pr_state <= zero;
	else
         	pr_state <= nx_state;
 	end
	
always_comb 
	begin
	nx_state = pr_state;
	unique case ( pr_state ) 
		0 : nx_state = 6’d1;
		1 : nx_state = 6’d2;
		2 : nx_state = 6’d3;
		3 : nx_state = 6’d4;
		4 : nx_state = 6’d5;
		5 : nx_state = 6’d6;
		6 : nx_state = 6’d7;
		7 : nx_state = 6’d8;
		8 : nx_state = 6’d9;
		9 : nx_state = 6’d10;
		10 :nx_state= 6’d11;
		11 : nx_state = 5’d12;
		12 : nx_state = 5’d13;
		13 : nx_state = 5’d14;
		14 : nx_state = 5’d15;
		15 : nx_state = 5’d16;
		16 : nx_state = 5’d17;
		17 : nx_state = 5’d18;
		18 : nx_state = 5’d19;
		19 : nx_state = 5’d20;
		20 : nx_state = 5’d21;
		21 : nx_state = 5’d22;
		22 : nx_state = 5’d23;
		23 : nx_state = 5’d24;
		24 : nx_state = 5’d25;
		25 : nx_state = 5’d26;
		26 : nx_state = 5’d27;
		27 : nx_state = 5’d28;
		28 : nx_state = 5’d29;
		29 : nx_state = 5’d30;
		30 : nx_state = 5’d31;
		31 : nx_state = 5’d32;
		32 : nx_state = 5’d33;
		33 : nx_state = 5’d34;
		34 : nx_state = 5’d35;
		35 : nx_state = 5’d36;
		36 : nx_state = 5’d37;
		37  : nx_state = 5’d38;
		38 : nx_state = 5’d39;
		39 : nx_state = 5’d40;
		40 : nx_state = 5’d41;
		41 : nx_state = 5’d42;
		42 : nx_state = 5’d43;
		43 : nx_state = 5’d44;
		44 : nx_state = 5’d45;
		45 : nx_state = 5’d46;
		46 : nx_state = 5’d47;
		47 : nx_state = 5’d48;
		48 : nx_state = 5’d49;
		49 : nx_state = 5’d50;
		50 : nx_state = 5’d51;
		51 : nx_state = 5’d52;
		52 : nx_state = 5’d53;
		53 : nx_state = 5’d54;
		54 : nx_state = 5’d55;
		55 : nx_state = 5’d56;
		56 : nx_state = 5’d57;
		57 : nx_state = 5’d58;
		58 : nx_state = 5’d59;
		59 : nx_state = 5’d60;
		60 : nx_state = 5’d61;
		61 : nx_state = 5’d62;
		62 : nx_state = 5’d63;
		63 : nx_state = 5’d0;
	
	
count = nx_state;
end


endmodule



