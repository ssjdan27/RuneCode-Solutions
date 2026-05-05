def main():
    n = int(input())
    cooldowns = list(map(int, input().split()))

    seconds = 0

    while True:
        all_ready = True

        for i in range(n):
            if cooldowns[i] > 0:
                cooldowns[i] -= 1
                all_ready = False

        if all_ready:
            break

        seconds += 1

    print(seconds)

if __name__ == "__main__":
    main()
