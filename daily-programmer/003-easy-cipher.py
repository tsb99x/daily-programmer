"""

    https://www.reddit.com/r/dailyprogrammer/comments/pkw2m/2112012_challenge_3_easy/

    [2/11/2012] Challenge #3 [easy]

    Welcome to cipher day!

    write a program that can encrypt texts with an alphabetical caesar cipher.
    This cipher can ignore numbers, symbols, and whitespace.

    for extra credit, add a "decrypt" function to your program!

"""

from collections import deque

original = input('data to encrypt > ')
alphabet_shift = int(input('alphabet shift > '))

lower = [chr(x) for x in range(ord('a'), ord('z') + 1)]
deq = deque(lower)
deq.rotate(-alphabet_shift)

lower_map = dict(zip(lower, deq))
upper_map = {k.upper(): v.upper() for k, v in lower_map.items()}
encoding_map = {**lower_map, **upper_map}
decoding_map = {v: k for k, v in encoding_map.items()}

encoded = ''.join(encoding_map.get(ch, '') for ch in original)
print(f'encoded > {encoded}')

decoded = ''.join(decoding_map[ch] for ch in encoded)
print(f'decoded > {decoded}')
