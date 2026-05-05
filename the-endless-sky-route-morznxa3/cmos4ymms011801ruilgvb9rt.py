def main():
    n = int(input())
    nxt = list(map(int, input().split()))

    # Convert to 0-indexed internally
    # nxt[i] is next waypoint from waypoint i+1 (1-indexed input)
    # -1 stays as -1 for terminal

    # Start both pointers at waypoint 1 (index 0 in 0-indexed)
    slow = 0
    fast = 0

    while True:
        # Move slow one step
        slow = nxt[slow] - 1 if nxt[slow] != -1 else -1

        # Move fast two steps — check each step
        if nxt[fast] == -1:
            print("NO")
            return
        fast = nxt[fast] - 1

        if nxt[fast] == -1:
            print("NO")
            return
        fast = nxt[fast] - 1

        # Check if terminal reached by slow
        if slow == -1:
            print("NO")
            return

        # Check if pointers meet
        if slow == fast:
            print("YES")
            return

def main_entry():
    main()

main_entry()