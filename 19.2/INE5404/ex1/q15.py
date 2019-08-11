n = int(input('Digite a quantidade de números de Fibonacci: '))

f0 = 0
f1 = 1

for i in range(n):
    print(f0)

    f2 = f1 + f0
    f0 = f1
    f1 = f2