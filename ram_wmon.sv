class ram_wmon extends uvm_monitor;

  `uvm_component_utils(ram_wmon)
     uvm_analysis_port#(ram_wtrans) wr_port;
   virtual ram_if.WMON_MP vif;
   ram_wtrans trans_h;
   function new (string name = "ram_wmon", uvm_component parent=null);
	  super.new(name,parent);
	  wr_port=new("wr_port",this);
   endfunction

   
   task run_phase(uvm_phase phase);
  //   repeat(10) 
	forever
	begin 
	monitor();
	wr_port.write(trans_h);
   end
endtask
   
   task monitor();
      //ram_wtrans trans_h; we are creating the data of other port so its a eror 
	   @(vif.wmon_cb);
      //handle creation
 trans_h = ram_wtrans::type_id::create("trans_h");   
	 //wait for reset
	
	 
	 // collect data 
	 trans_h.rst = vif.wmon_cb.rst;
	 trans_h.wr_enb = vif.wmon_cb.wr_enb;
trans_h.wr_addr = vif.wmon_cb.wr_addr;
trans_h.wr_data = vif.wmon_cb.wr_data;   
   
   endtask
   
endclass