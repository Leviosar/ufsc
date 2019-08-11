n = int(input('Digite  o número (1 <= n < 4000 ): '))

numeric_to_roman = {
    1000: 'M',
    900: 'CM',
    500: 'D',
    400: 'CD',
    100: 'C',
    90: 'XC',
    50: 'L',
    40: 'XL',
    10: 'X',
    9: 'IX',
    5: 'V',
    4: 'IV',
    1: 'I',
}

roman_result = ''

for numeric_value in numeric_to_roman:
    div = n // numeric_value
    n = n % numeric_value

    roman_result += div * numeric_to_roman[numeric_value]

print(roman_result)