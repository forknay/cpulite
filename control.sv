module CONTROL(
    input wire [15:0] ins,
    output reg [2:0] alu_op,
    output reg reg_write,
    output reg alu_src,
    output reg mem_write,
    output reg mem_to_reg,
    output reg beq,
    output reg bne,
    output reg jump,
    output reg link,
    output reg halt,
    output reg r2_sel
);
    wire [3:0] opcode = ins[15:12];

    always @(*) begin
        alu_op = 3'b000;
        reg_write = 0;
        alu_src = 0;
        mem_write = 0;
        mem_to_reg = 0;
        beq = 0;
        bne = 0;
        jump = 0;
        link = 0;
        halt = 0;
        r2_sel = 0; // [5:3] rtype, [11:9] branch and sw
        case (opcode)
            4'h0: begin
                halt = 1;
            end
            4'h1: begin // alu
                reg_write = 1;
            end
            4'h2: begin // alu
                reg_write = 1;
                alu_op = 3'b001;
            end
            4'h3: begin // alu
                reg_write = 1;
                alu_op = 3'b010;
            end
            4'h4: begin // alu
                reg_write = 1;
                alu_op = 3'b011;
            end
            4'h5: begin // alu
                reg_write = 1;
                alu_op = 3'b100;
            end
            4'h6: begin // alu
                reg_write = 1;
                alu_op = 3'b101;
            end
            4'h7: begin // alu
                reg_write = 1;
                alu_op = 3'b110;
            end
            4'h8: begin // alu
                reg_write = 1;
                alu_op = 3'b111;
            end
            4'h9: begin // alu imm
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b000;
            end
            4'hA: begin // lw
                reg_write = 1;
                mem_to_reg = 1;
                alu_src = 1;
            end
            4'hB: begin // sw
                mem_write = 1;
                alu_src = 1;
                r2_sel = 1;
            end
            4'hC: begin // beq
                beq = 1;
                alu_op = 3'b001;
                r2_sel = 1;
            end
            4'hD: begin // bne
                bne = 1;
                alu_op = 3'b001;
                r2_sel = 1;
            end
            4'hE: begin // jump
                jump = 1;
            end
            4'hF: begin // jal
                reg_write = 1;
                jump = 1;
                link = 1;
            end
        endcase
    end
endmodule