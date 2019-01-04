class wrmon;

trans data;
mailbox #(trans) wr2rm;
virtual fif.WRMON_MP wr_if;

	function new(virtual fif.WRMON_MP wr_if,
	mailbox #(trans) wr2rm);
		this.wr2rm=wr2rm;
		this.wr_if=wr_if;
		this.data=new;
	endfunction

	virtual task monitor;
		@(wr_if.wrmon_cb);
		data.reset=wr_if.wrmon_cb.reset;
		data.data_in=wr_if.wrmon_cb.data_in;
	endtask

	virtual task start;
		fork
			forever begin
			monitor;
			wr2rm.put(data);
			end
		join_none
	endtask
endclass
