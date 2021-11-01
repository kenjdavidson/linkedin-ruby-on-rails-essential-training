class Page < ApplicationRecord
  belongs_to :subject
  has_many :page_assignments
  has_many :users, :through => :page_assignments

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order(:position) }
  scope :latest, lambda { order("created_at DESC").limit(5) }
  scope :subject_visible, lambda { |subject_id| where(subject_id: subject_id, visible: true)}

  validates :subject, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :permalink, uniqueness: true, format: { with: /\A\/[\w_-]+\Z/ } # \A is ^ and \Z is $ apparently in ruby
  validates :visible, inclusion: [true, false]
  validates :content, presence: true

  before_validation :titleize_name

private 

  def content_is_valid_markdown
    # ensure that content compiles correctly with our markdown parser
    # this doesn't work now, but once we add in a markdown processor we
    # can add it
    if @content_type == "md" 
      # attempt to compile markdown and add error
      errors.add :content, "Content is not valid markdown" unless true
    end 
  end 

  def titleize_name
    self.name = name.titleize
  end 
end
