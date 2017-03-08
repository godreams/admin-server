class SmsService
  include Translatable

  BASE_URL = -'http://sms.digimiles.in/bulksms/bulksms'

  def initialize(mobile_number, template, variables)
    @mobile_number = mobile_number
    @template = template
    @variables = variables
  end

  def execute
    # return unless Rails.env.production?

    binding.pry
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(params)

    # Use a simple GET request.
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      response_code = response.body.to_i

      if response_code == 1701
        Rails.logger.info("Successfully sent SMS (#{@template}) to #{@mobile_number}.")
      else
        Rails.logger.error("Failed to send SMS to #{@mobile_number}. Error code: #{response_code}")
      end
    else
      Rails.logger.error("Failed to send SMS to #{@mobile_number}. Template: #{@template}. Variables: #{@variables.to_json}")
    end
  end

  private

  def params
    {
      username: Rails.application.secrets.sms_service_username,
      password: Rails.application.secrets.sms_service_password,
      type: 0,
      dlr: 1,
      destination: @mobile_number,
      source: 'GODRMS',
      message: message
    }
  end

  def message
    t("sms_service.templates.#{@template}", @variables)
  end
end
