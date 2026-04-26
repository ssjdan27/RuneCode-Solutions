n=int(input())

for i in range(1, n + 1):
    # logic for FizzBuzz
    if i % 3 == 0 and i % 5 == 0:
        print("FizzBuzz")
    # logic for Fizz
    elif i % 3 == 0:
        print("Fizz")
    # logic for Buzz
    elif i % 5 == 0:
        print("Buzz")
    # otherwise  
    else:
        print(i)