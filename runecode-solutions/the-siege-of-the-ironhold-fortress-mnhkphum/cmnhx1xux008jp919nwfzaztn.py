def can_place(positions, b, min_dist):
    count = 1
    last = positions[0]
    for i in range(1, len(positions)):
        if positions[i] - last >= min_dist:
            last = positions[i]
            count += 1
            if count == b:
                return True
    return False
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i]); i += 1
        else:
            result.append(right[j]); j += 1
    result.extend(left[i:])
    result.extend(right[j:])
    return result
def main():
    n, b = map(int, input().split())
    positions = list(map(int, input().split()))
    positions = merge_sort(positions)
    lo = 1
    hi = positions[-1] - positions[0]
    answer = 0
    while lo <= hi:
        mid = (lo + hi) // 2
        if can_place(positions, b, mid):
            answer = mid
            lo = mid + 1
        else:
            hi = mid - 1
    print(answer)
def main_entry():
    main()
main_entry()