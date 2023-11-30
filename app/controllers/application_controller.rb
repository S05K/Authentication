class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

include JsonWebToken

before_action :authenticate_request 

private
def authenticate_request
     byebug
    header = request.headers["token"]
    header = header.split(" ").last if header
    decode = jwt_decode(header)
    @current_user = User.find(decode[:user_id])
end

end
