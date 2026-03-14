N, K = map(int, input().split())
T = list(map(int, input().split()))

low = 0
high = min(T) * K

while low < high:
    mid = (low + high) // 2

    total = 0
    for t in T:
        total += mid // t
        if total >= K:
            break

    if total >= K:
        high = mid
    else:
        low = mid + 1

print(low)