a_lenght = int(input('Tamanho inicial de A: '))
b_lenght = int(input('Tamanho inicial de B: '))

a_growing_rate = 2
b_growing_rate = 3.5

degrees = 20

while b_lenght <= a_lenght:
    a_lenght += a_growing_rate
    b_lenght += b_growing_rate

    degrees += 1

print(degrees)