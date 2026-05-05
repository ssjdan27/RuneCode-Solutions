# Dijkstra's Algorithm WITHOUT imports (custom min-heap)

def heappush(h, item):
    # item is (distance, node)
    h.append(item)
    i = len(h) - 1

    # bubble up
    while i > 0:
        p = (i - 1) // 2
        if h[p][0] <= item[0]:
            break
        h[i] = h[p]
        i = p
    h[i] = item


def heappop(h):
    # remove and return smallest item
    root = h[0]
    last = h.pop()

    if h:
        i = 0
        n = len(h)

        # push last down
        while True:
            left = 2 * i + 1
            right = left + 1

            if left >= n:
                break

            # choose smaller child
            child = left
            if right < n and h[right][0] < h[left][0]:
                child = right

            if h[child][0] >= last[0]:
                break

            h[i] = h[child]
            i = child

        h[i] = last

    return root


# ---- Main program ----
N, M = map(int, input().split())
graph = [[] for _ in range(N + 1)]

for _ in range(M):
    u, v, w = map(int, input().split())
    graph[u].append((v, w))
    graph[v].append((u, w))  # undirected

INF = float('inf')
dist = [INF] * (N + 1)
dist[1] = 0

heap = []
heappush(heap, (0, 1))  # (distance, node)

while heap:
    d, node = heappop(heap)

    # If this popped distance is outdated, skip it
    if d != dist[node]:
        continue

    # Optional early stop: once we pop N, it's finalized
    if node == N:
        break

    for nxt, w in graph[node]:
        nd = d + w
        if nd < dist[nxt]:
            dist[nxt] = nd
            heappush(heap, (nd, nxt))

print(dist[N] if dist[N] != INF else -1)