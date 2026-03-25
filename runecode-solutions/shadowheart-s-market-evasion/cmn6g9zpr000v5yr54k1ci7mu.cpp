#include <bits/stdc++.h>
using namespace std;

// Define the modulo value
const long long MOD = 1e9 + 7;

/**
 * @brief Calculates (a^b) % MOD using binary exponentiation.
 * This is needed for finding the modular inverse.
 */
long long power(long long a, long long b) {
    long long res = 1;
    a %= MOD;
    while (b > 0) {
        if (b % 2 == 1) // if b is odd
            res = (res * a) % MOD;
        a = (a * a) % MOD;
        b /= 2; // b = b >> 1
    }
    return res;
}

/**
 * @brief Calculates the modular multiplicative inverse of n using Fermat's Little Theorem.
 * inverse(n) = n^(MOD-2) % MOD
 */
long long modInverse(long long n) {
    return power(n, MOD - 2);
}

/**
 * @brief Calculates nCr % MOD using precomputed factorials.
 * nCr = n! / (r! * (n-r)!) = n! * inverse(r!) * inverse((n-r)!) % MOD
 */
long long combinations(int n, int k, const vector<long long>& fact, const vector<long long>& invFact) {
    if (k < 0 || k > n)
        return 0; // Invalid combination
    
    // (fact[n] * invFact[k]) % MOD
    long long part1 = (fact[n] * invFact[k]) % MOD;
    // (part1 * invFact[n-k]) % MOD
    return (part1 * invFact[n - k]) % MOD;
}

int main() {
    // Fast I/O
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N, M, L, K;
    cin >> N >> M >> L >> K;

    // --- Precomputation ---
    // We need factorials up to N+M
    int max_dim = N + M;
    vector<long long> fact(max_dim + 1);
    vector<long long> invFact(max_dim + 1);
    
    fact[0] = 1;
    invFact[0] = 1;
    for (int i = 1; i <= max_dim; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        invFact[i] = modInverse(fact[i]); // Precompute inverse factorials
    }
    // --- End Precomputation ---


    // 1. Calculate Total Paths from (0,0) to (N,M)
    // C(N+M, N)
    long long totalPaths = combinations(N + M, N, fact, invFact);

    // 2. Calculate "Bad" Paths (those passing through (L,K))
    
    // Part 1: Paths from (0,0) to (L,K)
    // C(L+K, L)
    long long pathsToL = combinations(L + K, L, fact, invFact);
    
    // Part 2: Paths from (L,K) to (N,M)
    // This is equivalent to paths from (0,0) to (N-L, M-K)
    // C((N-L) + (M-K), (N-L))
    long long pathsFromL = combinations((N - L) + (M - K), N - L, fact, invFact);

    // Total "Bad" Paths = Part1 * Part2
    long long badPaths = (pathsToL * pathsFromL) % MOD;

    // 3. Final Answer = Total Paths - Bad Paths
    // We add MOD before the final modulo to handle potential negative numbers
    long long goodPaths = (totalPaths - badPaths + MOD) % MOD;

    cout << goodPaths << '\n';

    return 0;
} 