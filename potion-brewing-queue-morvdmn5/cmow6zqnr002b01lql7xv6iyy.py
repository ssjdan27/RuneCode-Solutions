import sys
import heapq

def main():
    input = sys.stdin.readline
    n = int(input())
    potions = []

    for _ in range(n):
        t, d = map(int, input().split())
        potions.append((d, t))  # sort by deadline

    potions.sort()

    current_time = 0
    max_heap = []

    for deadline, brew_time in potions:
        current_time += brew_time
        heapq.heappush(max_heap, -brew_time)

        if current_time > deadline:
            longest = -heapq.heappop(max_heap)
            current_time -= longest

    print(len(max_heap))

if __name__ == "__main__":
    main()