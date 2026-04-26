#include <iostream>
#include <algorithm>

using namespace std;

int main() {
    long long a,b,c;
    cin >> a >> b >> c;
    long long largest = max({a,b,c});
    cout << largest << "\n";
    return 0;
}

