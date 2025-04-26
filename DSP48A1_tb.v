module DSP48A1_tb ();
   reg [17:0]A,B,D,BCIN,BCOUT_exp;
   reg [47:0]C,PCIN,P_exp;
   reg CARRYIN,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,CARRYOUT_exp;
   reg RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,CLK;
   reg [7:0]OPMODE;
   reg [35:0]M_exp;
   wire [35:0]M;
   wire [47:0]P,PCOUT;
   wire [17:0]BCOUT;
   wire CARRYOUT,CARRYOUTF;
   DSP48A1 #(.CARRYINSEL(0)) DSP1 (.*);
   initial begin
    CLK=0;
    forever #2 CLK=~CLK;
   end
   initial begin
    	RSTA  = 1;		CEA   = 0;
		RSTB  = 1;		CEB       = 0;
		RSTC  = 1;		CEC       = 0;
		RSTD  = 1;		CED       = 0;
		RSTCARRYIN = 1; CECARRYIN = 0;
		RSTM       = 1;	CEM       = 0;
		RSTOPMODE  = 1;	CEOPMODE  = 0;
		RSTP       = 1;	CEP       = 0;
		A=0; B=0; C=0; D=0; CARRYIN=0; OPMODE=0; PCIN=0; BCIN=0;
		M_exp=0; P_exp=0; BCOUT_exp=0;
        @(negedge CLK);
        if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp) begin
			$display("Error in reset operation.");
        end   
   
   	    RSTA  = 0;		CEA   = 1;
		RSTB  = 0;		CEB       = 1;
		RSTC  = 0;		CEC       = 1;
		RSTD  = 0;		CED       = 1;
		RSTCARRYIN = 0; CECARRYIN = 1;
		RSTM       = 0;	CEM       = 1;
		RSTOPMODE  = 0;	CEOPMODE  = 1;
		RSTP       = 0;	CEP       = 1;
        OPMODE[4] = 1;
		OPMODE[1:0] = 1;
		OPMODE[3:2] = 0;
		CARRYIN = 0; 
		OPMODE[6] = 0; D = 70; B = 30; A = 1;
        BCOUT_exp    = 100; 
		M_exp        = 100; 
		P_exp        = 100; 
		CARRYOUT_exp = 0;
        if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp || CARRYOUT != CARRYOUT_exp) begin
			$display("Error in Pre-Adder Check operation. M=%0d,M_exp=%0d",M,M_exp);
			$display("P=%0d,P_exp=%0d,BCOUT=%0d,BCOUT_exp=%0d,CARRYOUT=%0d,CARRYOUT_exp=%0d",P,P_exp,BCOUT,BCOUT_exp,CARRYOUT,CARRYOUT_exp);
		end
       	OPMODE[6]=1; D=50; B=20;
		BCOUT_exp    = 30; 
		M_exp        = 30;
		P_exp        = 30; 
		CARRYOUT_exp = 0;
		repeat(4) @(negedge CLK);
		if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp || CARRYOUT != CARRYOUT_exp) begin
			$display("Error in Pre-Subtract Check operation. M=%0d,M_exp=%0d",M,M_exp);
			$display("P=%0d,P_exp=%0d,BCOUT=%0d,BCOUT_exp=%0d,CARRYOUT=%0d,CARRYOUT_exp=%0d",P,P_exp,BCOUT,BCOUT_exp,CARRYOUT,CARRYOUT_exp);
		end 
        OPMODE[4] = 0; 
		A=10; B=5;
		BCOUT_exp    = 5;  
		M_exp        = 50; 
		P_exp        = 50; 
		CARRYOUT_exp = 0;
		repeat(8) @(negedge CLK);
        if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp || CARRYOUT != CARRYOUT_exp) begin
			$display("Error in multiplier Check operation. M=%0d,M_exp=%0d",M,M_exp);
			$display("P=%0d,P_exp=%0d,BCOUT=%0d,BCOUT_exp=%0d,CARRYOUT=%0d,CARRYOUT_exp=%0d",P,P_exp,BCOUT,BCOUT_exp,CARRYOUT,CARRYOUT_exp);
		end
        OPMODE[1:0]=1;
		OPMODE[3:2]=3;
		OPMODE[7]=0;
		A=7; 
		B=3;
		C=1;
		CARRYIN=1;
		BCOUT_exp    = 3; 
		M_exp        = 21; 
		P_exp        = 23; 
		CARRYOUT_exp = 0;  
		repeat(12) @(negedge CLK);
        if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp || CARRYOUT != CARRYOUT_exp) begin
			$display("Error in post-ADDER Check operation. M=%0d,M_exp=%0d",M,M_exp);
			$display("P=%0d,P_exp=%0d,BCOUT=%0d,BCOUT_exp=%0d,CARRYOUT=%0d,CARRYOUT_exp=%0d",P,P_exp,BCOUT,BCOUT_exp,CARRYOUT,CARRYOUT_exp);
		end
        	OPMODE[7]=1;
		A=1;
		B=11;
		C=14;
		CARRYIN=1;
		BCOUT_exp    = 11; 
		M_exp        = 11; 
		P_exp        = 2; 
		CARRYOUT_exp = 0;  
		repeat(12) @(negedge CLK);
          if(M != M_exp || P != P_exp || BCOUT != BCOUT_exp || CARRYOUT != CARRYOUT_exp) begin
			$display("Error in post-subtractor Check operation. M=%0d,M_exp=%0d",M,M_exp);
			$display("P=%0d,P_exp=%0d,BCOUT=%0d,BCOUT_exp=%0d,CARRYOUT=%0d,CARRYOUT_exp=%0d",P,P_exp,BCOUT,BCOUT_exp,CARRYOUT,CARRYOUT_exp);
		end
          #2;
         $stop;
   end
endmodule