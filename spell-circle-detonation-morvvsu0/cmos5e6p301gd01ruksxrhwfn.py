import sys

def main():
    input = sys.stdin.readline
    n, m, k = map(int, input().split())
    grid = [input().strip() for _ in range(n)]

    # prefix[r+1][c+1] = number of monsters in rectangle (0,0) to (r,c)
    prefix = [[0] * (m + 1) for _ in range(n + 1)]

    for r in range(n):
        row_sum = 0
        for c in range(m):
            if grid[r][c] == 'M':
                row_sum += 1
            prefix[r + 1][c + 1] = prefix[r][c + 1] + row_sum

    def query(r1, c1, r2, c2):
        # inclusive rectangle
        return (
            prefix[r2 + 1][c2 + 1]
            - prefix[r1][c2 + 1]
            - prefix[r2 + 1][c1]
            + prefix[r1][c1]
        )

    answer = 0

    for r in range(n):
        for c in range(m):
            if grid[r][c] != '.':
                continue

            top = max(0, r - k)
            bottom = min(n - 1, r + k)
            left = max(0, c - k)
            right = min(m - 1, c + k)

            monsters_hit = query(top, left, bottom, right)
            answer = max(answer, monsters_hit)

    print(answer)

if __name__ == "__main__":
    main()