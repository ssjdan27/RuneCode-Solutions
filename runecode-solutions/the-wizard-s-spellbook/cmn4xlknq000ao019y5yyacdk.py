def rearrange_words(S):
  # Split the string by spaces to get the words
    words = S.split()
    
    # Sort the words lexicographically
    words.sort()
    
    # Join the sorted words with spaces to get the result
    return ' '.join(words)
# Test the function
if __name__ == "__main__":
    # Read input string
    S = input().strip()
    
    # Call the function to rearrange and print the result
    print(rearrange_words(S))