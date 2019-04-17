
class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slugy
     slug = self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    all.map 
    {
      |x|
      if x.slug == slug
            return x
       end
    }
  end

end