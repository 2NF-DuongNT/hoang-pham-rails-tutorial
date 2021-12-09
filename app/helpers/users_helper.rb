module UsersHelper
    # def gravatar_for(user, size: 80) #Using keyword arguments in the gravatar_for helper
    def gravatar_for(user, option = {size: 80} ) #Adding an options hash in the gravatar_for helper
        size = option[ :size ]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase) 
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"  #lay url anh
        # gravatar_url = "https://vinasupport.com/assets/img/vinasupport_logo.png"  #thay url anh khac
        image_tag(gravatar_url, alt: user.name, class: "float-left mb-1 ml-1")
    end
        
end
