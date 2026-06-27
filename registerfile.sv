module REGISTERFILE(
    input wire clk,
    input wire rst_n,
    input wire we,
    input wire [2:0] waddr,
    input wire [15:0] wdata,
    input wire [2:0] raddr1,
    input wire [2:0] raddr2,
    output wire [15:0] rdata1,
    output wire [15:0] rdata2
);

    // declare memory array
    reg [15:0] reg_file [0:7];

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 8; i = i + 1) begin
                reg_file[i] <= 16'd0;
            end
        end else if (we) begin
            if (waddr != 0) begin
                reg_file[waddr] <= wdata;
            end
        end
    end

    assign rdata1 = (raddr1 == 0) ? 16'd0 : reg_file[raddr1];
    assign rdata2 = (raddr2 == 0) ? 16'd0 : reg_file[raddr2];
endmodule