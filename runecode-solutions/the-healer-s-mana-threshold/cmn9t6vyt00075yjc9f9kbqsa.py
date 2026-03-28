import sys

def main():
    data = sys.stdin.read().strip().split()
    it = iter(data)

    n = int(next(it))
    k = int(next(it))

    running_sum = 0

    for i in range(1, n + 1):
        x = int(next(it))
        running_sum += x
        if running_sum == k:
            print(i)
            return

    print(-1)

if __name__ == "__main__":
    main()