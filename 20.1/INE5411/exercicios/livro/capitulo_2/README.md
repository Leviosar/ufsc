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