class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_validation :strip_white_spaces_in_phone
  
  validates_presence_of :name_firstname, :phone, :personal_data_agreement, :terms_agreement
  validates :phone, format: { with: /\A(\+\d\d\d)?\d{9}\z/ }
  
  before_create :create_api_token
  
  has_many :addresses
  has_many :orders, :class_name => 'RicEshop::Order'
  
  accepts_nested_attributes_for :addresses
  
  def name
    names = []
    names << name_firstname if name_firstname
    names << name_lastname if name_lastname
    names.join(' ')
  end
  
  protected
  
  def strip_white_spaces_in_phone
    unless phone.nil?
      self.phone.gsub!(/\s+/, '')
    end
  end
  
  def create_api_token
    token = nil
    while token.nil?
      token = Devise.friendly_token
      token = nil unless Customer.find_by_api_token(token).nil?
    end
    self.api_token = token
  end
end
