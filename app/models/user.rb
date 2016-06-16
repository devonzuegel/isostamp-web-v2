class User < ActiveRecord::Base
  has_many :documents, dependent: :destroy
  has_many :sessions, class_name: 'Session'

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.fetch('provider')
      user.uid      = auth.fetch('uid')

      if auth['info']
        user.name  = auth['info'].fetch('name')  || ''
        user.email = auth['info'].fetch('email') || ''
      end

      if user.name =~ /Christina/ || user.name =~ /Byrd/ || user.name =~ /Devon/
        user.admin    = true
      end
    end
  end

end
