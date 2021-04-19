class Book < ApplicationRecord
  belongs_to :genre
  belongs_to :author
  has_many :book_orders
  accepts_nested_attributes_for :book_orders, allow_destroy: true
end
