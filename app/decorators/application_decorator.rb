class ApplicationDecorator < Draper::Decorator
  delegate :to_model, :errors

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
