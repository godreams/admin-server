module Users
  class CreateService
    def self.create(attributes)
      user = User.new(attributes)

      require 'faker'
      password = Faker::Color.color_name + Faker::Hipster.word
      user.password = password
      raise 'Invalid attributes' unless user.valid?

      user.save!
      UsersMailer.send_password(user, password).deliver_now

      user
    end

    def self.find_or_create(attributes)
      user = User.with_email(attributes[:email])
      return user if user.present?
      create(attributes)
    end
  end
end
