class User < ActiveRecord::Base
  has_many :documents
  has_many :sessions, class_name: 'Session'

  def self.create_with_omniauth(auth)
    ap auth
    create! do |user|
      user.provider = auth.fetch('provider')
      user.uid      = auth.fetch('uid')
      if auth['info']
        user.name  = auth['info'].fetch('name')  || ''
        user.email = auth['info'].fetch('email') || ''
      end
    end
  end

end
