# Capítulo 2 - Instructions: Language of the Computer

### 2.19

Assume the following register contents:

```assembly
    $t0 = 0xAAAAAAAA, $t1 = 0x12345678
```

#### 2.19.1

For the register values shown above, what is the value of $t2 for the following sequence of instructions?

```assembly
sll $t2, $t0, 44 
or $t2, $t2, $t1
```

**Resposta**: `$t2` terá o valor de `$t1` (0x12345678), isso acontece porque na primeira instrução, é realizado um shift de 44 posições, deixando o registrador com o valor 0x00000000. Ao fazer uma operação OR do tipo `a | 0`, sempre teremos como resultado o valor de `a`, por isso na segunda instrução o valor de `$t1` é passado para `$t2`

#### 2.19.2 

For the register values shown above, what is the value of $t2 for the following sequence of instructions? 

```assembly
sll $t2, $t0, 4 
andi $t2, $t2, −1 
```

**Resposta**: Após a primeira instrução, teremos no registrador `$t2` o valor `0xAAAAAAA0`, já que o deslocamento de 4 bits ao ser representado em hexadecimal ocupa apenas um caractere. A segunda instrução faz um `andi` com o valor -1 (32 bits com o valor 1 considerando uma conversão para complemento de 2), e como temos que `a and 1 = a`, o valor final do registrador `$t2` é `0xAAAAAAA0`.

#### 2.19.3 

For the register values shown above, what is the value of $t2 for the following sequence of instructions? 

```assembly
srl $t2, $t0, 3 
andi $t2, $t2, 0xFFEF
```

**Resposta**: Ao converter `0xAAAAAAAA` para binário temos `10101010101010101010101010101010`, realizando um deslocamento à direita por 3 bits, ficaremos com `00010101010101010101010101010101` ou `0x15555555`.

Agora, convertemos a constante da segunda instrução `0x0000FFEF` para binário e temos `00000000000000001111111111101111`, realizado uma operação `and` entre os dois valores teremos o valor final de `00000000000000000101010101000101`, ou `0x00005545`.

### 2.21 

Provide a minimal set of MIPS instructions that may be used to implement the following pseudoinstruction:

```assembly
not $t1, $t2 // bit-wise invert
```

**Resposta**: utilizando a operação `nor`, nativa ao MIPS, podemos expressar uma negação bit-a-bit da seguinte forma: `not a = nor(a, a)`, escrevendo isso para uma instrução no assembly do MIPS teremos

```
nor $t1, $t2, $t2
```

### 2.22 

For the following C statement, write a minimal sequence of MIPS assembly instructions that does the identical operation. Assume `$t1 = A`, `$t2 = B`, and `$s1` is the base address of C.

```c
A = C[0] << 4;
```

**Resposta**: 

```assembly
lw $t1, 0($s1)
sll $t1, $t1, 4
```

### 2.24 

Suppose the program counter (PC) is set to 0x2000 0000. Is it possible to use the jump (j) MIPS assembly instruction to set the PC to the address as 0x4000 0000? Is it possible to use the branch-on-equal (beq) MIPS assembly instruction to set the PC to this same address?

```
A = 0x2000 0000 = 0010 0000 0000 0000 0000 0000 0000 0000
B = 0x4000 0000 = 0100 0000 0000 0000 0000 0000 0000 0000
```

### 2.26 

Consider the following MIPS loop: 

```assembly
LOOP: 
    slt $t2, $0, $t1 
    beq $t2, $0, DONE 
    subi $t1, $t1, 1 
    addi $s2, $s2, 2 
    j LOOP 
DONE: 
```

#### 2.26.1

Assume that the register $t1 is initialized to the value 10. What is the value in register $s2 assuming $s2 is initially zero? 

**Resposta**: o valor retornado pelo `slt` feito na primeira instrução é 1 (0 < 10), então logo abaixo no `beq` quando comparado com o valor de `$0`, a comparação será falsa e continuará executando `$t1 -= 1` e `$s0 += 2`. O valor final de `$s2` será 20 após 10 iterações do loop. 

#### 2.26.2 

For each of the loops above, write the equivalent C code routine. Assume that the registers $s1, $s2, $t1, and $t2 are integers A, B, i, and temp, respectively. 

**Resposta**:

```c
int i = 10;
int B = 0;
do {
    B += 2;
    i -= 1;
} while (i > 0)
```

#### 2.26.3

For the loops written in MIPS assembly above, assume that the register $t1 is initialized to the value N. How many MIPS instructions are executed?

