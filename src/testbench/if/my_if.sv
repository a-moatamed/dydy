// my_if.sv
interface my_if #(
    parameter int ADDR_WIDTH = 32,
    parameter int DATA_WIDTH = 32
) (
    input logic ACLK,
    input logic ARESETn
);

    // Slave Interface (Inputs to the DUT)
    // Write Address Channel
    logic                       S_AXI_AWVALID;
    logic                       S_AXI_AWREADY;
    logic [ADDR_WIDTH-1:0]      S_AXI_AWADDR;
    logic [7:0]                 S_AXI_AWPROT; // Or [2:0] for AXI3

    // Write Data Channel
    logic                       S_AXI_WVALID;
    logic                       S_AXI_WREADY;
    logic [DATA_WIDTH-1:0]      S_AXI_WDATA;
    logic [DATA_WIDTH/8-1:0]    S_AXI_WSTRB;
    logic                       S_AXI_WLAST;

    // Write Response Channel
    logic                       S_AXI_BVALID;
    logic                       S_AXI_BREADY;
    logic [1:0]                 S_AXI_BRESP;

    // Read Address Channel
    logic                       S_AXI_ARVALID;
    logic                       S_AXI_ARREADY;
    logic [ADDR_WIDTH-1:0]      S_AXI_ARADDR;
    logic [7:0]                 S_AXI_ARPROT; // Or [2:0] for AXI3

    // Read Data Channel
    logic                       S_AXI_RVALID;
    logic                       S_AXI_RREADY;
    logic [DATA_WIDTH-1:0]      S_AXI_RDATA;
    logic [1:0]                 S_AXI_RRESP;
    logic                       S_AXI_RLAST;


    // Master Interface (Outputs from the DUT)
    // Write Address Channel
    logic                       M_AXI_AWVALID;
    logic                       M_AXI_AWREADY;
    logic [ADDR_WIDTH-1:0]      M_AXI_AWADDR;
    logic [7:0]                 M_AXI_AWPROT;

    // Write Data Channel
    logic                       M_AXI_WVALID;
    logic                       M_AXI_WREADY;
    logic [DATA_WIDTH-1:0]      M_AXI_WDATA;
    logic [DATA_WIDTH/8-1:0]    M_AXI_WSTRB;
    logic                       M_AXI_WLAST;

    // Write Response Channel
    logic                       M_AXI_BVALID;
    logic                       M_AXI_BREADY;
    logic [1:0]                 M_AXI_BRESP;

    // Read Address Channel
    logic                       M_AXI_ARVALID;
    logic                       M_AXI_ARREADY;
    logic [ADDR_WIDTH-1:0]      M_AXI_ARADDR;
    logic [7:0]                 M_AXI_ARPROT;

    // Read Data Channel
    logic                       M_AXI_RVALID;
    logic                       M_AXI_RREADY;
    logic [DATA_WIDTH-1:0]      M_AXI_RDATA;
    logic [1:0]                 M_AXI_RRESP;
    logic                       M_AXI_RLAST;

endinterface
