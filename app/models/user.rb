class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]



         acts_as_user :roles => [:assistito, :assistente, :admin]

         def is_assistito?
            return (self.roles_mask & 1) == 1
          end
        
         def set_assistito
            self.roles_mask = (self.roles_mask | 1) 
            self.save
          end
        
        def unset_assistito
            self.roles_mask = 0 
            self.save
          end
          #####################
          def is_assistente
            return (self.roles_mask & 2) == 2
          end
        
         def set_assistente
            self.roles_mask = (self.roles_mask | 2) 
            self.save
          end
        
        def unset_assistente
            self.roles_mask = 0 
            self.save
          end
          #####################
          def is_admin?
            return (self.roles_mask & 4) == 4
          end
        
         def set_admin
            self.roles_mask = (self.roles_mask | 4) 
            self.save
          end
        
        def unset_admin
            self.roles_mask = 0 
            self.save
          end
        

def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name=auth.info.first_name
      user.surname=auth.info.last_name
      user.lat=""
      user.long=""
      user.citta=""
      user.indirizzo=""
      
    end
  end
  
  def self.from_omniauth2(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
  # Uncomment the section below if you want users to be created if they don't exist
     unless user
         user = User.create( email: data['email'],
            password: Devise.friendly_token[0,20],
            name: data['first_name'],
            surname: data['last_name'],
            citta: "",
            indirizzo: "",
            long: "",
            lat: ""
         )
     end
  user
end

  

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

 
end
