class MoneyActions
  include Constants
  include DataActions
  include Helper
  include Validation

  attr_accessor :console, :current_account

  def initialize(console)
    @console = console
  end

  def current_account(current_account)
    @current_account = current_account
  end

  def withdraw_money
    cards = []
    display('main.choose_card_withdrawing')

    card = find_card(current_account)

    return unless card || withdrawing(card, user_input('main.withdraw_amount').to_i)

    cards.push(current_account)

    save_cards_data(cards)
  end

  def put_money
    cards = []
    display('main.choose_card_puting')

    card = find_card(current_account)

    return unless card || puting(current_card, user_input('main.input_amount').to_i)

    cards.push(current_account)

    save_cards_data(cards)
  end

  def send_money
    cards = []
    display('main.choose_card_sending')

    sender_card = find_card(current_account)
    recipient_card = find_card_number

    return unless (recipient_card && sender_card) || sending(sender_card, recipient_card, user_input('main.withdraw_amount').to_i)

    cards.push(current_account)
    save_cards_data(cards)
  end
  private

  def save_cards_data(data)
    save(Constants::FILE_PATH, data)
  end

  def withdrawing(current_card, amount)
    return false unless positive_amount?(amount)

    return false if withdraw_not_enough?(current_card.balance, amount, current_card.withdraw_tax(amount))
    current_card.withdraw(amount)
    display_withdrawing(amount, current_card)
    true
  end

  def puting(current_card, amount)
    return false unless positive_amount?(amount)

    return false if put_not_enough?(amount, current_card.put_tax(amount))
    current_card.put(amount)
    display_putting(amount, current_card.number, current_card.put_tax(amount), current_card.balance)
    true
  end

  def sending(sender_card, recipient_card, amount)
    return false unless positive_amount?(amount)

    return false if withdraw_not_enough?(sender_card.balance, amount, sender_card.withdraw_tax(amount))
    return false if send_not_enough?(amount, recipient_card.put_tax(amount))

    sender_card.withdraw(amount)
    recipient_card.put(amount)

    display_putting(amount, sender_card, sender_card.sender_tax(amount), sender_card.balance)
    display_putting(amount, recipient_card, recipient_card.put_tax(amount), recipient_card.balance)
    true
  end

  def withdraw_not_enough?(balance, amount, tax)
    if balance > tax + amount
      return false
    end 
    display('errors.not_enough')
    true
  end

  def put_not_enough?(amount, tax)
    if tax < amount
      return false 
    end
    display('errors.tax_higher')
    true
  end

  def send_not_enough?(amount, tax)
    if tax < amount
      return false 
    end
    display('errors.not_enough_sender')
    true
  end

  def positive_amount?(amount)
    return true if amount.positive?

    display('errors.wrong_amount')
    false
  end

  def display_withdrawing(amount, card)
    display(
      'money.withdraw',
      amount: amount,
      number: card.number,
      tax: card.withdraw_tax(amount),
      balance: card.balance
    )
  end

  def display_putting(amount, number, tax, balance)
    display(
      'money.put',
      amount: amount,
      number: number,
      tax: tax,
      balance: balance
    )
  end
end
