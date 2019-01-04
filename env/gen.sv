class gen;

mailbox #(trans) gen2drv;

trans gen_trans;
trans data2duv;

	function new(mailbox #(trans) gen2drv);
		this.gen_trans=new;
		this.gen2drv=gen2drv;
	endfunction: new

	virtual task start;
		fork
			begin
			for(int i=0;i<number_of_transactions;i++)
			begin
				gen_trans.trans_id++;
				assert(gen_trans.randomize);
				data2duv=new gen_trans;
				gen2drv.put(data2duv);
			end end
		join_none
	endtask
endclass
