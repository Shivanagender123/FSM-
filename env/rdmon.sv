class rdmon;

mailbox #(trans) rd2sb;
trans data_r;
virtual fif.RDMON_MP rd_if;

	function new(virtual fif.RDMON_MP rd_if,
	mailbox #(trans) rd2sb);
		this.rd_if=rd_if;
		this.rd2sb=rd2sb;
		this.data_r=new;
	endfunction

	task monitor;
		@(rd_if.rdmon_cb);
		data_r.data_out=rd_if.rdmon_cb.data_out;
	endtask

	virtual task start;
		fork
			forever begin
			monitor;
			rd2sb.put(data_r);
			end
		join_none
	endtask
endclass

