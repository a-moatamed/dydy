// agents/monitor.sv
class my_monitor extends uvm_component;
  `uvm_component_utils(my_monitor)

  // Virtual Interface Handle
  virtual my_if vif;

  // Analysis Port to broadcast transactions to the Scoreboard
  uvm_analysis_port #(seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Initialize the analysis port
    ap = new("ap", this);
    
    // Get the interface handle
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "virtual interface not set for monitor")
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
 
    fork
      collect_writes();
      collect_reads();
    join_none
  endtask : run_phase

  //WRITE CHANNEL MONITOR 
  task collect_writes();
    seq_item tr;
    forever begin

      @(posedge vif.ACLK);
      while (!(vif.S_AXI_AWVALID && vif.S_AXI_AWREADY)) @(posedge vif.ACLK);
      
      tr = seq_item::type_id::create("tr_write");
      tr.is_write = 1;
      tr.addr     = vif.S_AXI_AWADDR;


      while (!(vif.S_AXI_WVALID && vif.S_AXI_WREADY)) @(posedge vif.ACLK);
      tr.wdata    = vif.S_AXI_WDATA;

      while (!(vif.S_AXI_BVALID && vif.S_AXI_BREADY)) @(posedge vif.ACLK);
      
      // Publish the transaction
      `uvm_info("MONITOR", $sformatf("Saw WRITE: Addr=0x%h Data=0x%h", tr.addr, tr.wdata), UVM_MEDIUM)
      ap.write(tr);
    end
  endtask

  //READ CHANNEL MONITOR
  task collect_reads();
    seq_item tr;
    forever begin
  
      @(posedge vif.ACLK);
      while (!(vif.S_AXI_ARVALID && vif.S_AXI_ARREADY)) @(posedge vif.ACLK);
      

      tr = seq_item::type_id::create("tr_read");
      tr.is_write = 0;
      tr.addr     = vif.S_AXI_ARADDR;


      while (!(vif.S_AXI_RVALID && vif.S_AXI_RREADY)) @(posedge vif.ACLK);
      tr.rdata    = vif.S_AXI_RDATA;

      // Publish the transaction
      `uvm_info("MONITOR", $sformatf("Saw READ:  Addr=0x%h Data=0x%h", tr.addr, tr.rdata), UVM_MEDIUM)
      ap.write(tr);
    end
  endtask

endclass : my_monitor