class ram_rmon extends uvm_monitor;

  `uvm_component_utils(ram_rmon)
  uvm_analysis_port #(ram_rtrans) rd_port; //analysis port for sb connection
   virtual ram_if.RMON_MP vif;
    ram_rtrans trans_h;
   function new (string name = "ram_rmon", uvm_component parent=null);
	  super.new(name,parent);
	  rd_port=new("rd_port",this); //port for sb connection
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction
   
   task run_phase(uvm_phase phase);
    // repeat(10) 
	forever begin
	monitor();
	rd_port.write(trans_h); //write data given to sb
   end
   endtask
   
   task monitor();
     
	   @(vif.rmon_cb);
      //handle creation
    trans_h = ram_rtrans::type_id::create("trans_h",this);
      //wait for reset
	 
	  // collect data 
      trans_h.rst = vif.rmon_cb.rst;
	  trans_h.rd_addr = vif.rmon_cb.rd_addr;
      trans_h.rd_enb = vif.rmon_cb.rd_enb;
      trans_h.rd_data = vif.rmon_cb.rd_data;		
   
   endtask
   
endclass