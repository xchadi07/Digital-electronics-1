# ALU - Aritmeticko-logická jednotka

## Úvod

Aritmeticko-logická jednotka (ALU, Arithmetic & Logic Unit) je jedna ze základních komponent procesoru, která zodpovída za aritmetické (sčítání, bitový posun,...) a logické (AND, OR,...) operace.

## Tento projekt
* čtyřbitová jednotka
* možnost výběru vstupních hodnot A, B a operace
* indikace nulového výsledku, záporného znaménka a carry bitu
* synchronní reset
* zobrazení vstupních hodnot (vč. hodnoty pro operaci) a výsledku na sedmisegmentovém displeji
* implementace top vrstvy na CoolRunner-II CPLD starter board XC2C256-TQ144
Jednotka počítá s hodnotami typu unsigned, ale na displeji se zobrazují jako jako typ signed se signalizací záporného znaménka pomocí led diody, kvůli přepočítání podle dvojkového doplňku. Čtyřbytová jednotka může dosáhnout maximální kladné hodnoty 7 a další hodnoty se přepočítají na záporné (viz. obrázek). Tento převod jsme provedli stanovením podmínky v modulu ALU, kdy se při hodnotách výsledku větších nebo rovných 8 signalizuje záporná hodnota a pomocí modulu hex_to_7seg, kde jsme implementovali hodnoty 9 a vyšší jako hodnoty 7, 6,...,1.

### Dvojkový doplňek
![dvojk_dop.PNG](/Labs/images/dvojk_dop.PNG)
## vstupy
Název     | Popis | Velikost |
------    |-------|----------|
a_i, b_i  | vstupní hodnoty | 4 bity
op_i      | výběr operace | 4 bity
clk_i     | clock | 1 bit
alu_en_i  | alu/ clock enable | 1 bit
srst_i    | reset | 1 bit

## výstupy
Název     | Popis | Velikost |
------    |-------|----------|
zero_o    | signalzace výsledku "0" | 1 bit
zapor_zn_o| signalizace záporného znaménka výsledku | 1 bit
carry_o   | signalizace carry bitu | 1 bit
res_o     | výsledek | 4 bity


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
0110    | A ROR
0111    | A ROL
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
Jednotka používá 12 switchů, pomocí kterých se nastavují vstupní hodnoty A, B a operace a 1 resetovací tlačítko. Výstupy pro signalizaci carry bitu, výsledku "0" a záporného znaménka jsou zapojeny do led diod. Pomocí modulu driver_7seg a hex_to_7seg se vstupní hodnoty (vč. hodnoty pro operaci) a výsledek zobrazují na sedmisegmentovém displeji.

## Simulace

### Celková simulace ALU
![Alu_tb_2.PNG](/Labs/images/Alu_tb_2.PNG)

### Zkouška resetu
![alu_reset_test.PNG](/Labs/images/alu_reset_test.png)

### Reset za chodu
![rst_zachodu_2.PNG](/Labs/images/rst_zachodu_2.PNG)

### Ukázka zobrazení hodnot na jednotlivých displejích pro funkci A + B, kdy A = 8 a B = 4
Pro přehlednější ukázku byla změněna hodnota g_NPERIOD => x"0019" v modulu driver_7seg. 
Výsledek výpočtu je C, ale v našem případě je zobrazen jako 4 s indikací záporného znaménka.
![top_sim_2.PNG](/Labs/images/top_sim_2.PNG)

## Zdroje
* https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_ALU
* https://is.muni.cz/el/1433/podzim2004/PB151/um/15090.html
* https://www.fpga4student.com/2017/06/vhdl-code-for-arithmetic-logic-unit-alu.html
* https://moodle.vutbr.cz/pluginfile.php/183804/mod_resource/content/1/vhdl_kubicek.pdf
* http://www.et-pocitacovesystemy.wz.cz/cislicova_technika/komb_log_obvody/aritm_log_jednotka/alu.html
* https://gist.github.com/pauljohanneskraft/b3e9d8f27b62200da705b258b63bdd60
* https://portal.matematickabiologie.cz/index.php?pg=zaklady-informatiky-pro-biology--teoreticke-zaklady-informatiky--teorie-cisel--dvojkovy-doplnek&fbclid=IwAR1cch5-jUgGqPjN9wNR4A7MHOeeRPlgDCLQR5w48rFSjkFIHv-hKW3gtwY
