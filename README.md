# Novas Funcionalidades

## 1 SRL

### 1.1 ControlUnit case

```   
    6'b000000: begin

      case(Funct)

      {...}

        6'b000010: begin
          RegWrite = 1;
          RegDst = 1;
          ULASrc = 1;
          ULAControl = 3'b011;
          Branch = 0;
          MemWrite = 0;
          MemtoReg = 0;
          Jump = 0;
          Jal = 0;
          RegtoPC = 0;
        end
       endcase
    end 
 ```
### 1.2 ULA case
 
 ```   
  3'd3: result = SrcA >> SrcB[10:6];
 ```
### 1.3 MUXs

 ```   
  assign w_SrcB = w_ULASrc ? w_Inst[15:0] : {8'd0, w_rd2};
 ```
No caso da instrução SRL, os bits [10:6] do w_Inst são repassados à ULA para indicar a quantidade de vezes (shamt) que o valor no registrador será deslocado para a direita; em outros casos são utilizados os bits [7:0].
 
## 2 JAL

### 2.1 ControlUnit case

```   
  6'b000011: begin
    RegWrite = 1;
    RegDst = 0;
    ULASrc = 0;
    ULAControl = 3'b000;
    Branch = 0;
    MemWrite = 0;
    MemtoReg = 0;
    Jump = 1;
    Jal = 1;
    RegtoPC = 0;
  end
 ```
 ### 2.2 MUXs
 #### 2.2.1 Valor de registro
Caso a variável de seleção 'Jal' esteja ativada, o valor repassado ao Register File para ser armazenado será PC+1 (que é a próxima linha de instrução que seria executada antes do Jal ser acionado).
```   
  assign w_wd3 = w_Jal ? w_PCp1 : w_wd3D;
```
 #### 2.2.2 Endereço de registro
Caso a variável de seleção 'Jal' esteja ativada, o valor de PC+1 será armazenado no último registrador disponível, nesse caso, o registrador de endereço 3'd15.
```   
  assign w_wa3 = w_Jal ? 3'd15 : w_wa3A;
```

## 3 JR

### 3.1 ControlUnit case

```
    6'b000000: begin

      case(Funct)

      {...}

        6'b001000: begin
          RegWrite = 0;
          RegDst = 0;
          ULASrc = 0;
          ULAControl = 3'b000;
          Branch = 0;
          MemWrite = 0;
          MemtoReg = 0;
          Jump = 1;
          Jal = 0;
          RegtoPC = 1;
        end
       endcase
    end
```
 ### 3.2 MUXs
 Caso a variável de seleção 'RegtoPC' esteja ativada, indicando que a operação atual pertence à instrução JR, o *immediate* que chegaria ao MuxJump na arquitetura de referência será substituído pela saída w_rd1SrcA do Register File, ou seja, o valor que está armazenado no registrador que contém a informação da linha para a qual se desejar realizar o *jump*.
 ```
 assign w_ImPC = w_RegtoPC ? w_rd1SrcA : w_Inst[7:0];
```
## 4 Registradores Adicionais
No componente Register File, foram adicionados os registradores a seguir: 
```
  registrador reg8 (.dataIn(wd3), .clk(clk), .load(decOut[7] & we3), .dataOut(regOut[63:56]));
  registrador reg9 (.dataIn(wd3), .clk(clk), .load(decOut[8] & we3), .dataOut(regOut[71:64]));
  registrador reg10 (.dataIn(wd3), .clk(clk), .load(decOut[9] & we3), .dataOut(regOut[79:72]));
  registrador reg11 (.dataIn(wd3), .clk(clk), .load(decOut[10] & we3), .dataOut(regOut[87:80]));
  registrador reg12 (.dataIn(wd3), .clk(clk), .load(decOut[11] & we3), .dataOut(regOut[95:88]));
  registrador reg13 (.dataIn(wd3), .clk(clk), .load(decOut[12] & we3), .dataOut(regOut[103:96]));
  registrador reg14 (.dataIn(wd3), .clk(clk), .load(decOut[13] & we3), .dataOut(regOut[111:104]));
  registrador reg15 (.dataIn(wd3), .clk(clk), .load(decOut[14] & we3), .dataOut(regOut[119:112]));
  registrador reg16 (.dataIn(wd3), .clk(clk), .load(decOut[15] & we3), .dataOut(regOut[127:120]));
```
Foram realizados os devidos ajustes (como alteração na largura de fios no componente, entre outros). Segue um exemplo de alteração/adição realizada no módulo 'demux':
```
  assign muxOut = (ra == 3'd0) ? 8'b0 : 
  (ra == 3'd1) ? regOut[15:8] : 
  (ra == 3'd2) ? regOut[23:16] : 
  (ra == 3'd3) ? regOut[31:24] : 
  (ra == 3'd4) ? regOut[39:32] : 
  (ra == 3'd5) ? regOut[47:40] : 
  (ra == 3'd6) ? regOut[55:48] : 
  (ra == 3'd7) ? regOut[63:56] :
  (ra == 3'd8) ? regOut[71:64] : 
  (ra == 3'd9) ? regOut[79:72] : 
  (ra == 3'd10) ? regOut[87:80] : 
  (ra == 3'd11) ? regOut[95:88] : 
  (ra == 3'd12) ? regOut[103:96] : 
  (ra == 3'd13) ? regOut[111:104] : 
  (ra == 3'd14) ? regOut[119:112] : 
  (ra == 3'd15) ? regOut[127:120] :  0;
```
## 5 Interrupção
### 5.1 Implementação
Caso o *input* para interrupção seja ativado, o w_Inst, que carrega a instrução de máquina para os outros componentes da arquitetura, será carregado com uma instrução específica (Jal) que irá realizar um pulo para a linha 250 (escolhida arbitrariarmente para comportar o início das intruções de interrupção) e guardará o valor da linha da próxima instrução em um registrador.
```   
  assign w_Interrup = SW[15];
  assign w_Inst = w_Interrup ? 32'b_000011_00000_00000_00011_111010 : w_q;
```
### 5.2 Teste
Instruções foram programadas para realizar um teste de interrupção, segue uma representação do código em Assembly:
```
1. AND $1, $0, $1
2. AND $2, $0, $2
3. ADDi $1, $0, 0xAA
4. ADDi $2, $0, 0xAB
5. J 0

{...}

250. ADDi $7, $0, 0xCD
251. ADDi $6, $0, 0xAB
252. JR $15
```
O objetivo do programa é manter os registradores $1 e $2 em um loop no qual os valores atribuídos a cada um são AA e AB, respectivamente, e esses registradores são zerados em sequência. Esse comportamento é repetido indefinidamente até que seja ativada uma chave de interrupção. Após a ativação da chave, os valores AB e CD são atribuídos aos registradores $6 e $7, respectivamente. Com a desativação da chave, a instrução retorna à posição/linha que está armazenada no registrador $15, ou seja, o PC+1 que o 'Jal' guardou no registrador $15 ao ser executado.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
