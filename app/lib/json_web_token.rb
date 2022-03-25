
class JsonWebToken
    USER_SECRET_KEY = Rails.application.credentials.jwt[:USER_SECRET_KEY]. to_s
    #USER_SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, USER_SECRET_KEY)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, USER_SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end