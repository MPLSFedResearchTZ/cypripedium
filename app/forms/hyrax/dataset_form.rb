# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetForm < Hyrax::Forms::WorkForm
    self.model_class = ::Dataset
    self.terms += [:resource_type]
    self.terms += ::Attributes.to_a
    self.required_fields = [:title]

    def self.model_attributes(form_params)
      result = super
      result[:related_url].map! { |related_url| RDF::Markdown::Literal.new(related_url) }
      result
    end
    def self.model_attributes(form_params)
      result = super
      result[:description].map! { |description| RDF::Markdown::Literal.new(description) }
      result
    end
  end
end
