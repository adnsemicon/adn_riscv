# adn_riscv_instr_fetch (module)

### Author: Reyad07 (mreyad30207@gmail.com)

### Source: adn_riscv_instr_fetch.sv

## Top IO

<img src="./adn_riscv_instr_fetch_top.svg">

<img src="./adn_riscv_instr_fetch_des.svg">

## Parameters

|Name|Type|Dimension|Default|Description|
|-|-|-|-|-|
|XLEN|int||64|Data width of the processor|
|DATA_WIDTH|int||32||
|NUM_BTB|int||32||


## Ports

|Name|Direction|Type|Dimension|Description|
|-|-|-|-|-|
|clk_i|input|logic|||
|arst_ni|input|logic|||
|bootaddr_i|input|logic [XLEN-1:0]|||
|icache_addr_o|output|logic [XLEN-1:0]|||
|pipeline_pc_o|output|logic [XLEN-1:0]|||
|icache_data_i|input|logic [DATA_WIDTH-1:0]|||
|pipeline_code_o|output|logic [DATA_WIDTH-1:0]|||
|icache_gnt_i|input|logic|||
|pipeline_valid_o|output|logic|||
|pipeline_ready_i|input|logic|||
|icache_req_o|output|logic|||
|exe_direct_load_next_i|input|logic|||
|exe_next_addr_i|input|logic [XLEN-1:0]|||
|exe_curr_addr_i|input|logic [XLEN-1:0]|||
|exe_is_jump_i|input|logic|||
|pipeline_clear_o|output|logic|||


## Description

@foez---bhai, write the purpose of this module in markdown format here. This is already in multi-line comment, so don't add any additional comment syntax.

@foez---bhai, describe the use case of this module in markdown format here. This is already in multi-line comment, so don't add any additional comment syntax.

| REVISION | DATE       | AUTHOR          | DESCRIPTION                                            |
|----------|------------|-----------------|--------------------------------------------------------|
| 0.1      | 2026-11-23 | Reyad07 | Initial version                                        |
| 1.0      | 2026-11-23 | Reyad07 | Stable release                                         |

Author : Reyad07 (mreyad30207@gmail.com)
