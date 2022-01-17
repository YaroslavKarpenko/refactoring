module Helper
  def show_all_cards(cards)
    cards.each do |card|
      display('cards.card', number: card.number, type: card.type)
    end
  end

  def display(message, parameters = {})
    puts I18n.t(message, **parameters)
  end

  def check_card_type
    loop do
      card_type = user_input('cards.create_card')
      break card_type if value_exist?(card_type, Constants::CARD_TYPES)

      display('errors.wrong_card_type')
    end
  end

  def find_card(current_account)
    return display('errors.no_active_cards') if current_account.cards.empty?

    card_position = find_position(current_account.cards)
    return if exit?(card_position)

    current_account.cards[card_position - 1]
  end

  def find_number
    card_number = user_input('main.choose_card_sending')
    validate_card_number(card_number)
    all_cards = accounts.map(&:cards).flatten

    return display('errors.no_card_number', number: card_number) unless all_cards.any? do |card|
      card.number == card_number
    end

    all_cards.find { |card| card.number == card_number }
  end

  def find_position(cards)
    loop do
      show_cards_with_index(cards)
      card = gets.chomp
      break(Constants::EXIT_COMMAND) if exit?(card)

      card_position = card.to_i
      break(card_position) if valid_number?(card_position, 1, cards.size)

      display('errors.wrong_number')
    end
  end

  def accounts
    load(@file_path)
  end

  def show_cards_with_index(cards)
    cards.each_with_index do |card, index|
      display('cards.card_with_index', number: card.number, type: card.type, index: index + 1)
    end
    display(:exit)
  end

  def show_errors(errors)
    errors.each { |i| puts i }
  end

  def agree?(command)
    command == Constants::AGREE
  end

  def user_input(message, parameters = {})
    display(message, parameters)
    gets.chomp
  end
end
