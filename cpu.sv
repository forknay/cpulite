module CPU(
    input wire clk,
    input wire rst_n,
    output wire halted
);
    // Instantiate connections
    wire [15:0] ins;
    wire [2:0] alu_op;
    wire reg_write;
    wire alu_src;
    wire mem_write;
    wire mem_to_reg;
    wire beq;
    wire bne;
    wire jump;
    wire link;
    wire halt;
    wire r2_sel;

    wire pc_en;
    wire [15:0] target;
    wire [15:0] pc;
    
    wire [2:0] opcode;
    wire [15:0] alu_a;
    wire [15:0] alu_b;
    wire status_in;
    wire [15:0] alu_result;
    wire [3:0] status_out;
    wire [15:0] addr;
    wire [15:0] wdata_dm;
    wire [15:0] rdata_dm;

    wire we_rf;
    wire we_dm;
    wire [2:0] waddr;
    wire [15:0] wdata_rf;
    wire [2:0] raddr1;
    wire [2:0] raddr2;
    wire [15:0] rdata1;
    wire [15:0] rdata2;

endmodule