**Resposta**: `5N + 2`

Como o loop possui 5 instruções, serão executadas todas elas N vezes durante a execução do programa, mas no momento onde `$t1` assumir o valor N+1, as duas primeiras instruções (`slt` e `beq`) ainda serão executadas antes do loop ser encerrado, por isso são adicionados 2 instruções ao cálculo final, tendo `5N + 2`.

### 2.31

Implement the following C code in MIPS assembly. What is the total number of MIPS instructions needed to execute the function? 

```c
int fib(int n) { 
    if (n==0) 
    {
        return 0;
    } 
    else if (n == 1)
    {
        return 1;
    } 
    else
    {
        return fib(n−1) + fib(n−2)
    };
}
```

```assembly
fib:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    slti $t0, $a0, 2
    beq $t0, $zero, Control

    add $v0, $v0, $a0
    add $sp, $sp, 8 
    jr $ra

Control:
    addi $a0, $a0, -1
    jal fib

    addi $a0, $a0, -1
    jal fib

    lw $a0 0($sp)
    lw $ra 4($sp)
    add $sp, $sp, 8
    jr $ra

```

### 2.39

Write the MIPS assembly code that creates the 32-bit constant `0010 0000 0000 0001 0100 1001 0010 0100` (base two) and stores that value to register $t1.

Resposta: essa atribuição precisa ser quebrada em duas instruções, a primeira instrução, `lui`, irá carregar os 16 bits mais significativos da constante no registrador, então convertendo `0010 0000 0000 0001` temos 8193. 

A segunda instrução, vai fazer um or imediato (`ori`) entre o valor atual de $t1 (que possui como 16 bits mais significativos o valor que colocamos na primeira instrução, e como 16 bits menos significativos o valor 0). Como `a or 0 = a`, no final temos a constante de 32 bits no registrador.

```assembly
lui $t1, 8193
ori $t1, $t1, 18724
```

### 2.40

If the current value of the PC is 0x00000000, can you use a single jump instruction to get to the PC address as shown in Exercise 2.39?

Resposta: o valor do exercício 2.39 era `0010 0000 0000 0001 0100 1001 0010 0100`, convertendo pra hexadecimal `0x2001 4924`, um salto de 29 bits, sendo que o valor máximo para o salto do `jump` é de 28 bits, então o endereço serial inalcançável.

Porém, utilizando-se de uma instrução do tipo jump, a `jr`, você pode alcançar os 32 bits de um

### 2.41 

If the current value of the PC is 0x00000600, can you use a single branch instruction to get to the PC address as shown in Exercise 2.39?

Resposta: utilizando-se dos mesmos valores, mas dessa vez com o range de 16 bits de um `branch`, também seria impossível alcançar essa instrução.

### 2.42

If the current value of the PC is 0x1FFFf000, can you use a single branch instruction to get to the PC address as shown in Exercise 2.39?

Resposta: convertendo o valor `0x1fff f000` pra binário temos `0001 1111 1111 1111 1111 0000 0000 000`

### 2.43

Write the MIPS assembly code to implement the following C code: 

```c
    lock(lk); 
    shvar=max(shvar,x); 
    unlock(lk);
```

Assume that the address of the `lk` variable is in `$a0`, the address of the `shvar` variable is in `$a1`, and the value of variable `x` is in `$a2`. Your critical section should not contain any function calls. Use ll/sc instructions to implement the lock() operation, and the unlock() operation is simply an ordinary store instruction.

```assembly
.text
.globl main

main: 
    jal lock            # executa a procedure lock
    slt $t0, $a1, $a2   # se a1 > a2 então $t0 = 0
    beq $t0, $zero, L1  # se t0 = 0 então pula para L1
    add $a1, $a2, $zero # se t0 = 1 então shvar = x
L1: jal unlock          # executa a procedure unlock

lock: 
try:
    ll $t1, 0($a0)      # t1 = MEM[$a0], inicia operação atômica
    bne $t1, $zero, try # se t1 != 0, o semaforo está fechado, então volta para try
    addi $t1, $zero, 1  # se t1 = 0, t1 += 1
    sc $t1, 0($a0)      # MEM[$0] = t1, tenta concluir operação atômica
    beq $t1, $zero, try # se t1 = 0, a operação atômica falhou e deve voltar ao início
    jr $ra              # retorna para caller

unlock:
    sw $zero, 0($a0)    # MEM[$a0] = 0
    jr $ra              # retorna para caller
```