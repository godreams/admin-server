module Translatable
  extend ActiveSupport::Concern

  def t(*args)
    I18n.t(*args)
  end
end
