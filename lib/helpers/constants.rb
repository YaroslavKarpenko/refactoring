module Constants
  MIN_LOGIN_LENGTH = 4
  MAX_LOGIN_LENGTH = 20
  MIN_PASSWORD_LENGTH = 6
  MAX_PASSWORD_LENGTH = 30
  MIN_AGE = 23
  MAX_AGE = 90

  USUAL_CARD = 'usual'.freeze
  CAPITALIST_CARD = 'capitalist'.freeze
  VIRTUAL_CARD = 'virtual'.freeze
  CARD_DIGITS_RANGE = 10
  CARD_NUMBER_LENGTH = 16

  FILE_PATH = 'data/accounts.yml'.freeze

  CARD_TYPES = %w[capitalist usual virtual].freeze

  CREATE = 'create'.freeze
  LOAD = 'load'.freeze
  AGREE = 'y'.freeze
  EXIT = 'exit'.freeze

  CARD_COMMANDS = %w[CC SC DC].freeze
  MONEY_COMMANDS = %w[PM WM SM].freeze
  OPERATIONS = { show_cards: 'SC',
                 create_card: 'CC',
                 destroy_card: 'DC',
                 put_money: 'PM',
                 withdraw_money: 'WM',
                 send_money: 'SM',
                 destroy_account: 'DA' }.freeze
end
