class Api::V1::ApiController < ActionController::Base
  before_filter :parse_request
  before_filter :authenticate_user_from_token!

  protected

  def authenticate_user_from_token!
    token = request.headers['X-Api-Token']
    if !token
      render nothing: true, status: :unauthorized
    else
      @customer = nil
      Customer.find_each do |u|
        if Devise.secure_compare(u.api_token, token)
          @customer = u
        end
      end
      if !@customer
        render nothing: true, status: :unauthorized
      end
    end
  end

  def parse_request
    body = request.body.read
    @json = (body.size >= 2) ? JSON.parse(body) : []
  end
end