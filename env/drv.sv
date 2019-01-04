class drv;
trans data2duv;

mailbox #(trans) gen2drv;
virtual fif.DRV_MP drv_if;
	function new(virtual fif.DRV_MP drv_if,
			mailbox #(trans) gen2drv);
		this.drv_if=drv_if;
		this.gen2drv=gen2drv;
	endfunction: new
	

	virtual task drive();
		@(drv_if.drv_cb);
                  drv_if.drv_cb.reset<=data2duv.reset;
		  drv_if.drv_cb.data_in<=data2duv.data_in;     	 			
	endtask : drive

	 virtual task reset_duv();
		@(drv_if.drv_cb);
                  drv_if.drv_cb.reset<=1;
		@(drv_if.drv_cb);  
		  drv_if.drv_cb.reset<=0;	 			
	endtask
	
	virtual task start;
		fork
			begin
			reset_duv;
			forever begin
			gen2drv.get(data2duv);
			drive; end
			end
		join_none
	endtask
endclass
			


