// Basic sequence item (transaction)

class seq_item extends uvm_sequence_item;

  rand bit is_write;
  rand bit [31:0] addr;
  rand bit [31:0] wdata;
       bit [31:0] rdata;

  constraint c_simple_addr {
    addr[1:0] == 2'b0; 
    addr inside { [32'h0 : 32'h1000] };
  }
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(is_write, UVM_ALL_ON)
    `uvm_field_int(addr,     UVM_ALL_ON | UVM_HEX) 
    `uvm_field_int(wdata,    UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(rdata,    UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

  function new(string name = "seq_item");
    super.new(name);
  endfunction;

function string convert2string();
    string s;
    $sformat(s, "AXI Tx: %s Addr: 0x%h, WData: 0x%h, RData: 0x%h",
             (is_write ? "WRITE" : "READ "),
             addr, wdata, rdata);
    return s;
  endfunction;

endclass : seq_item

