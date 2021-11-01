class User < ApplicationRecord
  has_and_belongs_to_many :departments
  has_many :page_assignments
  has_many :pages, :through => :page_assignments

  scope :sorted, lambda { order(:last_name, :first_name) }

  validate :edits_are_allowed_today
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 50 }

  # Creates a virtual attribute @password_confirmation which must be passed in and equal
  # If the Confirmation doesn't exist it's ignored as you may want to alter the email 
  # on the administration side or something like that?
  validates :email, presence: true, length: { maximum: 100 }, confirmation: true

  # Creates a virtual attribute @terms that expects a true value
  validates_acceptance_of :terms 

  def full_name 
    [first_name, last_name].join(' ')
  end 

  def initial_name
    [first_name.chars.first, last_name].join('. ')
  end

private 

  def edits_are_allowed_today
    if Time.now.wday == 4 
      errors.add :base, "Edits cannot be made on Thursdays"
    end 
  end 
end
