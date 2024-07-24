# frozen_string_literal: true

# ApplicationRecord serves as the base class for all models in the application.
# By inheriting from `ActiveRecord::Base`, it provides common functionality
# and configuration for all models. This class is intended to be an abstract
# base class, meaning it is not meant to be instantiated directly.
#
# The `primary_abstract_class` declaration specifies that `ApplicationRecord`
# is an abstract class, ensuring that it cannot be instantiated on its own
# and that its subclasses are the ones that will interact with the database.
#
# Models in the application should inherit from `ApplicationRecord` to gain
# access to common behavior and configuration.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
