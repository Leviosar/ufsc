n = int(input('Digite um número para ter o fatorial calculado: '))

for i in range(n - 1, 0, -1):
    n *= i

print(n)