class JsonWebTokenService
  def self.encode(payload, expires: 1.month.from_now)
    payload[:exp] = expires.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end
