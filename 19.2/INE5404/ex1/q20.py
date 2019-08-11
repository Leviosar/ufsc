valor_saque = int(input('Digite o valor de saque desejado: '))

notas = [100, 50, 20, 10, 5, 2, 1]
quantidade_usos = {
    100: 0,
    50: 0,
    20: 0,
    10: 0,
    5: 0,
    2: 0,
    1: 0
}

for nota in notas:
    div = valor_saque // nota
    valor_saque = valor_saque % nota

    quantidade_usos[nota] = div

print(quantidade_usos)