soma_notas = 0

for i in range(3):
    soma_notas += int(input('Digite a {} nota'.format(i+1)))

media = soma_notas / 3

if media < 3:
    print('Reprovado')
elif media <= 5.75:
    print('Exame')
else:
    print('Aprovado')