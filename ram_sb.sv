class ram_sb extends uvm_scoreboard;

    `uvm_component_utils(ram_sb)
	
  /* uvm_analysis_imp#(ram_wtrans,ram_sb)wr_imp;
   uvm_analysis_imp#(ram_rtrans,ram_sb)rd_imp;*/
   
   uvm_tlm_analysis_fifo#(ram_rtrans)rd_fifo;
   uvm_tlm_analysis_fifo#(ram_wtrans)wr_fifo;
 ram_wtrans wtrans;
  ram_rtrans rtrans;
bit [7:0] rm [0:15];
bit [7:0]temp_data;
   
   function new (string name = "ram_sb", uvm_component parent=null);
	  super.new(name,parent);
	  rd_fifo = new("rd_fifo ",this);
	  wr_fifo = new("wr_fifo ",this);
   endfunction
   
    
task run_phase (uvm_phase phase);
forever
begin

rd_fifo.get(rtrans); //get from monitors using fifo
wr_fifo.get(wtrans);  //get from monitors using fifo
ref_model();
score_board();


//to display refence model in ram uvm

	//$display("temp_data=%p",temp_data);
	//$display("rm=%p \n",rm);
end
endtask



task ref_model();
   if(rtrans.rd_enb)
      temp_data = rm[rtrans.rd_addr];
	  
   if(wtrans.wr_enb)
	rm[wtrans.wr_addr] = wtrans.wr_data;
  endtask
  
 task score_board();
 if (rtrans.rd_data !== 0 && rtrans.rd_data !== 8'dx)
	  begin
           if (rtrans.rd_data !== temp_data)
	          $display(" DATA MISMATCH ! RD_data = %p : %p = temp_data\n",rtrans.rd_data,temp_data);
	       else
              $display(" SUCCESS ! RD_data = %p : %p = temp_data\n",rtrans.rd_data,temp_data);
      end
   endtask
endclass















