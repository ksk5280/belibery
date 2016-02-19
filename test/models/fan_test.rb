require 'test_helper'

class FanTest < ActiveSupport::TestCase
  def valid_attributes
    {
      name:               "Jorge",
      email:              "yosoybelieber@example.com",
    }
  end

  test "it creates a fan" do
    result = Fan.new(valid_attributes)

    assert result.valid?
    assert_equal "Jorge", result.name
    assert_equal "yosoybelieber@example.com", result.email
  end

  test "it cannot create a fan without an name" do
    result = Fan.new(email: "yosoybelieber@example.com")

    assert result.invalid?
  end

  test "it cannot create a fan with the same email" do
    2.times { Fan.create(valid_attributes) }

    result = Fan.where(email: "yosoybelieber@example.com")
    assert_equal 1, result.count
  end

  test "it only accepts letters as a name" do
    fan = Fan.new(
      name:   "Jorge1",
      email:  "yosoybelieber@example.com"
      )

    refute fan.valid?
  end

  test "it only accepts an email between 5 to 50 characters" do
    fan1 = Fan.new(
      name:               "Jorge",
      email:              "Jorj"
      )

    assert fan1.invalid?

    fan2 = Fan.new(
      name:               "Jorge",
      email:              "Jorjjkldfjksldjfsiekljfkls;djfskdfjskldfjsdkfjkdlfjkjfdksfsdj"
      )

    assert fan2.invalid?
  end

  test "it cannot create a fan named Richard" do
    fan = Fan.new(
      name:               "Richard",
      email:              "richard@example.com"
      )

    refute fan.valid?
    assert_includes fan.errors.full_messages, "Name cannot be Richard"

  end
end
