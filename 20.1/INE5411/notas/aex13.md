# Ligador estático

Por que existe um ligador? Caso nós escrevessemos programas completos em apenas um arquivo não seria necessário o uso de um ligador. Mas na vida real, programas possuem múltiplos arquivos e contextos, então é necessário um programa para interligar vários arquivos e referências entre eles: o ligador.

Ao final do processo de ligação, geramos um arquivo executável binário, ou seja, um arquivo completo com todas as referências e pronto para ser carregado por um programa carregador.

## Etapas de ligação

- Posiciona código e dados em memória
- Determina endereços de referências
    - Labels internas e externas
- Edita referências
    - Algumas labels internas precisam ser modificadas
    - Labels externas não são resolvidas pelo montador e precisam ser resolvidas pelo ligador

## Edição de referências

As edições vão acontecer principalmente em:

- Desvios (quando não usam modo relativo ao PC)

Chamadas de funções e jumps que usam modo absoluto podem conter referências a serem editadas.

- Load/store

Referências de dados

Para editar e resolver as diferenças o ligador utiliza a tabela de símbolos que foi gerada pelo montador previamente.