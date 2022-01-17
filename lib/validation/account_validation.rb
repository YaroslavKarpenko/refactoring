module AccountValidation
  include Constants
  include Validation

  def validate_name
    add_error('validation.name.first_letter') if value_empty?(@name) || @name[0].upcase != @name[0]
  end

  def validate_age
    add_error('validation.age.length') unless valid_number?(@age, Constants::MIN_AGE, Validation::MAX_AGE)
  end

  def validate_login
    add_error('validation.login.present') if value_empty?(@login)
    add_error('validation.login.shorter') if value_long?(@login, Constants::MAX_LOGIN_LENGTH)
    add_error('validation.login.longer') if value_short?(@login, Constants::MIN_LOGIN_LENGTH)
  end

  def validate_password
    add_error('validation.password.present') if value_empty?(@password)
    add_error('validation.password.shorter') if value_long?(@password, Constants::MAX_PASSWORD_LENGTH)
    add_error('validation.password.longer') if value_short?(@password, Constants::MIN_PASSWORD_LENGTH)
  end

  def add_error(arr = @errors, error)
    arr.push(I18n.t(error))
  end
end
