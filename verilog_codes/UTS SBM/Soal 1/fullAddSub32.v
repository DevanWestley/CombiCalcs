module fullAddSub32(
  num1,
  num2,
  op,
  sumO,
  carryO
);

  input [31:0] num1;		// input 1 berukuran 32 bit
  input [31:0] num2;		// input 2 berukuran 32 bit
  input op; 			// sinyal kendali operasi, 0 untuk penjumalahan dan 1 untuk pengurangan
  output [31:0] sumO;		// hasil akhir penjumlahan atau pengurangan
  output carryO;		// nilai carry out
  
// komponen-komponen wire yang digunakan untuk perhitungan
  wire [31:0] sum;		// menyimpan hasil sementara penjumlahan atau pengurangan
  wire [31:0] carry;		// menyimpan nilai carry
  wire [31:0] num2C;		// komplemen untuk pengurangan

// menentukan nilai num2C
// jika op == 1 (pengurangan), maka num2 akan dikomplemen bitwise menjadi ~num2
// jika op == 0 (penjumlahan), maka num2 tetap
  assign num2C = (op == 1'b1) ? ~num2 : num2;

// loop penjumlahan
// menggunakan generate loop untuk membuat 32 instance fullAdder
// untuk bit ke-0, masukkan carry-in adalah op
// untuk bit ke 1-31 masukkan carry-in adalah carry[i-1]

  genvar i;
  generate 
    for (i = 0; i < 32; i = i + 1) begin : gen_block
      if (i == 0) 
        fullAdder addr0 ( num1[i], num2C[i], op, sum[i], carry[i]);
      else
        fullAdder addrN ( num1[i], num2C[i], carry[i-1], sum[i], carry[i]);
    end
  endgenerate

// penyesuaian nilai carry-out
// jika op == 1 (pengurangan), maka carry[31] akan di komplemen
// jika penjumlahan, akan langsung diambil dari carry[31]
  assign carryO = (op == 1'b1) ? ~carry[31] : carry[31];

// nilai akhir penjumlahan atau pengurangan
  assign sumO = sum;
  
endmodule
