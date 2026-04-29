#include <bits/stdc++.h>
using namespace std;

struct Pt { long double x, y; };
struct Circle { Pt c; long double r; bool valid = false; };
inline long double sq(long double v){ return v*v; }
inline long double dist(const Pt&a,const Pt&b){ return hypotl(a.x-b.x,a.y-b.y); }
Circle circleFrom1(const Pt&a){ return {a,0,true}; }
Circle circleFrom2(const Pt&a,const Pt&b){
    Pt c{(a.x+b.x)/2,(a.y+b.y)/2};
    return {c, dist(a,b)/2, true};
}
Circle circleFrom3(const Pt&a,const Pt&b,const Pt&c){
    long double d = 2*(a.x*(b.y-c.y)+b.x*(c.y-a.y)+c.x*(a.y-b.y));
    if(fabsl(d)<1e-18L) return {{0,0},0,false};
    long double ax2=sq(a.x)+sq(a.y), bx2=sq(b.x)+sq(b.y), cx2=sq(c.x)+sq(c.y);
    long double ux=(ax2*(b.y-c.y)+bx2*(c.y-a.y)+cx2*(a.y-b.y))/d;
    long double uy=(ax2*(c.x-b.x)+bx2*(a.x-c.x)+cx2*(b.x-a.x))/d;
    Pt center{ux,uy};
    return {center, dist(center,a), true};
}
bool contains(const Circle&C,const Pt&p){
    return hypotl(C.c.x-p.x,C.c.y-p.y) <= C.r+1e-9L;
}
Circle minimumEnclosingCircle(vector<Pt> pts){
    mt19937_64 rng(123456789);
    shuffle(pts.begin(), pts.end(), rng);
    Circle C;
    for(size_t i=0;i<pts.size();i++){
        if(C.valid && contains(C,pts[i])) continue;
        C=circleFrom1(pts[i]);
        for(size_t j=0;j<i;j++) if(!contains(C,pts[j])){
            C=circleFrom2(pts[i],pts[j]);
            for(size_t k=0;k<j;k++) if(!contains(C,pts[k])){
                Circle T=circleFrom3(pts[i],pts[j],pts[k]);
                if(T.valid) C=T;
            }
        }
    }
    return C;
}
int main(){
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int N; cin>>N; vector<Pt>P(N); for(auto&i:P)cin>>i.x>>i.y;
    Circle C=minimumEnclosingCircle(P);
    vector<int>res; for(int i=0;i<N;i++){
        long double d=hypotl(P[i].x-C.c.x,P[i].y-C.c.y);
        if(fabsl(d-C.r)<=1e-9L*max(1.0L,C.r)) res.push_back(i+1);
    }
    sort(res.begin(),res.end());
    for(int i=0;i<(int)res.size();i++) cout<<(i?" ":"")<<res[i];
    cout<<"\n";
}