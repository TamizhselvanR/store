class Product < ApplicationRecord
    attr_accessor :name, :price
    validates :name, uniqueness: { message: "is already taken" }, presence: true
    validates :price, presence: true

    validate :price_must_be_positive, on: :create

    private

    def price_must_be_positive
        errors.add(:price, "must be positive") if price < 0
    end
end
