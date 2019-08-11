x, y = map(int, input().split())
arr = [i for i in range(x, y + 1)]
print(sum(arr))
print(sum(arr) / len(arr))