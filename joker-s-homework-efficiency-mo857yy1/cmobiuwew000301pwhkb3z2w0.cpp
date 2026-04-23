#include <bits/stdc++.h>
using namespace std;

struct Job {
    long long a, b;
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;
    vector<Job> first, second;
    first.reserve(n);
    second.reserve(n);

    for (int i = 0; i < n; ++i) {
        Job job;
        cin >> job.a >> job.b;
        if (job.a < job.b) first.push_back(job);
        else second.push_back(job);
    }

    sort(first.begin(), first.end(), [](const Job& lhs, const Job& rhs) {
        return lhs.a < rhs.a;
    });
    sort(second.begin(), second.end(), [](const Job& lhs, const Job& rhs) {
        return lhs.b > rhs.b;
    });

    long long timeA = 0;
    long long timeB = 0;
    for (const Job& job : first) {
        timeA += job.a;
        timeB = max(timeB, timeA) + job.b;
    }
    for (const Job& job : second) {
        timeA += job.a;
        timeB = max(timeB, timeA) + job.b;
    }

    cout << timeB << '\n';
    return 0;
}
