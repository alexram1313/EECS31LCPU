module programcounter
	(	input			clk,
		input			rst,
	 output logic [4:0]  		count
	);
	logic [5:0] pr_state;
	logic [5:0] nx_state;

always_ff @ ( posedge clk) 
	begin
	if ( rst )
		pr_state <= 6'd0;
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
		11 : nx_state = 6’d12;
		12 : nx_state = 6’d13;
		13 : nx_state = 6’d14;
		14 : nx_state = 6’d15;
		15 : nx_state = 6’d16;
		16 : nx_state = 6’d17;
		17 : nx_state = 6’d18;
		18 : nx_state = 6’d19;
		19 : nx_state = 6’d20;
		20 : nx_state = 6’d21;
		21 : nx_state = 6’d22;
		22 : nx_state = 6’d23;
		23 : nx_state = 6’d24;
		24 : nx_state = 6’d25;
		25 : nx_state = 6’d26;
		26 : nx_state = 6’d27;
		27 : nx_state = 6’d28;
		28 : nx_state = 6’d29;
		29 : nx_state = 6’d30;
		30 : nx_state = 6’d31;
		31 : nx_state = 6’d32;
		32 : nx_state = 6’d33;
		33 : nx_state = 6’d34;
		34 : nx_state = 6’d35;
		35 : nx_state = 6’d36;
		36 : nx_state = 6’d37;
		37  : nx_state = 6’d38;
		38 : nx_state = 6’d39;
		39 : nx_state = 6’d40;
		40 : nx_state = 6’d41;
		41 : nx_state = 6’d42;
		42 : nx_state = 6’d43;
		43 : nx_state = 6’d44;
		44 : nx_state = 6’d45;
		45 : nx_state = 6’d46;
		46 : nx_state = 6’d47;
		47 : nx_state = 6’d48;
		48 : nx_state = 6’d49;
		49 : nx_state = 6’d50;
		50 : nx_state = 6’d51;
		51 : nx_state = 6’d52;
		52 : nx_state = 6’d53;
		53 : nx_state = 6’d54;
		54 : nx_state = 6’d55;
		55 : nx_state = 6’d56;
		56 : nx_state = 6’d57;
		57 : nx_state = 6’d58;
		58 : nx_state = 6’d59;
		59 : nx_state = 6’d60;
		60 : nx_state = 6’d61;
		61 : nx_state = 6’d62;
		62 : nx_state = 6’d63;
		63 : nx_state = 6’d0;

	
count = nx_state;
	end


endmodule



