# Read input
N = int(input())  # Number of clues
clues = list(map(int, input().split()))  # List of clues

# Initialize smallest with the first clue
smallest = clues[0]

# Iterate through the clues to find the smallest
for clue in clues:
    if clue < smallest:
        smallest = clue

# Output the smallest clue
print(smallest)
