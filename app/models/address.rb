class Address < ActiveRecord::Base
  belongs_to :customer
  
  validates_presence_of :street, :zip, :city, :country
  
  def to_s
    if id.to_s.empty?
      'Nová adresa'
    else
      "#{street}, #{zip} #{city}, #{country}"
    end
  end
end
