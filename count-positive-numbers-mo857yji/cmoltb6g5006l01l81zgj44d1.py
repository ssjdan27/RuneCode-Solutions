n=int(input())
res=0
l=[int(x) for x in input().split()]
for i in l:
    if i > 0:
        res += 1

print(res)