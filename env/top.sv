`include"test.sv"
module top;
bit clk;

always #5 clk=~clk;
fif DUV_IF(clk);
fsm RTL(.clk(clk),.reset(DUV_IF.reset),.data_in(DUV_IF.data_in),.data_out(DUV_IF.data_out));
initial
 begin
  test t=new(DUV_IF,DUV_IF,DUV_IF);
  t.build_run;
 end

endmodule
  

