class BaseException < StandardError
  def response
    { code: @code, message: @message, description: @description }
  end

  def status
    @status || 422
  end
end
