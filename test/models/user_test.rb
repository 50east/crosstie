require "minitest_helper"

describe User do
  before(:each) do
    @attributes = {
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar",
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attributes)
  end

  it "should require an email address" do
    no_email_user = User.new(@attributes.merge(email: ""))
    no_email_user.wont_be :valid?
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attributes.merge(email: address))
      valid_email_user.must_be :valid?
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attributes.merge(email: address))
      invalid_email_user.wont_be :valid?
    end
  end

  it "should reject duplicate email addresses" do
    user = User.create!(@attributes)
    user2 = User.new(@attributes)

    user2.wont_be :valid?
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attributes[:email].upcase
    User.create!(@attributes.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@attributes)

    user_with_duplicate_email.wont_be :valid?
  end

  describe "Stripe" do
  end

  describe "Passwords" do

    before(:each) do
      @user = User.new(@attributes)
    end

    it "should have a password attribute" do
      @user.must_respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.must_respond_to(:password_confirmation)
    end

    it "should require a password" do
      @attributes.merge!(password: nil, password_confirmation: nil)

      User.new(@attributes).wont_be :valid?
    end

    it "should require a matching password confirmation" do
      User.new(@attributes.merge(password_confirmation: "invalid")).wont_be :valid?
    end

    it "should reject short passwords" do
      short = "a" * 5
      @attributes.merge!(password: short, password_confirmation: short)

      User.new(@attributes).wont_be :valid?
    end

    it "should encrypt the password on save" do
      @user.save

      @user.must_respond_to(:password_digest)
      @user.password_digest.wont_be_empty
    end

  end
end
