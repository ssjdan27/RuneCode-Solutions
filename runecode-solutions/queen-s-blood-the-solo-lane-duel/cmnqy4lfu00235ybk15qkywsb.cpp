#include <bits/stdc++.h>
using namespace std;
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    long long n;
    cin >> n;
    long long la, va, lb, vb;
    cin >> la >> va;
    cin >> lb >> vb;
    const long long NEG = (long long)-4e18;
    vector<long long> dp(n + 1, 0);
    dp[0] = 0;
    for (long long i = 1; i <= n; i++) {
        long long best = NEG;
        if (i >= la) best = max(best, va - dp[i - la]);
        if (i >= lb) best = max(best, vb - dp[i - lb]);
        dp[i] = (best == NEG ? 0 : best);
    }
    cout << dp[n] << "\n";
    return 0;
}
