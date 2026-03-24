import sys

def main():
  data = sys.stdin.read().strip().split()
  it = iter(data)

  n = int(next(it))
  k = int(next(it))

  counts = {}
  for i in range(1, n + 1):
    x = int(next(it))
    counts[x] = counts.get(x, 0) + 1
    if counts[x] == k:
      print(x, i)
      return

  print(-1)

if __name__ == "__main__":
  main()