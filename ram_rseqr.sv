

class ram_rseqr extends uvm_sequencer #(ram_rtrans);

  `uvm_component_utils(ram_rseqr)
   
   function new (string name = "ram_rseqr", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
   
endclass