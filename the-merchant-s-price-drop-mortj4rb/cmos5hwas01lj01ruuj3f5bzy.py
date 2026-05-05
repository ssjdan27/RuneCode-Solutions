import sys

def main():
    data = sys.stdin.read().strip().split()
    it = iter(data)

    n = int(next(it))
    prices = [int(next(it)) for _ in range(n)]

    if n < 2:
        print("0 -1 -1")
        return

    min_price = prices[0]
    min_day = 1

    best_profit = 0
    best_buy = -1
    best_sell = -1

    for i in range(2, n + 1):
        price = prices[i - 1]
        profit = price - min_price

        if profit > best_profit:
            best_profit = profit
            best_buy = min_day
            best_sell = i
        elif profit == best_profit and profit > 0:
            if min_day < best_buy or (min_day == best_buy and i < best_sell):
                best_buy = min_day
                best_sell = i

        if price < min_price:
            min_price = price
            min_day = i

    if best_profit == 0:
        print("0 -1 -1")
    else:
        print(best_profit, best_buy, best_sell)

if __name__ == "__main__":
    main()