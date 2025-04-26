module reg_mux (CLK,RST,d,q,E);
parameter RSTTYPE="SYNC";
parameter PYPLINE=1;
parameter N=18 ;
input [N-1:0]d;
input CLK,RST,E;
output reg [N-1:0]q;
reg  [N-1:0] q_reg;

generate
    if (RSTTYPE=="SYNC") begin
        always @(posedge CLK ) begin
            if (RST) begin
                q_reg<=0;
            end
            else begin
               if (E) begin
                q_reg<=d;
               end 
               else
                q_reg<=0;
            end
            q<=(PYPLINE==1)? q_reg : d ;
        end
    end
    else begin
        always @(posedge CLK,posedge RST) begin
            if (RST) begin
                q_reg<=0;
            end
            else begin
                if (E) begin
                    q_reg<=d;
                end
                else
                q_reg<=0;
            end
        q<=(PYPLINE==1)? q_reg : d ;
        end
    end
endgenerate
endmodule