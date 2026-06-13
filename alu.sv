module ALU(
    input wire [2:0] opcode,
    input wire [15:0] op1,
    input wire [15:0] op2,
    input wire status_in,
    output reg [15:0] res,
    output reg [3:0] status_out
);
    // temp to avoid overflow
    reg [16:0] temp_res;
    // zero, negative, carry, overflow
    reg z_flag, n_flag, c_flag, v_flag;

    always @(*)
    begin
        temp_res = 17'h00000;
        res = 16'h0000;

        case (opcode)
            3'b000: temp_res = op1 + op2 + status_in;
            3'b001: temp_res = op1 + (~op2) + status_in;
            3'b010: temp_res = op1 & op2;
            3'b011: temp_res = op1 | op2;
            3'b100: temp_res = op1 ^ op2;
            3'b101: temp_res = op1 << op2[3:0]; // lsl
            3'b110: temp_res = op1 >> op2[3:0]; // lsr
            3'b111: temp_res = ($signed(op1) < $signed(op2)) ? 1 : 0;
        endcase

        z_flag = (temp_res[15:0] == 0); // lowkey isnt be zero but convention
        n_flag = temp_res[15];
        // carry only possible with + or -
        if (opcode == 3'b000) begin
            c_flag = temp_res[16];
            v_flag = (~(op1[15] ^ op2[15])) & (temp_res[15] ^ op1[15]);
        end else if (opcode == 3'b001) begin
            c_flag = temp_res[16];
            v_flag = (op1[15] ^ op2[15]) & (temp_res[15] ^ op1[15]);
        end else begin
            c_flag = 0;
            v_flag = 0;
        end
        res = temp_res[15:0];
        status_out = {z_flag, n_flag, c_flag, v_flag};
    end
endmodule