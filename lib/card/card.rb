class Card
  include Constants

  attr_reader :number
  attr_accessor :card_balance

  def initialize
    @card_number = generate_card
    @card_balance = starting_balance
  end

  def put(money)
    @card_balance += money - put_tax(money)
  end

  def send(money)
    @card_balance -= money + send_tax(money)
  end

  def withdraw(money)
    @card_balance -= money + withdraw_tax(money)
  end

  def put_tax(money)
    tax(money, put_percent, put_basic)
  end

  def send_tax(money)
    tax(money, send_percent, send_basic)
  end

  def withdraw_tax(money)
    tax(money, withdraw_percent, withdraw_basic)
  end

  private

  def generate_card
    Constants::CARD_NUMBER_LENGTH.times.map { rand(Constants::CARD_DIGITS_RANGE) }.join
  end

  def starting_balance
    0
  end

  def tax(money, percent, basic)
    money * percent / 100.0 + basic
  end

  def put_percent
    0
  end

  def send_percent
    0
  end

  def withdraw_percent
    0
  end

  def put_basic
    0
  end

  def send_basic
    0
  end

  def withdraw_basic
    0
  end
end
