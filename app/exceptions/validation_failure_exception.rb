class ValidationFailureException < ApplicationException
  def initialize(form)
    @code = :validation_failure
    @message = 'Validation of params failed'
    @description = 'The server could not validate the parameters present with the request. Please check the validation_errors key (hash) for more details.'
    @form = form
  end

  def response
    r = super
    r[:validation_errors] = @form.errors
    r
  end
end
