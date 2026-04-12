#include <bits/stdc++.h>
using namespace std;

int main(){
    int n;
    cin >> n;
    unordered_set<int> steps;
    int m = 0;
    int res = -1;
    for(int i = 0; i < n; i++){
        int s;
        cin >> s;
        m += s;
        if(steps.find(m) != steps.end()){
            res = i + 1;
            break;
        }
        steps.insert(m);
    }
    cout << res;
}