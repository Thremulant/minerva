class Order < ApplicationRecord
  belongs_to :user
  belongs_to :state
  has_many :book_orders
  accepts_nested_attributes_for :book_orders, allow_destroy: true

end
