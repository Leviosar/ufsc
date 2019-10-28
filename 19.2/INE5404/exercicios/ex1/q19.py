from sys import exit

valor = int(input('Valor: '))
soma_valores = 0
n_valores = 0

while valor != 0:
    soma_valores += valor
    n_valores += 1

    valor = int(input('Valor: '))

try:
    media = soma_valores / n_valores
except:
    print('Nenhum valor digitado')
    exit()

print('Media: {}'.format(media))