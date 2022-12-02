// virtual sequencer

class ram_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

 `uvm_component_utils(ram_virtual_sequencer)
function new (string name ="ram_virtual_sequencer",uvm_component parent=null);
super.new(name,parent);
endfunction
//ram sequencers
 ram_wseqr wr_seqrh;
 ram_rseqr rd_seqrh;

endclass :ram_virtual_sequencer




//virtual sequences
class virtual_sequence_base extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils (virtual_sequence_base)


ram_wseqr w_seqrh;
ram_rseqr r_seqrh;
ram_virtual_sequencer v_seqrh;

//ram sequence and if not want to make random virtual class
ram_base_wseqs rand_wseqs_h;
ram_base_rseqs rand_rseqs_h;

function new(string name="virtual_sequence_base");
super.new(name);
endfunction
 
task body();
if(!$cast (v_seqrh,m_sequencer))// begin //m_sequencer is inbuilt sequencer of uvm_sequence 
                                        //m_sequencer points the every start sequence in any class
`uvm_error (get_full_name(),"virtual sequencer pointer cast failed ");
//end
w_seqrh=v_seqrh.wr_seqrh;
r_seqrh=v_seqrh.rd_seqrh;

// in case dont want to make different random virtual class 


rand_wseqs_h=ram_base_wseqs::type_id::create("rand_wseqs_h");
rand_rseqs_h=ram_base_rseqs::type_id::create("rand_rseqs_h");



repeat (20) begin
rand_wseqs_h.start(w_seqrh);
rand_rseqs_h.start(r_seqrh);
end //till here its the thing of random virtual class task
endtask :body
endclass







/*
//random virtual seq

//its like the w or rtrans which randomises the sequences 
class random_virtual_sequences extends virtual_sequence_base ;

ram_base_wseqs rand_wseqs_h;
ram_base_rseqs rand_rseqs_h;

task body();

rand_wseqs_h=ram_base_wseqs::type_id::create("rand_wseqs_h");
rand_rseqs_h=ram_base_rseqs::type_id::create("rand_rseqs_h");



repeat (20) begin
rand_wseqs_h.start(w_seqrh);
rand_rseqs_h.start(r_seqrh);
end
endtask
endclass*/
