class AccountActions
  include Constants
  include DataActions
  include Helper
  include Validation

  attr_accessor :console

  def initialize(console)
    @console = console
  end

  def create_account
    loop do
      new_account = Account.new(create_account_fields)
      new_account.errors.push(display('validation.login.exists')) if value_exist?(new_account.login, accounts.map(&:login))

      break new_account if new_account.no_errors?

      show_errors(new_account.errors)
    end
  end

  def load_account
    loop do
      authentication_data = account_authentication_variables
      if accounts.empty?
        return create_the_first_account 
      end

      if accounts.any? { |account| account.confirmed?(authentication_data) }
        return @current_account = accounts.find { |account| authentication_data[:login] == account.login }
      end

      display('errors.no_account')
    end
  end

  def create_the_first_account

    if user_input('main.create_first_account') == Constants::AGREE
      console.create
    else
      console.console
    end
  end

  def destroy_account(current_account)
    return unless agree?(user_input('main.destroy_account'))

    remaining_accounts = accounts.delete_if { |checking_account| checking_account.login == current_account.login }
    save(Constants::FILE_PATH, remaining_accounts)
  end

  def create_account_variables
    { name: user_input('input.name'),
      age: user_input('input.age').to_i,
      login: user_input('input.login'),
      password: user_input('input.password') }
  end

  def account_authentication_variables
    { login: user_input('input.login'),
      password: user_input('input.password') }
  end

  def confirmed?(data)
    @login == data[:login] && @password == data[:password]
  end

end
