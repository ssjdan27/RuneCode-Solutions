def max_potency_with_budget(N, B, potency, cost):
    start = 0
    max_potency = 0
    current_cost = 0
    current_potency = 0

    for end in range(N):
        current_cost += cost[end]
        current_potency += potency[end]

        while current_cost > B:
            current_cost -= cost[start]
            current_potency -= potency[start]
            start += 1

        max_potency = max(max_potency, current_potency)

    return max_potency

# Input
N, B = map(int, input().split())
potency = list(map(int, input().split()))
cost = list(map(int, input().split()))

# Output
print(max_potency_with_budget(N, B, potency, cost))