module PC #(
    parameter PROGRAM = "./insmem.hex",
    parameter DEPTH = 256
)(
    input wire clk,
    input wire pc_en,
    input wire rst_n,
    output reg [15:0] pc,
    output wire [15:0] ins
);
    reg [15:0] insmem [0:DEPTH-1];
    integer i;

    initial begin
        for (i = 0; i < DEPTH; i = i + 1)
            insmem[i] = 16'h0000; // prefill zeros
        $readmemh(PROGRAM, insmem);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pc <= 0;
        else if (pc_en) pc <= pc + 1;
    end

    assign ins = insmem[pc[7:0]];

endmodule