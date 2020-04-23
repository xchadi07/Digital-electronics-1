# ALU - Aritmeticko-logická jednotka

## Úvod

Aritmeticko-logická jednotka (ALU, Arithmetic & Logic Unit) je jedna ze základních komponent procesoru, která zodpovída za aritmetické (sčítání, bitový posun,...) a logické (AND, OR,...) operace.

V našem projektu se nachází čtyřbitová jednotka s možností výběru vstupních hodnot A, B a operace.

## Operace

### Aritmetická část 
Hodnota | Operace
--------|--------
0000    | A + B
0001    | A - B
0010    | B - A
0011    | A * B
0100    | A + 1
0101    | A - 1

### Logická část
Hodnota | Operace
--------|--------
0110    | A rotace vpravo
0111    | A rotace vlevo
1000    | A << 1
1001    | A or B
1010    | A and B
1011    | A nand B
1100    | A nor B
1101    | A xor B
1110    | A xnor B
1111    | A = B ?

## Schémata
### Alu jednotka z ISE
![Alu_part.PNG](/Labs/images/Alu_part.PNG)

### Celkové zapojení
![projekt_schema.png](/Labs/images/projekt_schema.png)

### Celkové zapojení z ISE
![Top.JPG](/Labs/images/Top.jpg)

## Simulace

### Celková simulace ALU
![Alu_tb.PNG](/Labs/images/Alu_tb.png)

### Zkouška resetu
![alu_reset_test.PNG](/Labs/images/alu_reset_test.png)

### Ukázka zobrazení hodnot na jednotlivých displejích pro funkci A + B, kdy A = 8 a B = 4
Pro přehlednější ukázku byla změněna hodnota g_NPERIOD => x"0019" v modulu driver_7seg
![Top_sim.PNG](/Labs/images/Top_sim.png)

## Zdroje
* https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_ALU
* https://is.muni.cz/el/1433/podzim2004/PB151/um/15090.html
* https://www.fpga4student.com/2017/06/vhdl-code-for-arithmetic-logic-unit-alu.html
* https://moodle.vutbr.cz/pluginfile.php/183804/mod_resource/content/1/vhdl_kubicek.pdf
* http://www.et-pocitacovesystemy.wz.cz/cislicova_technika/komb_log_obvody/aritm_log_jednotka/alu.html
* https://gist.github.com/pauljohanneskraft/b3e9d8f27b62200da705b258b63bdd60
