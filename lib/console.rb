class Console
  include Constants
  include Helper
  include Validation
  include DataActions

  attr_accessor :current_account, :account_actions, :card_actions, :money_actions

  def initialize
    @account_actions = AccountActions.new(self)
    @card_actions = CardActions.new(self)
    @money_actions = MoneyActions.new(self)
  end

  def console
    input = user_input(:greetings)

    case input
    when Constants::CREATE
      create
    when Constants::LOAD
      load
    else
      exit
    end
  end

  def create
    @current_account = account_actions.create_account
    update_current_account(current_account)

    new_accounts = accounts << current_account

    save(Constants::FILE_PATH, new_accounts)
    main_menu
  end

  def load
    @current_account = account_actions.load_account
    update_current_account(current_account)

    main_menu
  end

  def main_menu
    loop do
      display(:welcome, user_name: current_account.name)
      input = user_input(:main_menu)

      break Constants::EXIT if exit?(input)

      check_input(input)
    end
  end

  private

  def check_input(input)
    input = input.upcase

    case input
    when *Constants::CARD_COMMANDS
      select_card_command(command)
    when *Constants::MONEY_COMMANDS
      select_money_command(command)
    when Constants::OPERATIONS[:destroy_account]
      account_actions.destroy_account(current_account)
    else
      display('errors.wrong_command')
    end
  end

  def update_current_account(account)
    card_actions.current_account(account)
    money_actions.current_account(account)
  end

  def select_card_command(command)
    case command.upcase
    when Constants::OPERATIONS[:show_cards]
      card_actions.show_cards
    when Constants::OPERATIONS[:create_card]
      card_actions.create_card
    when Constants::OPERATIONS[:destroy_card]
      card_actions.destroy_card
    when Constants::EXIT
      main_menu
    else
      display('errors.wrong_command')
    end
  end

  def select_money_command(command)
    case command
    when Constants::OPERATIONS[:put_money]
      money_actions.put_money
    when Constants::OPERATIONS[:withdraw_money]
      money_actions.withdraw_money
    when Constants::OPERATIONS[:send_money]
      money_actions.send_money
    when Constants::EXIT
      main_menu
    else
      display('errors.wrong_command')
    end
  end
end
