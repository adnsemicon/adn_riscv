/*

@foez---bhai, write the purpose of this module in markdown format here. This is already in multi-line comment, so don't add any additional comment syntax.

@foez---bhai, describe the use case of this module in markdown format here. This is already in multi-line comment, so don't add any additional comment syntax.

| REVISION | DATE       | AUTHOR          | DESCRIPTION                                            |
|----------|------------|-----------------|--------------------------------------------------------|
| 0.1      | 2026-11-23 | Reyad07 | Initial version                                        |
| 1.0      | 2026-11-23 | Reyad07 | Stable release                                         |

Author : Reyad07 (mreyad30207@gmail.com)
This file is part of adnsemicon/adn_riscv
Copyright (c) 2026 ADN Semiconductors
Licensed under the MIT License
See LICENSE file in the project root for full license information

*/

// @foez---bhai, add comments to the parameters, ports
module adn_riscv_instr_fetch #(
    parameter int XLEN    = 64,  // Data width of the processor
    parameter int DATA_WIDTH = 32
    // LOCALPARAMS
) (
    input logic                   clk_i,
    input logic                   arst_ni,

    input logic [XLEN-1:0]        bootaddr_i,
    output logic [XLEN-1:0]       icache_addr_o,
    output logic [XLEN-1:0]       pipeline_pc_o,
    input logic  [DATA_WIDTH-1:0] icache_data_i,
    output logic [DATA_WIDTH-1:0] pipeline_code_o,
    input logic                   icache_gnt_i,
    output logic                  pipeline_valid_o,
    input logic                   pipeline_ready_i,
    output logic                  icache_req_o,
    input logic                   exe_direct_load_next_i,
    input logic  [XLEN-1:0]       exe_next_addr_i,
    input logic  [XLEN-1:0]       exe_curr_addr_i,
    input logic                   exe_is_jump_i,
    output logic                  pipeline_clear_o

);

  // @foez---bhai, add comments to the functional blocks, signals, and submodules

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // LOCALPARAMS GENERATED
  //////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPEDEFS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  logic i_cen;
  logic arst_ni;
  logic [XLEN-1:0] current_addr_i;
  logic [XLEN-1:0] next_addr_i;
  logic [XLEN-1:0] pc_i;
  logic [XLEN-1:0] next_pc_o;
  logic [XLEN-1:0] m_mux_o; 
  logic is_jump_i;
  logic match_found_o;
  logic flush_o;
  logic c_mux;
  logic s1;
  logic s0;


  //////////////////////////////////////////////////////////////////////////////////////////////////
  // ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  assign icache_data_i = pipeline_code_o;
  assign pipeline_valid_o = icache_gnt_i & ~exe_direct_load_next_i;
  assign i_cen = icache_gnt_i & pipeline_ready_i;
  assign s1 = exe_direct_load_next_i;
  assign pc_mux = c_mux ? pc_o : bootaddr_i;

  always_comb begin
      m_mux_o = '0;
      case (s1,s0)
        2'b00: m_mux_o = pc_mux + 4;
        2'b01: m_mux_o = next_pc_o;
        2'b10,2'b11: m_mux_o = exe_next_addr_i;
      endcase
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SUBMODULES
  //////////////////////////////////////////////////////////////////////////////////////////////////
  adn_riscv_btb #(
    .NUM_BTB(NUM_BTB),
    .XLEN   (XLEN)
  ) u_adn_riscv_btb (
        .clk_i          ( clk_i)
        .arst_ni        ( arst_ni),
        .current_addr_i ( exe_curr_addr_i   ),
        .next_addr_i    ( exe_next_addr_i   ),   
        .pc_i           ( pc_mux            ),
        .is_jump_i      ( exe_is_jump_i     ),     
        .match_found_o  ( s0                ), 
        .flush_o        ( pipeline_clear_o  ),       
        .next_pc_o      ( next_pc_o         )     
    );


  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SEQUENTIALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // +1 counter
  always_ff @(posedge clk_i or negedge arst_ni) begin
      if (!arst_ni) begin
        c_mux <= '0;
      end
      else if (i_cen) begin
        c_mux <= c_mux + 1;
      end
  end
  
  // PC
  always_ff @(posedge clk_i or negedge arst_ni) begin
      if (!arst_ni) begin
        pc_o <= '0;
      end
      else if (i_cen) begin
        pc_o <= pc_o + 1;
      end
  end

`ifdef SIMULATION
  initial begin
    if (DATA_WIDTH > 2) begin
      $display("\033[1;33m%m DATA_WIDTH\033[0m");
    end
  end
`endif  // SIMULATION

endmodule

