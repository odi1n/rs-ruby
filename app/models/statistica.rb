class Statistica < ApplicationRecord
    belongs_to :stock, optional: true
    belongs_to :product, optional: true
end
