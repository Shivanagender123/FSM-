interface fif(input bit clk);

logic reset;
logic data_in;
logic data_out;

	clocking drv_cb@(posedge clk);
		output reset;
		output data_in;
	endclocking

	clocking wrmon_cb@(posedge clk);
		input reset;
		input data_in;
	endclocking

	clocking rdmon_cb@(posedge clk);
		input data_out;
	endclocking

	modport DRV_MP(clocking drv_cb);
	modport WRMON_MP(clocking wrmon_cb);
	modport RDMON_MP(clocking rdmon_cb);

endinterface
