def main():
    n, w = map(int, input().split())
    weights = list(map(int, input().split()))
    powers = list(map(int, input().split()))

    # dp[w] = max power achievable with capacity w
    dp = [0] * (w + 1)

    for i in range(n):
        wi = weights[i]
        pi = powers[i]
        # Iterate in reverse to preserve the 0/1 constraint
        for cap in range(w, wi - 1, -1):
            if dp[cap - wi] + pi > dp[cap]:
                dp[cap] = dp[cap - wi] + pi

    print(dp[w])

def main_entry():
    main()

main_entry()