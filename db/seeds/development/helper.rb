require 'faker'

Faker::Config.locale = 'en-IND'

# because of https://github.com/stympy/faker/issues/285
I18n.reload!
