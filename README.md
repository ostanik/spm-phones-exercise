# Phones - pnc v0.1

Given a file with valid area codes** and a second file with potential phone numbers, print the count of valid phone numbers by valid area code. Only the lines (of the second file) that include a valid phone number (and nothing more) according to the following rules should be accounted for:

 - has either 3 digits or between 7 and 12 digits (inclusive)
 - can have the optional '+' character in the beginning (before any digit)
 - can start with '00', in which case it shouldn't start with the '+' sign
 - if it starts with '00', these two digits don't count to the maximum number of digits
 - cannot have any letters
 - cannot have any symbol aside from the beginning '+' sign
 - cannot have any whitespace between the '+' sign and the first digit but can have any amount of whitespace in all other places

## Interface

The interface we're expecting is:

  `$ your_script input_file`

As for the output, for the following input file:
```
+351960000000
00351961111111
+351210000000
+35112
+244910000000
```
We would expect the result to be (note that the area codes in the output should be alphabetically sorted):
```
244:1
351:3
```
## Valid/invalid numbers

Some valid numbers:
```
112
911
991
+112
000
+351960000000
00351960000000
```
Some invalid numbers:
```
+00112
0012
```

## Development
### Instal dependency
`$ swift package update`
### Build project
`$ swift build`
### Run project
`$ swift run Phones <path/to/phone_numbers.txt>`
### Tests
`$ swift test`