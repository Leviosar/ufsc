from math import sqrt

n = int(input('Digite o número: '))

for i in range(1, int(sqrt(n)) + 1):
    if n % i == 0 and i != int(n/i):
        print(i)
        print(int(n/i))
    elif n % i == 0:
        print(i)
