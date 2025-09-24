module regsFile( 
    rgr1,
    rgr2,
    write,
    rgw1,
    rgw1data,
    rg1data,
    rg2data
);

    input [4:0] rgr1;		// alamat register ke-1
    input [4:0] rgr2;		// alamat register ke-2
    input [4:0] rgw1;		// alamat register tujuan penulisan
    input [31:0]  rgw1data;	// data yang akan ditulis ke rgw1
    input write;		// sinyal tulis atau write enable
    output reg [31:0] rg1data;	// output dari rgr1
    output reg [31:0] rg2data;	// output dari rgr2
    
    reg [31:0] regMem [31:0];	// register memory, ada 32 register masing-masing 32 bit

// proses pembacaan register
// saat rgr1 atau rgr2 berubah nilainya, maka output rg1data atau rg2data akan langsung diperbarui sesuai isi register
  always @(rgr1 or rgr2)
  begin
    rg1data = regMem[rgr1];
    rg2data = regMem[rgr2];
  end

// proses penulisan ke register

  always @(posedge write)
  begin
    if(rgw1 == 5'b0) regMem[0] = 5'b0;
    else regMem[rgw1] = rgw1data;
  end

    integer i;

    initial 
    begin
        //set all register values to reg number 
        for( i = 0; i < 32; i = i + 1 )
            regMem[i] = i;
    end
endmodule