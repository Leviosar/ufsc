# Questão 1

Dada a expressão [insira sua expressão aqui], responda as perguntas abaixo:

a) O endereço de memória onde reside o primeiro elemento da JAT (i.e &JAT[0]) é: `0x10010014`

Ao executar passo a passo o programa, na instrução `la $t4, jat` o endereço é carregado para o registrador $t4, para encontrar esse endereço olhe o valor de $t4 no banco de registradores (geralmente no lado esquerdo do MARS)

![Valor de $t4](https://imgur.com/OQ9uvfr.png)

b) Indique a quais endereços efetivos de memória correspondem os seguintes labels:

- L0: `0x00040048` 
- L1: `0x00040050`
- L2: `0x00040058`
- L3: `0x00040064`
- L4: `0x00040070`
- Default: `0x00040078`

Para encontrar esses valores, você precisa olhar na listagem de instruções o início de cada label, checando o campos "Address" deles, você pode ver isso em "Text segment"

![Endereços de memória](https://imgur.com/SKIhXg9.png)

c) A codificação em linguagem de máquiba da instrução `j Exit` é: `0x08100020`

Pra encontrar essa codificação, você pode ir em qualquer uma das referências de `j Exit` no código, na seçao "Text segment", o valor estará no campo "Code".

d) O montador resolveu o label `Exit` e atribui-lhe o seguinte endereço: `0x00400080`

Na mesma linha onde você encontrou a codificação da questão anterior, no campo basic verá que existe uma instrução `j 0x00400080`, ou seja, ele está pulando para o endereço de `Exit`, que tem valor `0x00400080`.

e) Os 26 bits menos significativos da representação binária da instrução `j Exit` são: `00 0001 0000 0000 0000 0010 0000`.

Pra chegar nesse resultado, você precisa converter o valor da codificação (`0x08100020`) para um número binário de 32 bits, chegando em `0000 1000 0001 0000 0000 0000 0010 0000`, e remover os 6 bits mais significativos pra finalmente chegar no valor da resposta.

# Questão 2

O montador expandiu a pseudo-instrução `la $t4 jat` em uma sequência de 2 instruções nativas. Quais das seguintes representações correspondem à primeira instrução dessa sequência?

Escolha uma ou mais:

- [x] `lui $at,0x1001`
- [ ] `lui $t4,0x1001`
- [x] `lui $1,4097`

A primeira e terceira representações são equivalentes, pois 4097 em base 10 equivale a 0x1001 em base 16, além do registrador `$at` ser equivalente ao registrador `$1`. Enquanto isso, na segunda instrução temos a chamada do registrado `$t4`, que seria equivalente a `$12` e não a `$1`.

# Questão 3

O montador expandiu a pseudo-instrução `la $t4 jat` em uma sequência de 2 instruções nativas. Quais das seguintes representações correspondem à primeira instrução dessa sequência?

- [x] `ori $12, $1, 20`
- [ ] `ori $at, $at, 0x0014`
- [x] `ori $t4, $at, 0x0014`

A primeira e terceira representações são equivalentes, pois 20 em base 10 equivale a 0x0014 em base 16, além do registrador `$at` ser equivalente ao registrador `$1` e `$t4` ser equivalente ao registrador `$12`.

# Questão 4

`lw $s0 _f`

- [x] `lw $16 0($1)`
- [x] `lw $s0 0($at)`
- [ ] `lw $at 0($s0)`

# Questão 5

A seção 4 do código testa se `k` pertence ao intervalo [0,4] com a seguinte sequência de 2 instruções nativas:

`sltiu $t3` + `$s5, 5`

`b` + `eq` + `$t3` + `$zero, default`