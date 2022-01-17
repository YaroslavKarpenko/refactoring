class Virtual < Card
  def type
    VIRTUAL_CARD
  end

  def number
    @card_number ||= generate_card
  end

  def starting_balance
    150.00
  end

  private

  def put_basic
    1
  end

  def send_basic
    1
  end

  def withdraw_percent
    12
  end
end
