import sys
import heapq

def main():
    input = sys.stdin.readline
    n = int(input())

    shields = []
    total_hits = 0
    for i in range(n):
        h, r = map(int, input().split())
        shields.append([h, r])   # remaining durability, regen limit
        total_hits += h

    # untouched shields: simple pointer through the list
    next_new = 0

    # active heap: (deadline, id)
    active = []

    turn = 1
    alive = n

    while turn <= total_hits:
        # If any active shield already expired, impossible
        if active and active[0][0] < turn:
            print(-1)
            return

        if active:
            deadline, idx = heapq.heappop(active)
        else:
            # start a new untouched shield
            while next_new < n and shields[next_new][0] == 0:
                next_new += 1
            if next_new == n:
                print(-1)
                return
            idx = next_new
            next_new += 1

        # hit shield idx
        shields[idx][0] -= 1

        # if still alive, assign new deadline
        if shields[idx][0] > 0:
            new_deadline = turn + shields[idx][1]
            heapq.heappush(active, (new_deadline, idx))

        turn += 1

    print(total_hits)

if __name__ == "__main__":
    main()