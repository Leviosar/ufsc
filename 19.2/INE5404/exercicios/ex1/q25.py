from math import sqrt

def isPrime(n):
    for i in range(2, int(sqrt(n)) + 1):
        if n % i == 0:
            return False

    return True

for i in range(100001):
    if isPrime(i):
        print(i)