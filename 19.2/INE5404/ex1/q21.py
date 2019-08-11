soma_valores = 0
quantidade_valores = 0
media = 0
maior_valor = -9999999999999999999
menor_valor = 9999999999999999999

valor = int(input('Valor: '))

while valor > 0:
    soma_valores += valor
    quantidade_valores += 1
    media = soma_valores / quantidade_valores

    if valor > maior_valor:
        maior_valor = valor
    if valor < menor_valor:
        menor_valor = valor

    print('Soma: {}'.format(soma_valores))
    print('Quantidade: {}'.format(quantidade_valores))
    print('Média: {}'.format(media))
    print('Maior: {}'.format(maior_valor))
    print('Menor: {}'.format(menor_valor))
    print()

    valor = int(input('Valor: '))