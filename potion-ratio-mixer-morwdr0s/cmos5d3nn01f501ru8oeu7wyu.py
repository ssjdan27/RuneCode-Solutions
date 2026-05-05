def main():
    A, B, X, Y = map(int, input().split())

    # Check if already correct
    if A * Y == B * X:
        print("CORRECT")
        return

    # Try fixing A
    if (B * X) % Y == 0:
        new_A = (B * X) // Y
        k = new_A - A
        if k >= 0:
            print(f"ADD A {k}")
            return

    # Try fixing B
    if (A * Y) % X == 0:
        new_B = (A * Y) // X
        k = new_B - B
        if k >= 0:
            print(f"ADD B {k}")
            return

    print("IMPOSSIBLE")

if __name__ == "__main__":
    main()