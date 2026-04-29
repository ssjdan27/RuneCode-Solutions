#include <bits/stdc++.h>
using namespace std;

const long long MOD = 1000000007LL;

long long modPow(long long a, long long e) {
    long long r = 1;
    while (e > 0) {
        if (e & 1) r = (r * a) % MOD;
        a = (a * a) % MOD;
        e >>= 1;
    }
    return r;
}

long long nCr(int n, int r, const vector<long long>& fact, const vector<long long>& invFact) {
    if (r < 0 || r > n) return 0;
    return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N, M, L, K;
    cin >> N >> M >> L >> K;

    int limit = N + M;
    vector<long long> fact(limit + 1), invFact(limit + 1);
    fact[0] = 1;
    for (int i = 1; i <= limit; ++i) fact[i] = (fact[i - 1] * i) % MOD;
    invFact[limit] = modPow(fact[limit], MOD - 2);
    for (int i = limit; i >= 1; --i) invFact[i - 1] = (invFact[i] * i) % MOD;

    long long total = nCr(N + M, N, fact, invFact);
    long long throughForbidden = (nCr(L + K, L, fact, invFact) * nCr((N - L) + (M - K), N - L, fact, invFact)) % MOD;
    long long answer = (total - throughForbidden + MOD) % MOD;

    cout << answer << '\n';
    return 0;
}
