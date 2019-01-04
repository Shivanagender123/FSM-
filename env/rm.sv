class rm;
static bit [1:0]s;
static bit o;
parameter IDLE=2'b00,
	  STATE1=2'b01,
	  STATE11=2'b10;
trans data;
mailbox #(trans) rm2sb;
mailbox #(trans) wr2rm;

	function new(mailbox #(trans) wr2rm,
	mailbox #(trans) rm2sb);
		this.wr2rm=wr2rm;
		this.rm2sb=rm2sb;
	endfunction

	virtual task start;
		fork
			forever
			begin
			wr2rm.get(data);
			fun_fsm(data);
			data.data_out=o;
			rm2sb.put(data);
			end
		join_none
	endtask

	virtual task fun_fsm(trans d);
		o<=0;
		if(d.reset)
			s<=IDLE;
		else
		begin
			o<=0;
			case(s)
			IDLE:begin 
				if(d.data_in)
				s<=STATE1;
				else
				s<=IDLE;
			     end	
			STATE1:begin
				if(d.data_in)
				begin
					s<=STATE11;
					o<=1;
				end
				else
					s<=IDLE;
				end
			STATE11:begin
				if(d.data_in)
				begin
					s<=STATE11;
					o<=1;
				end
				else
					s<=IDLE;
				end
			endcase
		end
	endtask
endclass
				

