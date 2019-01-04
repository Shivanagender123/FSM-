class trans;

rand bit reset;
rand bit data_in;
logic data_out;
static int trans_id;

constraint r{reset inside {0};}
	function void display(input string message);
		$display("=============================================================");
		$display("%s",message);
		$display("\tReset=%d",reset);
		$display("\tdata_in=%d", data_in);
		$display("\tData_out= %d",data_out);
		$display("=============================================================");
	endfunction: display

	function void post_randomize;
		trans_id++;
		this.display("RANDOM DATA");
	endfunction
endclass

