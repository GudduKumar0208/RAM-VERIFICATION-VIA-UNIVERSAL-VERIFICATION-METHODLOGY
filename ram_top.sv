
module ram_top();


     import uvm_pkg::*;

   `include "uvm_macros.svh"
//`include "ram_test.sv"
  import ram_pkg::*;
  bit clk;
  bit rst;
  ram_if inf(clk);
   
  
  //dut instantiation
     ram DUT (.clk(clk),
            .rst(inf.rst),
			.wr_enb(inf.wr_enb),
			.rd_enb(inf.rd_enb),
			.rd_addr(inf.rd_addr),
			.wr_addr(inf.wr_addr),
			.rd_data(inf.rd_data),
			.wr_data(inf.wr_data));
			
  
  always
   #5 clk = ~clk;
   
   initial begin
	 uvm_config_db #(virtual ram_if)::set(null,"*","vif",inf);
	 //run_test("ram_test");
run_test("ram_small_test");
run_test();
   end
   
endmodule