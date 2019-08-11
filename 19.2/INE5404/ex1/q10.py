x, y = map(int, input().split())
arr = [i for i in range(x, y + 1) if i % 2 != 0]

media = sum(arr) / len(arr)

print(sum(arr))
print(media)

if media % 2 == 0:
    print('Média par')
else:
    print('Média impar')