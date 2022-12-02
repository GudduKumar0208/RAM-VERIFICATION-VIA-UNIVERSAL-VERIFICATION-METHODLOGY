
class ram_env extends uvm_env;

    `uvm_component_utils(ram_env)
	
	ram_wagent wagent_h;
	ram_ragent ragent_h;
    ram_sb sb_h;
    ram_virtual_sequencer v_seqrh;
	ram_config config_h;
   function new (string name = "ram_env", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 wagent_h = ram_wagent::type_id::create("wagent_h",this);
	 ragent_h = ram_ragent::type_id::create("ragent_h",this);
	 sb_h=ram_sb::type_id::create("sb_h",this);
	 config_h=ram_config::type_id::create("config_h",this);
	 //VIRTUAL SEQUENCER BUILD
   v_seqrh=ram_virtual_sequencer::type_id::create(" v_seqrh",this);

   endfunction

  function void connect_phase (uvm_phase phase);
  if (config_h.scoreboard==1)

wagent_h.wmon_h.wr_port.connect(sb_h.wr_fifo.analysis_export);  
ragent_h.rmon_h.rd_port.connect(sb_h.rd_fifo.analysis_export);


//virtual sequence connection

v_seqrh.wr_seqrh=wagent_h.wseqr_h;
v_seqrh.rd_seqrh=ragent_h.rseqr_h;
   endfunction
endclass