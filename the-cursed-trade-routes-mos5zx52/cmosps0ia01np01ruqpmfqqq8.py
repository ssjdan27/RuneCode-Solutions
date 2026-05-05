def main():
    n, m = map(int, input().split())

    edges = []
    # Build reversed graph for reachability check from N
    rev_graph = [[] for _ in range(n + 1)]

    for _ in range(m):
        u, v, w = map(int, input().split())
        edges.append((u, v, w))
        rev_graph[v].append(u)

    INF = float('inf')
    dist = [INF] * (n + 1)
    dist[1] = 0

    # Run N-1 relaxation rounds
    for _ in range(n - 1):
        for u, v, w in edges:
            if dist[u] != INF and dist[u] + w < dist[v]:
                dist[v] = dist[u] + w

    # Run Nth round to detect negative cycles
    on_negative_cycle = []
    for u, v, w in edges:
        if dist[u] != INF and dist[u] + w < dist[v]:
            on_negative_cycle.append(v)

    # BFS on reversed graph from city N to find what can reach N
    can_reach_n = [False] * (n + 1)
    queue = [n]
    head = 0
    can_reach_n[n] = True

    while head < len(queue):
        node = queue[head]
        head += 1
        for neighbor in rev_graph[node]:
            if not can_reach_n[neighbor]:
                can_reach_n[neighbor] = True
                queue.append(neighbor)

    # Check if any negative cycle node can reach N
    for node in on_negative_cycle:
        if can_reach_n[node]:
            print("CURSED")
            return

    if dist[n] == INF:
        print(-1)
    else:
        print(dist[n])

def main_entry():
    main()

main_entry()