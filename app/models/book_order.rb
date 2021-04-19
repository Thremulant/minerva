class BookOrder < ApplicationRecord
  belongs_to :book, dependent: :destroy
  belongs_to :order, dependent: :destroy
end
