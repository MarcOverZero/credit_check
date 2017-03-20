require 'pry'
# take a card number string
# split the card number into string items of an array
# change the strings into integers
# enumerably form a new array with |double then if greater than 9, minus 9| the odd index digits to produce the mutated array
# sum the new array
# form the check digit by subtracting the last digit of the sum from 10
# (sum of the selectively doubled array + the check digit) modulo 10, if 0 valid, if not invalid
class CreditChecker
  attr_reader :card_string, :card_digits,:doubled, :undoubled
  attr_accessor :presum, :check_digit, :sum
  def initialize(card_string)
    @card_string = card_string
    @card_digits = card_digits
    @doubled = []
    @undoubled = []
    @presum = presum
    @check_digit = check_digit
    @sum = sum
    card_string_to_split_integers
  end

  def card_string_to_split_integers
    @card_digits = card_string.each_char.map(&:to_i)
    selective_doubler
  end

  def selective_doubler
    card_digits.each_with_index do |digit,index|
          if index.odd?
            doubled << digit
          else
            undoubled << digit
          end

        end
        doubled_refiner
  end

  def doubled_refiner
    doubled.map! do |digit|
      if digit>9
        digit-9
      else
        digit
      end
    end
    flat_zipper
  end

  def flat_zipper
    @presum = undoubled.zip(doubled).flatten
    summer
  end

  def summer
    sum = presum.reduce(:+)
    checker_digit
    binding.pry

  end

  def checker_digit
    check_number = (sum.to_s).split("")
    check_number.map! do |i|
      i.to_i unless i == nil
    end
    check_digit = (10 - check_number[-1])
    validate
  end

  def validate
    if (sum + check_digit) % 10 == 0
      prints "The number is valid!"
    else
      prints "The number is invalid!"
    end
  end
end

CreditChecker.new("4929735477250543")
