#USER MODEL
class User < ActiveRecord::Base
  
  #HELPER FUNCTIONS GO HERE

  def slug()
    username = self.username.downcase
    username_array = username.split(/\W/).delete_if do
      |word| word == "" 
    end
    slug_user = username_array.join("-")
    slug_user
  end

  def self.find_by_slug(slug)
    User.all.find do |u| 
     u.slug == slug 
    end
  end
  
end