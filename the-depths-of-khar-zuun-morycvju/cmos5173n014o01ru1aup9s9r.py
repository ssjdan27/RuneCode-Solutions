def main():
    R, C = map(int, input().split())

    grid = []
    for r in range(R):
        grid.append(input().strip())

    # Locate S
    sr, sc = 0, 0
    for r in range(R):
        for c in range(C):
            if grid[r][c] == 'S':
                sr, sc = r, c

    visited = [[False] * C for _ in range(R)]
    visited[sr][sc] = True

    # Use a list with a head pointer as a queue — no imports needed
    queue = [(sr, sc, 0)]
    head = 0

    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    while head < len(queue):
        r, c, dist = queue[head]
        head += 1

        for dr, dc in directions:
            nr, nc = r + dr, c + dc
            if nr < 0 or nr >= R or nc < 0 or nc >= C:
                continue
            if grid[nr][nc] == '#':
                continue
            if visited[nr][nc]:
                continue
            if grid[nr][nc] == 'E':
                print(dist + 1)
                return
            visited[nr][nc] = True
            queue.append((nr, nc, dist + 1))

    print(-1)

def main_entry():
    main()

main_entry()