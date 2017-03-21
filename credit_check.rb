require 'pry'
# take a card number string
# split the card number into string items of an array
# change the strings into integers
# enumerably form a new array with |double then if greater than 9, minus 9| the odd index digits to produce the mutated array
# sum the new array
# form the check digit by subtracting the last digit of the sum from 10
# (sum of the selectively doubled array + the check digit) modulo 10, if 0 valid, if not invalid
class CreditChecker
  attr_reader :card_string,:doubled, :undoubled
  attr_accessor :presum, :check_digit, :sum, :check_number
  def initialize(card_string)
    @card_string = card_string
  end

  def run
    selective_doubler
    doubled_refiner
    flatter_zipper
    summer
    checker_digit
    validate
  end

  def card_digits
    @card_digits ||= card_string.each_char.map(&:to_i)
  end

  def selective_doubler
    @doubled = []
    @undoubled = []
    card_digits.each_with_index do |digit,index|
          if index.odd?
            digit = digit * 2
            @doubled << digit
          else
            @undoubled << digit
          end
        end
  end
  # def cleaner_doubler
  #   @doubled =[]
  #   card_digits.

  def doubled_refiner
    doubled.map! do |digit|
      if digit>9
        digit-9
      else
        digit
      end
    end
  end

  def flatter_zipper
    @presum = undoubled.zip(doubled).flatten
  end

  def summer
    self.sum = @presum.reduce(:+)
  end

  def checker_digit
    check_number = sum % 10
    self.check_digit = (10 - check_number)
  end

  def validate
    if (sum + check_digit) % 10 == 0
      puts "The number is valid!"
    else
      puts "The number is invalid!"
    end
  end
end

CreditChecker.new("4929735477250543").run
