import sys

def main():
    data = sys.stdin.read().strip().split()
    it = iter(data)

    n = int(next(it))

    position = 0
    visited = {0}

    for i in range(1, n + 1):
        move = int(next(it))
        position += move

        if position in visited:
            print(i)
            return

        visited.add(position)

    print(-1)

if __name__ == "__main__":
    main()
