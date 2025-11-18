// Basic example sequence that produces seq_item transactions

class basic_sequence extends uvm_sequence #(seq_item);
  `uvm_object_utils(basic_sequence)

  function new(string name = "basic_sequence");
    super.new(name);
  endfunction;

  virtual task body();
    seq_item req;

    `uvm_info(get_type_name(), "Starting sequence (1-write, 1-read)", UVM_MEDIUM)
    
    req = seq_item::type_id::create("req_write");
    
    assert(req.randomize() with { 
      is_write == 1; 
    });
    
    `uvm_info(get_type_name(), $sformatf("Sending WRITE Tx: Addr=0x%h, Data=0x%h", req.addr, req.wdata), UVM_MEDIUM)
    
    start_item(req); 
    finish_item(req); 
    
    req = seq_item::type_id::create("req_read");
    
    assert(req.randomize() with { 
      is_write == 0; 
    });
    
    `uvm_info(get_type_name(), $sformatf("Sending READ Tx: Addr=0x%h", req.addr), UVM_MEDIUM)
    
    start_item(req);
    finish_item(req); 

    `uvm_info(get_type_name(), $sformatf("READ Tx complete, RData=0x%h", req.rdata), UVM_MEDIUM)
    
    `uvm_info(get_type_name(), "Finished sequence", UVM_MEDIUM)

  endtask : body
endclass : basic_sequence
