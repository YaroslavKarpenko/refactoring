class CardActions
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

  def create_card
    accounts = []
    card_type = "#{check_card_type.capitalize}Card"
    card = Card.const_get(card_type.to_s).new

    current_account.add_card(card)
    accounts.push(current_account)
    save(Constants::FILE_PATH, accounts)
  end

  def destroy_card
    display('main.want_to_delete')
    card = find_card(current_account)

    return unless card || agree?(user_input('cards.confirm_deletion', number: card.number))

    current_account.delete_card(card)

    save_card(current_account)
  end

  def show_cards
    return display('errors.no_active_cards') unless current_account.cards.any?

    show_all_cards(current_account.cards)
  end

  def save_card(current_account)
    data = [current_account]

    save(Constants::FILE_PATH, data)
  end
end
