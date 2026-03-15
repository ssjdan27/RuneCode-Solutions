#include <bits/stdc++.h>
using namespace std;

// Define the modulo value
const int MOD = 1e9 + 7;

int main() {
    // Fast I/O
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N, M, L, K;
    cin >> N >> M >> L >> K;

    // DP table. dp[i][j] = ways to reach (i, j).
    // We use (N+1) x (M+1) size.
    vector<vector<int>> dp(N + 1, vector<int>(M + 1, 0));

    // Base Case: 1 way to be at (0, 0)
    // We only set dp[0][0] if it's not the forbidden spot.
    // (Problem constraints guarantee L,K is not 0,0)
    dp[0][0] = 1;

    // Fill the DP table
    for (int i = 0; i <= N; ++i) {
        for (int j = 0; j <= M; ++j) {
            
            // Check if this is Lae'zel's spot
            if (i == L && j == K) {
                dp[i][j] = 0; // No paths can go *through* this spot
                continue; // Skip to the next cell
            }

            // Add paths from South (i, j-1)
            if (j > 0) {
                dp[i][j] += dp[i][j - 1];
                dp[i][j] %= MOD;
            }
            
            // Add paths from West (i-1, j)
            if (i > 0) {
                dp[i][j] += dp[i - 1][j];
                dp[i][j] %= MOD;
            }
        }
    }

    // The final answer is the number of ways to reach the destination (N, M)
    cout << dp[N][M] << '\n';

    return 0;
}