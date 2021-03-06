class Session
  include ActiveModel::Model

  attr_accessor :email, :password, :user


  validates :email, presence: true
  validates_format_of :email, with: /.+@.+/, allow_blank: false

  validate :check_email
  validates :password, presence: true
  validates :password, length: {minimum: 6}, if: :password
  validate :email_password_match, if: Proc.new { |s| s.email.present? and s.password.present? }

  def email_password_match
    @user ||= User.find_by_email email
    if user and not user.authenticate password
      errors.add :password, :mismatch
    end
  end

  def check_email
    @user ||= User.find_by_email email
    if user.nil?
      errors.add :email, :not_found

    end
  end
end