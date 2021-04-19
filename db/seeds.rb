# CLEAN ALL
# rake db:drop db:create db:migrate VERSION=0
require 'faker'
require 'json'
require 'pp'

def get_data_url(url)
  # puts url
  uri = URI(url)
  res = Net::HTTP.get(uri)
  json_res = JSON.parse(res)
end

def get_cover(book_name)
  book_cover = ''
  book_data = get_data_url('http://openlibrary.org/search.json?title=' + I18n.transliterate(book_name.downcase.gsub(/[^a-zA-Z ]/, '').gsub!(
                                                                                              ' ', '+'
                                                                                            )))
  book_cover = if book_data['docs'].size != 0
                 # && book_data['docs'][0]['cover_i'] != nil? && book_data['docs'][0]['cover_i'] != '' )
                 # puts book_data['docs'][0]['cover_i']
                 if book_data['docs'][0].key?('cover_i')
                   # puts book_data['docs'][0]['cover_i']
                   'http://covers.openlibrary.org/b/id/' + book_data['docs'][0]['cover_i'].to_s + '-L.jpg'
                 else
                   ''
                 end
               else
                 ''
               end
end

def delete_all_content
  State.destroy_all
  Province.destroy_all
  User.destroy_all
  Book.destroy_all
  Genre.destroy_all
  Author.destroy_all
  Order.destroy_all
  BookOrder.destroy_all
end
# SINGLE CREATION

# horror = Genre.create(name: 'Horror')
# poe = Author.create(name: 'Poe')

# stories = Book.create(name: 'Narraciones', author: poe, genre: horror, price:10)
# poems = Book.create(name: 'Poems', author: poe, genre: horror)

# manitoba = Province.create(name: 'MB')
# customer = Customer.create(name:'pending', province: manitoba)
# pending = State.create(name:'pending')

# new_order = Order.create(order_state: pending, customer: customer, pst: 0, gst:0, hst:0)

# new_books_order = BooksOrder.create(book: stories, order:new_order, price:stories.price, quantity: 1 )

def generate_content
  # Create all order states
  all_order_states = ['PENDING', 'AWAITING PAYMENT', 'AWAITING FULFILLMENT', 'COMPLETED']

  all_order_states.each do |state|
    State.find_or_create_by(name: state)
  end

  # Create provinces
  all_provinces = []
  all_provinces_short_name = %w[AB BC MB NB NL NS NT NU ON PE QC SK YT]

  all_provinces_short_name.each do |province, _index|
    new_province = Province.create(name: province)
    all_provinces << new_province
  end

  # Create customers
  all_customers = []
  4.times do |_index|
    customer_name = Faker::Name.unique.name
    password = Faker::Number.number(digits: 6)
    new_customer = User.create(
      name: customer_name,
      password: password,
      password_confirmation: password,
      email: Faker::Internet.email(name: customer_name, separators: '.'),
      address: Faker::Address.unique.street_address,
      postal_code: Faker::Address.unique.postcode,
      province: all_provinces.sample
    )
  end

  # Generate 10 genres
  base_genres = ['Horror', 'Fantasy', 'Crime', 'Comic/Graphic Novel']
  all_genres = []
  base_genres.each do |genre|
    new_genre = Genre.find_or_create_by(name: genre)
    all_genres << new_genre
  end

  all_authors = []
  10.times do |_index|
    new_author = Author.find_or_create_by(name: Faker::Book.unique.author)
    all_authors << new_author
  end

  all_books = []
  100.times do |_index|
    book_name = Faker::Book.unique.title
    new_book = Book.find_or_create_by(
      title: book_name,
      author: all_authors.sample,
      genre: all_genres.sample,
      price: Faker::Number.decimal(l_digits: 2),
      description: Faker::GreekPhilosophers.quote,
      pages: Faker::Number.number(digits: 3),
      image: get_cover(book_name)
    )
    all_books << new_book
  end
end

def generate_initial_user
  if Rails.env.development?
    AdminUser.create!(email: 'admin@example.com', password: 'password',
                      password_confirmation: 'password')
  end
end

delete_all_content
generate_content
generate_initial_user
