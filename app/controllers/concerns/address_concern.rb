module AddressConcern extend ActiveSupport::Concern

protected

  def address_params
    params.permit(:addresses => [:id, :street, :city, :zip, :country, :address, :note, :level, :latitude, :longitude])
  end
  
  def empty_address?(address={})
    address[:street].to_s.empty? && address[:city].to_s.empty? && address[:zip].to_s.empty?# && address[:country].to_s.empty?    
  end
  
  def save_addresses(resource)
    address_params.each do |name, addresses|
      update_addresses = []
      addresses.each do |address|
        next if address['id'].empty? && empty_address?(address)
        update_addresses << address
      end
      resource.addresses_attributes = update_addresses
      resource.save
    end
  end
  
  def validate_addresses(allow_empty_with_empty_id=false)
    address_params.each do |name, addresses|
      addresses.each do |address|
        next if allow_empty_with_empty_id && address['id'].empty?
        return false if address[:street].to_s.empty? || address[:city].to_s.empty? || address[:zip].to_s.empty? || address[:country].to_s.empty?
      end
    end
    true
  end
  
  def address_present?
    present = false
    address_params.each do |name, addresses|
      addresses.each do |address|
        if !empty_address?(address)
          present = true
          break
        end
      end
    end
    present
  end
  
end