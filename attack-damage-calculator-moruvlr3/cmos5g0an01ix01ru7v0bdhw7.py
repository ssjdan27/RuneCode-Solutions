def main():
    n, d, k = map(int, input().split())

    crits = n // k
    normal = n - crits

    total_damage = normal * d + crits * 2 * d
    print(total_damage)

if __name__ == "__main__":
    main()