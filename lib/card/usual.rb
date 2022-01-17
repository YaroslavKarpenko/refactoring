class Usual < Card
  def type
    USUAL_CARD
  end

  def number
    @card_number ||= generate_card
  end

  def starting_balance
    50.00
  end

  private

  def withdraw_percent
    5
  end

  def put_percent
    2
  end

  def send_basic
    20
  end
end
