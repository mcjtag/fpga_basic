# fpga_basic
FPGA basic digital devices. Parameterized, synthesized, general-purpose.

## Combinatorial

* Encoder
* Decoder
* Multiplexer
* Demultiplexer
* Majority Funtion (Median Operator)

### Encoder

##### Parameters
* `DATA_WIDTH` - width of input data
##### Ports
* `din`  - input data (width = DATA_WIDTH)
* `dout` - output encoded data (width = log2(DATA_WIDTH))
* `err`  - error flag (invalid input)

### Decoder

##### Parameters
* `DATA_WIDTH` - width of input data
##### Ports
* `din`  - input data (width = DATA_WIDTH)
* `dout` - output decoded data (width = 2^DATA_WIDTH)

### Multiplexer

##### Parameters
* `DATA_WIDTH` - width of input channel
* `CHAN_NUM`   - number of channels
* `SEL_WIDTH`  - select width (default value = log2(CHAN_NUM))
##### Ports
* `din`  - input data (width = DATA_WIDTH*CHAN_NUM)
* `sel`  - select (width = SEL_WIDTH)
* `dout` - output multiplexed data (width = DATA_WIDTH)

### Demultiplexer

##### Parameters
* `DATA_WIDTH` - width of input channel
* `CHAN_NUM`   - number of channels
* `SEL_WIDTH`  - select width (default value = log2(CHAN_NUM))
##### Ports
* `din`  - input data (width = DATA_WIDTH)
* `sel`  - select (width = SEL_WIDTH)
* `dout` - output demultiplexed data (width = DATA_WIDTH*CHAN_NUM)

### Majority function (Median Operator)

##### Parameters
* `DATA_WIDTH` - width of input data
##### Ports
* `din` - input data (width = DATA_WIDTH)
* `do`  - output bit

## Memory (RAM and ROM)

* DPRAM
* DPROM
* SDPRAM
* SPRAM
* SPROM
* TDPRAM

### DPRAM (Dual Port RAM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_VALUE`  - initialization Value
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `dina`  - input data (channel: A, width = DATA_WIDTH)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `addrb` - input address (channel: B, width = ADDR_WIDTH)
* `wea`   - write enable flag (channel: A)
* `douta` - output data (channel: A, width = DATA_WIDTH)
* `doutb` - output data (channel: B, width = DATA_WIDTH)

### DPROM (Dual Port ROM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `ena`   - enable (channel: A)
* `enb`   - enable (channel: B)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `addrb` - input address (channel: B, width = ADDR_WIDTH)
* `douta` - output data (channel: A, width = DATA_WIDTH)
* `doutb` - output data (channel: B, width = DATA_WIDTH)

### SDPRAM (Simple Dual Port RAM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_VALUE`  - initialization Value
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `dina`  - input data (channel: A, width = DATA_WIDTH)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `addrb` - input address (channel: B, width = ADDR_WIDTH)
* `wea`   - write enable flag (channel: A)
* `doutb` - output data (channel: B, width = DATA_WIDTH)

### SPRAM (Single Port RAM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_VALUE`  - initialization Value
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `dina`  - input data (channel: A, width = DATA_WIDTH)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `wea`   - write enable flag (channel: A)
* `douta` - output data (channel: A, width = DATA_WIDTH)

### SPROM (Single Port ROM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `ena`   - enable (channel: A)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `douta` - output data (channel: A, width = DATA_WIDTH)

### TDPRAM (True Dual Port RAM)

##### Parameters
* `MEMORY_TYPE` - memory type/style ("block" or "distributed") 
* `DATA_WIDTH`  - data Width
* `ADDR_WIDTH`  - address Width
* `INIT_VALUE`  - initialization Value
* `INIT_FILE`   - initialization filename
##### Ports
* `clk`   - input clock
* `dina`  - input data (channel: A, width = DATA_WIDTH)
* `dinb`  - input data (channel: B, width = DATA_WIDTH)
* `addra` - input address (channel: A, width = ADDR_WIDTH)
* `addrb` - input address (channel: B, width = ADDR_WIDTH)
* `wea`   - write enable flag (channel: A)
* `web`   - write enable flag (channel: B)
* `douta` - output data (channel: A, width = DATA_WIDTH)
* `doutb` - output data (channel: B, width = DATA_WIDTH)

## FIFO

##### Parameters
* `DATA_WIDTH` - data width
* `DATA_DEPTH` - fifo depth
* `MODE`       - fifo mode ("std" - standard, "fwft" - first word fall through)            
##### Ports
* `clk`   - input clock
* `rst`   - reset (syncronous, active-HIGH)
* `din`   - input data (width = DATA_WIDTH)
* `wr_en` - write enable
* `full`  - full flag
* `dout`  - output data (width = DATA_WIDTH)
* `rd_en` - read enable
* `empty` - empty flag
* `valid` - valid flag
 