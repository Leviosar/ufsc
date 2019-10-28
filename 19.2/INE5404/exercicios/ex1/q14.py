n = int(input('Digite o número: '))
m = int(input('Digite a potência: '))

contador = m
mult = 1

for i in range(m):
    mult *= n

print(mult)

mult = 1

while contador > 0:
    mult *= n
    contador -= 1

print(mult)