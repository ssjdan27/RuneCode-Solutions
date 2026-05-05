def main():
    n, m = map(int, input().split())
    grid = [list(input().strip()) for _ in range(n)]
    direction = input().strip()

    start_r = start_c = -1
    for r in range(n):
        for c in range(m):
            if grid[r][c] == 'S':
                start_r, start_c = r, c
                grid[r][c] = '.'
                break
        if start_r != -1:
            break

    drdc = {
        'U': (-1, 0),
        'D': (1, 0),
        'L': (0, -1),
        'R': (0, 1)
    }

    def reflect_slash(d):
        if d == 'U':
            return 'R'
        if d == 'R':
            return 'U'
        if d == 'D':
            return 'L'
        return 'D'  # L -> D

    def reflect_backslash(d):
        if d == 'U':
            return 'L'
        if d == 'L':
            return 'U'
        if d == 'D':
            return 'R'
        return 'D'  # R -> D

    visited = set()

    r, c = start_r, start_c
    d = direction

    while True:
        state = (r, c, d)
        if state in visited:
            print("LOOP")
            return
        visited.add(state)

        dr, dc = drdc[d]
        nr, nc = r + dr, c + dc

        if not (0 <= nr < n and 0 <= nc < m):
            print("ESCAPES")
            return

        if grid[nr][nc] == '#':
            print("ESCAPES")
            return

        r, c = nr, nc

        if grid[r][c] == '/':
            d = reflect_slash(d)
        elif grid[r][c] == '\\':
            d = reflect_backslash(d)

if __name__ == "__main__":
    main()