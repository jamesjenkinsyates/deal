class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :time_windows
  has_many :impressions        
  has_many :clicks    
  has_many :conversions, foreign_key: "customer_id"

  validates :company_name, uniqueness: true, allow_nil: true

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
 
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.uid+"@twitter.com",
          password:Devise.friendly_token[0,20],
        )
      end
    end
  end

  has_attached_file :avatar, :styles => {
    thumb: "100x100>", tiny: "40x40>"
  }, :default_url => "/assets/avatar.png"

  def follow(business)
    unless business.customers.include? self
      business.customers << self
    else
      business.customers.delete(self)
    end 
  end

  def eligible_offers
    offers_from_followed_businesses = businesses.map(&:offers).flatten

    eligible = offers_from_followed_businesses.select do |offer|
      offer.eligible_for?(self)
    end
  end

  def time_taken_to_buy_last_offer
    Time.now - clicks.last.created_at
  end

end
