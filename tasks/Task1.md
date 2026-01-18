Task 1. Deadlines: Oct 28 / Nov 4

- Clone the template repository and add your information in the root README.
- Generate the RTL sources for your chosen IP (e.g., AXI GPIO):
  - `make -C run sources ip_name=<ip_name>`
- Populate the testbench interface `src/testbench/if/my_if.sv` with all signals required by your DUT.
- Instantiate the DUT in `src/testbench/top/top.sv`, connect the interface signals, and add a clock generator and initial reset sequence.
- Run a simulation to verify everything builds and runs:
  - Batch: `make -C run run_sim`
  - GUI: `make -C run gui`
  - View existing waves: `make -C run view`
