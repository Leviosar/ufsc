option = 0
while option != 5:
    value_1 = float(input('Digite o primeiro valor: '))
    value_2 = float(input('Digite o segundo valor: '))

    option = int(input('Digite a opção: '))

    if option == 1:
        result = value_1 + value_2
    elif option == 2:
        result = value_1 - value_2
    elif option == 3:
        result = value_1 * value_2
    elif option == 4:
        result = value_1 / value_2
    elif option == 5:
        break

    print(result)
    