# Deadlocks

Quando utilizamos mecanismos de controle de concorrência no código, o mau uso deles pode vir a causar impasses na aplicação, bloqueando parcialmente ou completamente a execução do programa. A vivacidade de um programa (_liveness_) garante que a conclusão de tarefas concorrentes seja concluida em algum momento, um impasse compromete a _liveness_ do programa. Podemos nos referir a esses impasses como _deadlocks_.

Suponha que um processo P1 detenha o recurso A e solicite o recurso B, ao mesmo tempo que um processo P2 detém o recurso B e solicita o recurso A. Os dois processos ficaram bloqueados "para sempre".

## Recursos

Mas o que exatamente é um recurso? Um recurso é uma parte de um sistema, que pode ter de 1 a N instâncias. Exemplos de recursos são endereços de memória, arquivos abertos, dispostivos de entrada e saída e vários outros.

### Recursos preemptíveis

Recursos que podem ser retirados de um processo sem efeitos prejudiciais, como a memória (o conteúdo da memória pode ser salvo em disco pelo SO e depois restaurado).

### Recursos não-preemptíveis

Recursos que não podem ser retirados sem causar uma falha na computação de seu processo, como por exemplo o acesso a uma impressora. Esse tipo de recurso é o que costuma gerar _deadlocks_.

## Condições para que um _deadlock_ ocorra

1. Exclusão mútua
    - Apenas uma tarefa por vez acessando o recurso
2. Espera
    - A tarefa em questão que usa o recurso está esperando por outro recurso
3. Recurso não-preemptível
    - Recurso que não pode ser retirado a força de uma tarefa
4. Espera circular
    - Um ciclo de 2 ou mais tarefas, cada uma esperando por um recurso em uso pela próxima tarefa do ciclo

## Estados seguros e inseguros

O sistema encontra-se em um `estado seguro` se existe uma sequência <T1, T2, T3, ..., TN> de todas as tarefas do sistema tal que:

- Para cada tarefa Ti, os recursos que Ti pode requisitar podem ser satisfeitos pela união dos recursos disponíveis e dos recursos em uso por Tj, para `j < i`

Se o sistema está em um `estado seguro`, temos certeza que é impossível acontecer um _deadlock_.

Por sua vez um `estado inseguro` se dá quando a condição acima não é satisfeita. O sistema estar em um `estado inseguro` não significa exatamente que ele irá cair em um _deadlock_, mas sim que ele PODE cair em um _deadlock_.

Dessa forma, uma das maneiras de garantir que seu programa não terá _deadlocks_ é garantir que ele sempre esteja em `estados seguros`.

## Estratégias para tratar _deadlocks_

1. Ignorar completamente o problema

2. Prevenção

3. Anulação

### Ignorando o problema

Simplesmente ignore o problema, pronto.

Pegadinha, lembre-se que isso só deve ser feito em sistemas não críticos e onde a perda de dados em decorrência do _deadlock_ não é tão grande. Se você estiver trabalho com um sistema crítico PELO AMOR DE DEUS NÃO SIGA ISSO.

### Prevenção

É uma boa ideia tentar eliminar algumas das condições necessárias pra que ocorra um _deadlock_.

**1. Eliminando condição de exclusão mútua**

Se nunca tivermos uma exclusão mútua, é impossível acontecer _deadlocks_. Lembre-se que recursos _read-only_ não precisam de travas, já que o recurso em si não poderá ser alterado por nenhuma das tarefas que o usam. Dessa forma, eliminando as travas iremos impedir a ocorrência de um _deadlock_ naquele ponto do programa. 

**2. Eliminando condições de posse/espera**

Você pode exigir que um processo requisite todos os recursos que ele necessita antes de começar a executar, assim ele nunca mais irá precisar de outro recurso após iniciar a execução. Essa abordagem diminui a concorrência total do programa, além disso uma tarefa pode não saber exatamente quais os recursos que irá acessar.

**3. Eliminando a condição de não-preempção**

Se uma tarefa está usando recursos e requisita outros que não podem ser utilizados imediatamente, a tarefa simplesmente libera todos os seus recursos e pode tentar novamente mais tarde. Ou seja, transformamos todos os recursos em preemptíveis.

Essa opção também pode nos trazer problemas, alguns recursos não são preemptáveis, não importa o que você ache. Por exemplo, pense numa tarefa que está em posse de uma impressora, mas requisita um outro recurso bloqueado no meio de sua execução, segundo nosso princípio vamos agora remover a força a posse da impressora dessa tarefa. Isso pode levar a um defeito na próxima tarefa que peça acesso a impressora, já que ela pode ter começado a imprimir algo em sua tarefa anterior.

**4. Eliminando a condição de espera circular**

**Solução 1**: cada processo só pode estar em posse de 1 recurso por vez. Essa solução é bem limitada e não pode ser usada em qualquer caso, já que existem tarefas que exigirão o uso simultâneo de 2 ou mais recursos.

**Solução 2**: definimos uma regra onde cada recurso possui um identificador único global, sempre que uma tarefa requisitar o uso de um recurso, geramos um grafo de alocação de recursos e vemos se ele possui ciclos. Podemos implementar isso com duas regrinhas base.

- Impomos uma ordem total para todos os tipo de recursos e requer que as tarefas solicitem os recursos em ordem crescente.

- Para requisitar um recurso `Rj`, um processo deve primeiro liberar todos os recursos `Ri` tal que `i >= j`

### Anulação 

Anular a ocorrência de _deadlocks_ é simplesmente implementar uma das prevenções acima por todo o código, em sistemas maiores e mais complexos isso pode ser extremamente exaustivo, por isso que sistemas operacionais modernos como Linux e Windows (pfff) não implementam esse tipo de solução.

Cada uma das soluções de prevenção tem seu custo e eles devem ser levados em conta antes de implementados.

## Inanição (_starvation_)

Caso ao tentar tratar _deadlocks_ você faça alguma cagada, pode ser que cause _starvation_ em alguma tarefa, isso significa que essa tarefa nunca conseguirá acessar os recursos por algum motivo qualquer.

Podemos resolver problemas de _starvation_ de duas formas principais:

1. Um algoritmo para alocar recursos para tarefas mais curtas primeiro
    - Funciona bem para múltiplas tarefas curtas em um sistema
    - Tarefas longas podem ficar muito tempo sem serem executadas
        - Mesmo não estando bloquedas, seguem numa espécia de _starvation_

2. Quem chegar primeiro é servido primeiro (FIFO)

## _Livelock_ (precisamos começar a ser mais criativos)

Caso durante a sua execução uma tarefa não progrida devido à mudança de estados constantes em outras tarefas, prejudicando seu avanço.

A tarefa continua a executar, mas não consegue seus recursos para concluir sua execução. Em casos mais extremos pode levar a _starvation_.

Um _livelock_ é ainda pior que um _deadlock_, já que como as tarefas que não estão realmente bloqueadas, elas continuam gastando tempo de CPU sem avançar na sua computação. Além disso um _livelock_ não é detectável como um _deadlock_.