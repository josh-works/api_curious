class SessionsController < ApplicationController

  def create
    binding.pry
    # render text: request.env["omniauth.auth"].inspect
    # if user = User.from_omniauth(request.env["omniauth.auth"])
    #  session[:user_id] = user.id
    # end
  end

end

# rails g migration AddOAuthFieldsToUser screen_name:string uid:string oauth_token:string oauth_token_secret:string
# rake db:migrate

# def self.from_omniauth(auth_info)
#   where(uid: auth_info[:uid]).first_or_create do |new_user|
#     new_user.uid                = auth_info.uid
#     new_user.name               = auth_info.extra.raw_info.name
#     new_user.screen_name        = auth_info.extra.raw_info.screen_name
#     new_user.oauth_token        = auth_info.credentials.token
#     new_user.oauth_token_secret = auth_info.credentials.secret
#   end
# end


# # in app/controllers/application_controller.rb
# helper_method :current_user
#
# def current_user
#   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
# end

# <%# in app/views/layouts/_navbar.html.erb %>
#
# <% if current_user %>
#   Hello, <%= current_user.name %>
# <% else %>
#   <%= link_to "Sign in with Twitter", twitter_login_path %>
# <% end %>
