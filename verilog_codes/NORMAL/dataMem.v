module dataMem(
    address,
    writeData,
    readData,
    memWrite,
    memRead
);

    input wire memRead; // 1: Read, 0: No Read
    input wire memWrite; // 1: Write, 0: No Write
    input wire [31:0] address;
    input wire [31:0] writeData;
    output reg [31:0] readData;

    reg [31:0] memory [1023:0]; 
    
    always @(address or memRead) begin
        if (memRead == 1'b1) begin
            readData = memory[address[11:2]]; 
        end
    end

    always @(posedge memWrite) begin
        if (memWrite == 1'b1) begin
            memory[address[11:2]] = writeData; // Write data to memory
        end
    end

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'b0;
        end
        
// beberapa test value memori
        memory[0] = 32'hA000000A;
        memory[1] = 32'hB000000B;
        memory[2] = 32'hC000000C;
        memory[3] = 32'hD000000D;
    end
endmodule