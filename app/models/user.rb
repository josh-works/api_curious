class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(user_id: auth_info.uid).first_or_create do |new_user|
      new_user.user_id = auth_info.uid
      new_user.name = auth_info.info.name
      new_user.user_name = auth_info.info.nickname
      new_user.image = auth_info.extra.raw_info.avatar_url
      new_user.oauth_token = auth_info.credentials.token
    end
  end

end
