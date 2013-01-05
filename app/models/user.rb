class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  include ActiveModel::ForbiddenAttributesProtection


  ## Fields
  field :email, :type => String, :null => true, :default => ""
  field :password_digest, :type => String, :null => true, :default => ""
  field :password_reset_token, :type => String
  field :password_reset_sent_at, :type => Time
  field :remember_created_at, :type => Time
  field :sign_in_count, :type => Integer, :default => 0
  field :last_sign_in_at, :type => Time
  field :last_sign_in_ip, :type => String

  ## Indexes
  index :email, :unique => true

  has_secure_password :validations => false

  ## Validations
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of :email, :allow_blank => true, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_confirmation_of :password, :if => lambda { u.password.present? }
  validates_presence_of     :password, :on => :create
  validates :password, :length => { :within => 6..40 }, :on => :create
  validates :password, :length => { :within => 6..40 }, :on => :update, :if => lambda { |u| u.password.present? }

  def track_signin!(request)
    self.sign_in_count += 1
    self.last_sign_in_at = Time.now
    self.last_sign_in_ip = request.ip

    self.save(:validate => false)
  end
end
