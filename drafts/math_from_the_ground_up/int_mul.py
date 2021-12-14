from itertools import zip_longest
# int multiplication without math library

# mult("123134254", "32131")
# we already know the algorithm!
# let's go back to our primary school and experience the hardship


# def mult_digit(digit1, digit2): ...

multiplication_table = [
    ['1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9'],
    ['2',  '4',  '6',  '8', '10', '12', '14', '16', '18'],
    ['3',  '6',  '9', '12', '15', '18', '21', '24', '27'],
    ['4',  '8', '12', '16', '20', '24', '28', '32', '36'],
    ['5', '10', '15', '20', '25', '30', '35', '40', '45'],
    ['6', '12', '18', '24', '30', '36', '42', '48', '54'],
    ['7', '14', '21', '28', '35', '42', '49', '56', '63'],
    ['8', '16', '24', '32', '40', '48', '56', '64', '72'],
    ['9', '18', '27', '36', '45', '54', '63', '72', '81']
    ]

# Yep you had to remember that
# There are duplicates and we need number to index them!


multiplication_dict = {
    ('1', '1'): '1', ('1', '2'): '2', ('2', '2'): '4', ('1', '3'): '3', ('2', '3'): '6',
    ('3', '3'): '9', ('1', '4'): '4', ('2', '4'): '8', ('3', '4'): '12', ('4', '4'): '16',
    ('1', '5'): '5', ('2', '5'): '10', ('3', '5'): '15', ('4', '5'): '20', ('5', '5'): '25',
    ('1', '6'): '6', ('2', '6'): '12', ('3', '6'): '18', ('4', '6'): '24', ('5', '6'): '30',
    ('6', '6'): '36', ('1', '7'): '7', ('2', '7'): '14', ('3', '7'): '21', ('4', '7'): '28',
    ('5', '7'): '35', ('6', '7'): '42', ('7', '7'): '49', ('1', '8'): '8', ('2', '8'): '16',
    ('3', '8'): '24', ('4', '8'): '32', ('5', '8'): '40', ('6', '8'): '48', ('7', '8'): '56',
    ('8', '8'): '64', ('1', '9'): '9', ('2', '9'): '18', ('3', '9'): '27', ('4', '9'): '36',
    ('5', '9'): '45', ('6', '9'): '54', ('7', '9'): '63', ('8', '9'): '72', ('9', '9'): '81'}




def mult_digit(digit1, digit2):
    if digit1 == '0' or digit2 == '0':
        return '0'
    if (digit1, digit2) in multiplication_dict:
        return multiplication_dict[(digit1, digit2)]
    else:
        return multiplication_dict[(digit2, digit1)]

# def mult1(number, digit): ...

def mult_next_hmmmm(digit_nxt, digit, carry):
    result = mult_digit(digit_nxt, digit)
    result = result + carry
    if len(result) == 1:
        next_carry = '0'
    else:
       assert len(result) == 2
       next_carry, result = list(mult_result)
    return next_carry, result

# Notice the mistake?
# there is no plus here!
# back to addition!
# def plus(digit1, digit2): ...
# we did not even notice that we have remembered an addition table all along!

addition_dict = {
    ('1', '1'): '2', ('1', '2'): '3', ('2', '2'): '4', ('1', '3'): '4', ('2', '3'): '5',
    ('3', '3'): '6', ('1', '4'): '5', ('2', '4'): '6', ('3', '4'): '7', ('4', '4'): '8',
    ('1', '5'): '6', ('2', '5'): '7', ('3', '5'): '8', ('4', '5'): '9', ('5', '5'): '10',
    ('1', '6'): '7', ('2', '6'): '8', ('3', '6'): '9', ('4', '6'): '10', ('5', '6'): '11',
    ('6', '6'): '12', ('1', '7'): '8', ('2', '7'): '9', ('3', '7'): '10', ('4', '7'): '11',
    ('5', '7'): '12', ('6', '7'): '13', ('7', '7'): '14', ('1', '8'): '9', ('2', '8'): '10',
    ('3', '8'): '11', ('4', '8'): '12', ('5', '8'): '13', ('6', '8'): '14', ('7', '8'): '15',
    ('8', '8'): '16', ('1', '9'): '10', ('2', '9'): '11', ('3', '9'): '12', ('4', '9'): '13',
    ('5', '9'): '14', ('6', '9'): '15', ('7', '9'): '16', ('8', '9'): '17', ('9', '9'): '18'}

# Yes, this thing occupies you precious memory


def add_digit(digit1, digit2):
    if digit1 == '0':
        return digit2
    if digit2 == '0':
        return digit1
    if (digit1, digit2) in addition_dict:
        return addition_dict[(digit1, digit2)]
    else:
        return addition_dict[(digit2, digit1)]

def mult_next_yep(digit_nxt, digit, carry):
    result = mult_digit(digit_nxt, digit)
    result = add_digit(result, carry)
    if len(result) == 1:
        next_carry = '0'
    else:
       assert len(result) == 2
       next_carry, result = list(mult_result)
    return next_carry, result

# There's still numbers in them
def extract_carry(result):
    try:
        carry, result = list(result)
    except ValueError as e:
        assert e.args == ('not enough values to unpack (expected 2, got 1)',)
        carry = '0'
    return result, carry

def mult_next(digit_nxt, digit, carry):
    result = mult_digit(digit_nxt, digit)
    result = add_digit(result, carry)
    result, next_carry = extract_carry(result)
    return next_carry, result

def mult1(number, digit):
    digit_list = list(number)
    carry = '0'
    results = []
    while digit_list:
        nxt_digit = digit_list.pop()
        carry, result = mult_next(nxt_digit, digit, carry)
        results.append(result)
    if carry != '0':
        results.append(carry)
    results.reverse()
    return ''.join(results)

def mult_hmmm(number1, number2):
    mult1_results = []
    right0s = ''
    current_sum = '0'
    for digit in number2:
        mult1_result = mult1(number1, digit)
        mult1_result = f"{mult1_result}{right0s}"
        # current_sum = add(current_sum,  mult1_result)
        right0s = f"{right0s}0"
    return current_sum

def add(number1, number2):
    carry = '0'
    results = []
    for digit1, digit2 in zip_longest(reversed(number1), reversed(number2), fillvalue='0'):
        result = add_digit(digit1, digit2)
        tmp_result, tmp_carry = extract_carry(result)
        if tmp_carry == '0':
            result = add_digit(result, carry)
            result, carry = extract_carry(result)
        else:
            result = add_digit(tmp_result, carry)
            result, carry = extract_carry(result)
            carry = add_digit(carry, tmp_carry)
        results.append(result)
    if carry != '0':
        results.append(carry)
    results.reverse()
    return ''.join(results)

def mult(number1, number2):
    mult1_results = []
    right0s = ''
    current_sum = '0'
    for digit in reversed(number2):
        mult1_result = mult1(number1, digit)
        mult1_result = f"{mult1_result}{right0s}"
        current_sum = add(current_sum,  mult1_result)
        right0s = f"{right0s}0"
    return current_sum

print(add("89878", "2312"))
print(mult("1231", "24312"))
print(mult1("1231", "2"))


# Nice bonus: arbitrary long
## 