module DMEM #(
    parameter DEPTH = 256,
    parameter DATA_PATH = "./data.hex"
)(
    input wire clk,
    input wire [15:0] addr,
    input wire [15:0] wdata,
    input wire we,
    output reg [15:0] rdata
);
    reg [15:0] dmem [0:DEPTH-1];
    integer i;

    initial begin
            for (i = 0; i < DEPTH; i = i + 1)
                dmem[i] = 16'h0000; // prefill zeros
            $readmemh(DATA_PATH, dmem);
    end
    

    always @(posedge clk) begin
        if (we) begin
            dmem[addr[7:0]] <= wdata;
        end
        rdata <= dmem[addr[7:0]];
    end
endmodule