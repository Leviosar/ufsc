# Máquina Sequenciais Síncronas e Soluções Multiciclo

Durante projetos de sistemas digitais, é possível (e muito provável) que a solução puramente combinacional acarrete em problemas, tendo isso em vista, a abordagem sequencial pode trazer benefícios para o funcionamento e simplicidade lógica do circuito.

Tomando como exemplo um somador de 8 bits que some 4 variáveis (A, B, C, D), suponha que haja um atraso de exatamente um ciclo de clock entre a chegada de cada variável a ser somada, utilizando um circuito puramente combinacional, você pode aninhar somadores de modo a somar (((A + B) + C) + D), como a operação é comutativa e associativa, é uma possibilidade. Para isso você usaria 3 somadores de 8 bits diferentes, e teria problemas com o atraso.

Já com um circuito sequencial, utilizando de uma arquitetura _datapath-control_, com apenas um somador, dois registradores e um multiplexador podemos projetar o circuito que a cada ciclo de clock fará uma das somas, guardando o resultado parcial que vai ser usado na próxima soma. Como principais vantagens desse circuito se destacam o "controle" sobre o clock, o custo reduzido de transistores e a possibilidade de escalonamento (você pode somar tantas variáveis como quiser, tendo em vista que quanto maior a quantidade de variáveis, mais provável a ocorrência de um overflow).

- Slides da aula 3 possuem exemplos visuais do exemplo.