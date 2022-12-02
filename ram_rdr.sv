class ram_rdr extends uvm_driver #(ram_rtrans);

   `uvm_component_utils(ram_rdr)
   
   virtual ram_if.RDR_MP vif;
      
   function new (string name = "ram_rdr", uvm_component parent=null);
       super.new(name,parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction
   
   task run_phase(uvm_phase phase);

 //repeat(10) 
	forever
	 begin
	
       seq_item_port.get_next_item(req);
	   send_to_dut(req);
	   seq_item_port.item_done();
	 end
   endtask
   
   task send_to_dut(ram_rtrans req);
   //reset wait
    @(vif.rdr_cb);
	 
   //signal drive 
   vif.rdr_cb.rst <= req.rst;
   vif.rdr_cb.rd_enb <= req.rd_enb;
   vif.rdr_cb.rd_addr <= req.rd_addr;
	     
   
   endtask
   
endclass