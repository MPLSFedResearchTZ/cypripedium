module Hyrax
  # Provide select options for the creator field
  class NameAuthority < QaSelectService
    def initialize
      super('names')
    end
  end
end
