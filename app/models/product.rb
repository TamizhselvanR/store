class Product < ApplicationRecord
    validates :name, uniqueness: { message: "is already taken" }, presence: true
    validates :price, presence: true

    validate :price_must_be_positive, on: :create

    has_many :accessories
    accepts_nested_attributes_for :accessories
    private

    def price_must_be_positive
        errors.add(:price, "must be positive") if price < 0
    end
end
