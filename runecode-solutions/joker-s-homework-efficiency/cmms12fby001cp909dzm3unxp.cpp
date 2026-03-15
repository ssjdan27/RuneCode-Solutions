#include <bits/stdc++.h>
using namespace std;

// Define the job structure
struct Job {
    long long a, b; // A_i (Joker's time) and B_i (Morgana's time)
    int original_idx; // Original 1-based index
};
vector<Job> johnsons_rule(vector<Job> jobs) {
    vector<Job> s_a; // M1 Priority (A < B)
    vector<Job> s_b; // M2 Priority (A >= B)
    
    for (const Job& j : jobs) {
        if (j.a < j.b)
            s_a.push_back(j);
        else
            s_b.push_back(j);
    }
    
    // Sort S_A ascending by A_i
    sort(s_a.begin(), s_a.end(), [](const Job& x, const Job& y) {
        return x.a < y.a;
    });
    
    // Sort S_B descending by B_i
    sort(s_b.begin(), s_b.end(), [](const Job& x, const Job& y) {
        return x.b > y.b;
    });

    // The final order is S_A followed by S_B
    s_a.insert(s_a.end(), s_b.begin(), s_b.end());
    return s_a;
}
long long calculate_makespan(const vector<Job>& jobs) {
    long long t1_finish = 0; // Joker's (M1) finish time
    long long t2_finish = 0; // Morgana's (M2) finish time

    for (const Job& j : jobs) {
        // Joker's finish time for this job
        t1_finish += j.a;
        // Morgana can only start after he's free AND after Joker finishes this job
        t2_finish = max(t2_finish, t1_finish) + j.b;
    }
    // The makespan is Morgana's final finish time
    return t2_finish;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int N; 
    cin >> N;
    vector<Job> jobs(N);
    for (int i = 0; i < N; ++i) {
        cin >> jobs[i].a >> jobs[i].b;
        jobs[i].original_idx = i + 1; // Store 1-based index
    }
    vector<Job> optimal_schedule = johnsons_rule(jobs);
    long long min_makespan = calculate_makespan(optimal_schedule);
    cout << min_makespan << "\n";
    
    return 0;
}