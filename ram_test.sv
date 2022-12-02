//import ram_pkg::*;
class ram_test extends uvm_test;
 
  `uvm_component_utils(ram_test)

  ram_env env_h;
random_virtual_sequences test_seq;
  //ram_base_wseqs wseqs_h;
  //ram_base_rseqs rseqs_h;
  
  function new (string name = "ram_test", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
  function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 env_h = ram_env::type_id::create("env_h",this);
   endfunction
  
  //for printing topology
  
   
  /*task run_phase (uvm_phase phase);
   phase.raise_objection(this);
	 //creates sequences
	  wseqs_h=ram_base_wseqs::type_id::create("wseqs_h");
      rseqs_h=ram_base_rseqs::type_id::create("rseqs_h");
	fork
	wseqs_h.start(env_h.wagent_h.wseqr_h);
     rseqs_h.start(env_h.ragent_h.rseqr_h);	 
	join
	phase.drop_objection(this);
	
  endtask
  */
endclass