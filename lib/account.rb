class Account
  include Helper
  include AccountValidation

  attr_reader :name, :age, :login, :password, :errors
  attr_accessor :cards

  def initialize(args)
    @name = args[:name]
    @age = args[:age]
    @login = args[:login]
    @password = args[:password]

    @cards = []
    @errors = []
  end

  def no_errors?
    validate_name
    validate_age
    validate_login
    validate_password

    errors.empty?
  end

  def add_card(card)
    @cards << card
  end

  def delete_card(index)
    @cards.delete(index)
  end
end
