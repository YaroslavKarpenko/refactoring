class Capitalist < Card
  def type
    CAPITALIST_CARD
  end

  def number
    @card_number ||= generate_card
  end

  def starting_balance
    100.00
  end

  private

  def put_basic
    10
  end

  def send_percent
    10
  end

  def withdraw_basic
    4
  end
end
