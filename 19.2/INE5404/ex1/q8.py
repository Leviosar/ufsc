n = int(input())

add = [x for x in range(n) if x % 3 == 0 or x % 5 == 0 or x % 7 == 0]
sub = [x for x in range(n) if x % 8 == 0]
sub = sum(sub)
add = sum(add)

print(add - sub)