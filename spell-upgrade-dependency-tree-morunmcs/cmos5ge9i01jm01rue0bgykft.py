import sys
sys.setrecursionlimit(10**6)

NEG_INF = -10**18

def main():
    input = sys.stdin.readline
    n, K = map(int, input().split())
    cost = [0] + list(map(int, input().split()))
    power = [0] + list(map(int, input().split()))

    parents = list(map(int, input().split())) if n > 1 else []
    children = [[] for _ in range(n + 1)]

    for i in range(2, n + 1):
        p = parents[i - 2]
        children[p].append(i)

    def dfs(u):
        # dp[b] = best power for subtree u using exactly b mana, assuming u is taken
        dp = [NEG_INF] * (K + 1)
        if cost[u] <= K:
            dp[cost[u]] = power[u]

        for v in children[u]:
            child_dp = dfs(v)
            new_dp = dp[:]  # option to ignore child subtree completely

            for b1 in range(K + 1):
                if dp[b1] == NEG_INF:
                    continue
                for b2 in range(K - b1 + 1):
                    if child_dp[b2] == NEG_INF:
                        continue
                    new_dp[b1 + b2] = max(new_dp[b1 + b2], dp[b1] + child_dp[b2])

            dp = new_dp

        return dp

    root_dp = dfs(1)

    answer = 0
    for b in range(K + 1):
        answer = max(answer, root_dp[b])

    print(answer)

if __name__ == "__main__":
    main()