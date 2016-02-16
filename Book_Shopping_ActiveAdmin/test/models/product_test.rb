require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #are the products empty?
test "products empty?" do
  product = Product.new
  assert product.invalid?
  assert product.errors[:title].any?
  assert product.errors[:description].any?
  assert product.errors[:price].any?
  assert product.errors[:image_url].any?
end

#the value of price is positive?

test "product price positive?" do
    product = Product.new(title: "My Book Title",description: "yyy",image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
    product.errors[:price].join('; ')
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
    product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?, "Error"
end


def new_product(image_url)
  Product.new(title:"My Book Title",description: "yyy",price: 1,image_url:image_url)
end

# #Image url valid?
# test "image url valid" do
#   first = %w{ hello.gif world.jpg rocks.png YO.JPG}
#   second = %w{ hello_world.doc we_rock.gif/more yo_bro.gif.more }
#
#   first.each do |name_of_image|
#       assert new_product(name_of_image).invalid?, "#{name_of_image} should be valid"
#   end
#
#   second.each do |name_of_image|
#       assert new_product(name_of_image).invalid?, "#{name_of_image} shouldn't be valid"
#   end
# end


test "image url" do
ok = %w{ hello.jpg fred.jpg fred.png FRED.JPG FRED.Jpg}
bad = %w{ fred.gif.kl fred.gif/more fred.gif.more }
ok.each do |name|
assert new_product(name).valid?, "#{name} should be valid"
end
bad.each do |name|
assert new_product(name).invalid?, "#{name} shouldn't be valid"
end
end

#Title should be unique
test "product is not valid without a unique title" do
product = Product.new(title:products(:ruby).title,description: "yyy",price:1,image_url:"fred.gif")
assert product.invalid?
assert_equal ["has already been taken"], product.errors[:title]
end
end
