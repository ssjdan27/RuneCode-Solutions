
import sys
from collections import deque

def main():
    input = sys.stdin.readline
    N, K = map(int, input().split())
    A = list(map(int, input().split()))

    minD = deque()
    maxD = deque()

    l = 0
    best = 0

    for r in range(N):
        # Maintain min deque (increasing)
        while minD and A[minD[-1]] > A[r]:
            minD.pop()
        minD.append(r)

        # Maintain max deque (decreasing)
        while maxD and A[maxD[-1]] < A[r]:
            maxD.pop()
        maxD.append(r)

        # Shrink window until balanced
        while A[maxD[0]] - A[minD[0]] > K:
            if minD[0] == l:
                minD.popleft()
            if maxD[0] == l:
                maxD.popleft()
            l += 1

        best = max(best, r - l + 1)

    print(best)

if __name__ == "__main__":
    main()
