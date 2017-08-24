class User < ApplicationRecord
  belongs_to :role
  has_many :services
  mount_uploader :avatar, AvatarUploader


  TEMP_EMAIL_PREFIX = 'change@me'
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-]+\.[a-z]+\z/i


  validates_format_of :name, :with => /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/i,
                      :message => "must contain only letters, numbers, and underscores are not acceptable"

  validates_format_of :email, :with => VALID_EMAIL_REGEX,
                      :message => "Type a valid email address"

  validates_confirmation_of :password



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :user
  # end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            name: auth.extra.raw_info.name,
            email: auth.extra.info.email,
            avatar:auth.extra.info.image,
            #username: auth.info.nickname || auth.uid,
            # email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
  def email_verified?
    self.email && self.email !~ VALID_EMAIL_REGEX
  end

end
