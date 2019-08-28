# Questões SD - Aula 3

## 1 - Qual o atraso crítico de cada projeto?

## 2 - Quantos elementos combinacionais foram usados?

No primeiro projeto são usados 3, todos somadores. No segundo projeto são 2, o somador e o multiplexador.

## 3 - Quantos registradores foram usados?

No primeiro projeto são usados 5 registradores, enquanto no segundo projeto foram apenas 2.

## 4 - Quantos ciclos foram usados?

O primeiro módulo usa 2 ciclos e o segundo módulo 4.

## 5 - Quantos ciclos são necessários pra somar N valores?

O primeiro módulo soma apenas 4 valores, enquanto para o segundo módulo seriam necessários N ciclos.

## 6 - Qual o melhor módulo?

Cada módulo tem características positivas e negativas que fazem com que o "melhor" módulo só possa ser decidido de acordo com a necessidade do projeto em questão. Para um projeto que necessite de um resultado sem erros (ou seja, que não ocorra overflow) o primeiro módulo é o mais adequado, entretanto para um projeto capaz de somar N bits o segundo módulo é melhor já que consegue fazer isso.

## 7 - Restrições funcionais de cada módulo

O primeiro módulo faz uma soma de um número de parcelas fixas (4) e o segundo módulo não possui tratamento de overflow, assim mesmo com a capacidade de somar N parcelas, o overflow aconteceria eventualmente.
