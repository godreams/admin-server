module Cities
  class CreateForm < Reform::Form
    property :name, validates: { presence: true }
  end
end
