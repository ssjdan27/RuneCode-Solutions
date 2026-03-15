import sys

def main():
    input = sys.stdin.readline
    sys.setrecursionlimit(10**6)
    
    n = int(input())
    la, va = map(int, input().split())
    lb, vb = map(int, input().split())
    
    NEG = -4 * 10**18  # Equivalent to -4e18
    
    dp = [0] * (n + 1)
    dp[0] = 0
    
    for i in range(1, n + 1):
        best = NEG
        if i >= la:
            best = max(best, va - dp[i - la])
        if i >= lb:
            best = max(best, vb - dp[i - lb])
        dp[i] = 0 if best == NEG else best
    
    print(dp[n])

if __name__ == "__main__":
    main()