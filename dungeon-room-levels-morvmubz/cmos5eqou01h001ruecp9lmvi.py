import sys
from collections import deque

def main():
    input = sys.stdin.readline
    n, m = map(int, input().split())
    grid = [list(input().strip()) for _ in range(n)]

    start = None
    enemy_count = 0

    for r in range(n):
        for c in range(m):
            if grid[r][c] == 'S':
                start = (r, c)
            elif grid[r][c].isdigit():
                enemy_count += 1

    max_power = 1 + enemy_count

    q = deque()
    q.append((start[0], start[1], 1, 0))  # row, col, power, distance

    visited = [[[False] * (max_power + 1) for _ in range(m)] for __ in range(n)]
    visited[start[0]][start[1]][1] = True

    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

    while q:
        r, c, power, dist = q.popleft()

        if grid[r][c] == 'E':
            print(dist)
            return

        for dr, dc in directions:
            nr, nc = r + dr, c + dc

            if not (0 <= nr < n and 0 <= nc < m):
                continue

            cell = grid[nr][nc]

            if cell == '#':
                continue

            next_power = power

            if cell.isdigit():
                enemy_level = int(cell)
                if power < enemy_level:
                    continue
                next_power = min(max_power, power + 1)

            if not visited[nr][nc][next_power]:
                visited[nr][nc][next_power] = True
                q.append((nr, nc, next_power, dist + 1))

    print(-1)

if __name__ == "__main__":
    main()
