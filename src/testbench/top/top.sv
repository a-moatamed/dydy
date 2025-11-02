// top.sv
`include "uvm_macros.svh"
import uvm_pkg::*;

module top;
    // Parameters for DUT
    localparam ADDR_WIDTH = 32;
    localparam DATA_WIDTH = 32;

    // Clock and Reset Signals
    logic clk;
    logic rst_n;

    // Instantiate the interface
    my_if #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) axi_vif (
        .ACLK(clk),
        .ARESETn(rst_n)
    );

    axi_register_slice_v2_1_22_axi_register_slice #(
        .C_AXI_DATA_WIDTH(DATA_WIDTH),
        .C_AXI_ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        // Global Signals
        .aclk(axi_vif.ACLK),
        .aresetn(axi_vif.ARESETn),

        // Slave Interface
        .s_axi_awaddr(axi_vif.S_AXI_AWADDR),
        .s_axi_awprot(axi_vif.S_AXI_AWPROT),
        .s_axi_awvalid(axi_vif.S_AXI_AWVALID),
        .s_axi_awready(axi_vif.S_AXI_AWREADY),
        .s_axi_wdata(axi_vif.S_AXI_WDATA),
        .s_axi_wstrb(axi_vif.S_AXI_WSTRB),
        .s_axi_wvalid(axi_vif.S_AXI_WVALID),
        .s_axi_wready(axi_vif.S_AXI_WREADY),
        .s_axi_bresp(axi_vif.S_AXI_BRESP),
        .s_axi_bvalid(axi_vif.S_AXI_BVALID),
        .s_axi_bready(axi_vif.S_AXI_BREADY),
        .s_axi_araddr(axi_vif.S_AXI_ARADDR),
        .s_axi_arprot(axi_vif.S_AXI_ARPROT),
        .s_axi_arvalid(axi_vif.S_AXI_ARVALID),
        .s_axi_arready(axi_vif.S_AXI_ARREADY),
        .s_axi_rdata(axi_vif.S_AXI_RDATA),
        .s_axi_rresp(axi_vif.S_AXI_RRESP),
        .s_axi_rvalid(axi_vif.S_AXI_RVALID),
        .s_axi_rready(axi_vif.S_AXI_RREADY),

        // Master Interface
        .m_axi_awaddr(axi_vif.M_AXI_AWADDR),
        .m_axi_awprot(axi_vif.M_AXI_AWPROT),
        .m_axi_awvalid(axi_vif.M_AXI_AWVALID),
        .m_axi_awready(axi_vif.M_AXI_AWREADY),
        .m_axi_wdata(axi_vif.M_AXI_WDATA),
        .m_axi_wstrb(axi_vif.M_AXI_WSTRB),
        .m_axi_wvalid(axi_vif.M_AXI_WVALID),
        .m_axi_wready(axi_vif.M_AXI_WREADY),
        .m_axi_bresp(axi_vif.M_AXI_BRESP),
        .m_axi_bvalid(axi_vif.M_AXI_BVALID),
        .m_axi_bready(axi_vif.M_AXI_BREADY),
        .m_axi_araddr(axi_vif.M_AXI_ARADDR),
        .m_axi_arprot(axi_vif.M_AXI_ARPROT),
        .m_axi_arvalid(axi_vif.M_AXI_ARVALID),
        .m_axi_arready(axi_vif.M_AXI_ARREADY),
        .m_axi_rdata(axi_vif.M_AXI_RDATA),
        .m_axi_rresp(axi_vif.M_AXI_RRESP),
        .m_axi_rvalid(axi_vif.M_AXI_RVALID),
        .m_axi_rready(axi_vif.M_AXI_RREADY)
    );

    // Clock Generation (e.g., 100MHz)
    initial begin
        clk = 0;
        forever #5ns clk = ~clk;
    end

    // Reset Generation and Test Start
    initial begin
        // Pass virtual interface to UVM environment
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top", "vif", axi_vif);

        // Drive reset
        rst_n = 1'b0;
        #20ns;
        rst_n = 1'b1;

        // Run the UVM test
        run_test();
    end

endmodule
