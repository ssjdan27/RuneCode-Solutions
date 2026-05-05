import sys
from collections import deque, defaultdict

def main():
    input = sys.stdin.readline
    n, m = map(int, input().split())

    grid = [list(input().strip()) for _ in range(n)]

    teleporters = defaultdict(list)

    start = None
    end = None

    for r in range(n):
        for c in range(m):
            cell = grid[r][c]

            if cell == 'S':
                start = (r, c)

            if cell == 'E':
                end = (r, c)

            if cell.isalpha() and cell not in ('S', 'E'):
                teleporters[cell].append((r, c))

    q = deque()
    q.append((start[0], start[1], 0))

    visited = [[False] * m for _ in range(n)]
    visited[start[0]][start[1]] = True

    used_portal = set()

    directions = [(1,0),(-1,0),(0,1),(0,-1)]

    while q:
        r, c, d = q.popleft()

        if (r, c) == end:
            print(d)
            return

        for dr, dc in directions:
            nr, nc = r + dr, c + dc

            if 0 <= nr < n and 0 <= nc < m:
                if not visited[nr][nc] and grid[nr][nc] != '#':
                    visited[nr][nc] = True
                    q.append((nr, nc, d + 1))

        cell = grid[r][c]

        if cell.isalpha() and cell not in ('S','E') and cell not in used_portal:
            used_portal.add(cell)

            for nr, nc in teleporters[cell]:
                if not visited[nr][nc]:
                    visited[nr][nc] = True
                    q.append((nr, nc, d + 1))

    print(-1)

if __name__ == "__main__":
    main()
