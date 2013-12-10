class User < ActiveRecord::Base
  acts_as_authentic # using Authlogic. #dealwithit

  has_many :movies

  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.where(layervault_id: auth_hash.uid).first

    if user.nil?
      user = self.new(oauth_attributes(auth_hash))
      user.layervault_id = auth_hash.uid
    else
      user.update_attributes(oauth_attributes(auth_hash))
    end

    user.access_token = auth_hash.credentials.token

    user.save!
    user
  end

  private

  def self.oauth_attributes(auth_hash)
    {
      first_name: auth_hash.info.first_name,
      last_name: auth_hash.info.last_name,
      email: auth_hash.info.email,
    }
  end
end
