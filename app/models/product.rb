class Product < ApplicationRecord
    belongs_to :product, optional: true
end
