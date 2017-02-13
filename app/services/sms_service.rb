class SmsService
  include Translatable

  BASE_URL = -'https://smsapi.24x7sms.com/api_2.0/SendSMS.aspx'

  def initialize(mobile_number, template, variables)
    @mobile_number = mobile_number
    @template = template
    @variables = variables
  end

  def execute
    return unless Rails.env.production?

    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(params)

    # Use a simple GET request.
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      Rails.logger.info("Successfully sent SMS (#{@template}) to #{@mobile_number}. Response from SMS Service: #{response.body}")
    else
      Rails.logger.error("Failed to send SMS to #{@mobile_number}. Template: #{@template}. Variables: #{@variables.to_json}")
    end
  end

  private

  def params
    {
      SenderID: 'GoDrmC',
      ServiceName: 'TEMPLATE_BASED',
      MobileNo: @mobile_number,
      APIKEY: Rails.application.secrets.sms_service_api_key,
      Message: message,
    }
  end

  def message
    t("sms_service.templates.#{@template}", @variables)
  end
end
