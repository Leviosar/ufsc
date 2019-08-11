from math import sqrt

def ehPrimo(n):
    for i in range(2, int(sqrt(n)) + 1):
        if n % i == 0:
            return False

    return True

n = int(input('Digite um número maior do que 1: '))

while n <= 1:
    n = int(input('Para de palhaçada e digita um número válido aí: '))

print(ehPrimo(n))