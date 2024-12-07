% picoCTF 2023 Writeup: Virtual Machine 0

# [Virtual Machine 0](https://play.picoctf.org/events/72/challenges/challenge/385): What happened?

[picoCTF](https://picoctf.org/) 2023 featured a pair of challenges in the Reverse Engineering category named Virtual Machine 0 and 1. Each challenge provided a 3D model of a gear train built of standard LEGO parts, along with a number. The idea was that the player would calculate the gear ratio through the system, then use that ratio to answer the question: if you spun the input wheel $INPUT times, how many times would the output wheel spin?

For VM1, players would connect to an instance server that would give them an input, they'd do the math, submit the output's rotations to the server, and the server would return the flag. Or so I'm told; I didn't attempt VM1 because I got the general idea of it from VM0.

VM0 was just a little different. The input was provided in a file for the player to download, then the output could be interpreted as ASCII to retrieve the flag. That's it.

> I have not solved vm0, and believe I have tried all common encoding, and have spent many hours on it.

> vm0 is 5% rev eng / 95% crypto

> Can we agree that vm0 is actually a cryptography question and not reverse engineering

> the only tool i find working for this chall is from a specific crypto library

I'll acknowledge that it's a bit of a stretch from typical reverse engineering CTF questions, sure; the whole challenge was a pun anyways. But cryptography? I'm not here to rip on anyone who didn't get it, or who spent hours racking their brain trying to figure it out---that's how learning happens, and if you learned anything (whether it solved the challenge or not) then you won! Be proud. I'm here to take a look at what happened with this seemingly harmless toy challenge.

------------

Let's say you open your input file, and this is the number you got:

> 666438785507794230575725954260915292651217318653339189503571037950055032629420313

And suppose you open your Digital Asset Exchange file (`.dae`), and you do the things, and you find that the in:out ratio of your gear train is 5 (I chose this for convenience, not because it's the real number). You "rotate" the input shaft 666438785507794230575725954260915292651217318653339189503571037950055032629420313 times, and the output shaft rotates 3332193927538971152878629771304576463256086593266695947517855189750275163147101565 times. Great. Now what?

Well, it's ASCII. Written as a large decimal number. You could write it as a large hexadecimal number:

```dc
~> dc
# set output to base 16; input is base 10 by default
16o
# push our number on the stack
3332193927538971152878629771304576463256086593266695947517855189750275163147101565
# print it, written in the output base (16)
p
7069636F4354467B74336D7031335F30355F345F6C3166335F63616665626162657D
```

(`dc` is my go-to calculator; you can find it in the `bc` package. It's not a cryptographic tool any more than any other arbitrary-precision RPN calculator from the 70s.)

If you hand that hex string to anyone who tried the challenge, they'd probably have the answer straight away---a zillion tools out there can interpret a string of hex digits as ASCII. But at the end of the day, it's not (just) a sequence of two-nybble chars: it's a number, if you look at it as a number. One big number! One big number that you could write just as easily in decimal (333...1565), or in binary, or octal... Written in decimal, suddenly the selection of tools willing to interpret that number directly as ASCII drops off sharply, and since many players apparently haven't thought this way about the relationship between ASCII encoding and bits and bytes and big numbers, we end up with no idea how to interpret this Very Big Number.

If you wrote this big number into memory, it'd be a long string of 0's and 1's, right? If you wrote a string of text into memory, ASCII-encoded, it'd also be a long string of 0's and 1's. Did we convert it to binary? Was that an important step? Meh, not really, a number is just a number. It was already binary inside the computer.

Most solutions will probably involve carving it up in chunks of 256 and then casting those as chars. I just happened to know a tool that doesn't mind printing arbitrary numbers as ASCII:

```dc
~> dc
# push our number on the stack, in decimal (the default input radix)
3332193927538971152878629771304576463256086593266695947517855189750275163147101565
# and print it as ASCII!
P
picoCTF{t3mp13_05_4_l1f3_cafebabe}
```

I swear, it's not a cryptographic tool! It's just a nice calculator that predates C. And happens to print arbitrary numbers as ASCII. And supports sparse arrays, and named registers, and macro evaluation...okay so it's a little bit of a programming language, but still, it's a calculator at heart. :)

This concludes the tragic tale of Virtual Machine 0: a simple primer to lay the foundation for its sequel challenge, with a probably-accidental twist that everyone overshot.