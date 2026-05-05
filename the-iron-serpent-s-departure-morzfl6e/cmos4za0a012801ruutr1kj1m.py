def main():
    n, m = map(int, input().split())

    # Build adjacency list and in-degree array
    graph = [[] for _ in range(n + 1)]
    indegree = [0] * (n + 1)

    for _ in range(m):
        u, v = map(int, input().split())
        graph[u].append(v)
        indegree[v] += 1

    # Initialize queue with all preparations that have no prerequisites
    queue = []
    for u in range(1, n + 1):
        if indegree[u] == 0:
            queue.append(u)

    head = 0
    result = []

    while head < len(queue):
        u = queue[head]
        head += 1
        result.append(u)

        for v in graph[u]:
            indegree[v] -= 1
            if indegree[v] == 0:
                queue.append(v)

    if len(result) == n:
        output = []
        for x in result:
            output.append(str(x))
        print(' '.join(output))
    else:
        print(-1)

def main_entry():
    main()

main_entry()