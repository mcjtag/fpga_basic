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
