class Subject < ApplicationRecord

  # Subjects have Pages that will be removed on destroy
  has_many :pages, dependent: :destroy

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order(:position) }
  scope :search_name, lambda { |lookup| where("UPPER(name) like ?", "%#{lookup.upcase}%")}
  # scope :search_name, -> (lookup) { |lookup| where("UPPER(name) like ?", "%#{lookup.upcase}%")}

  validates :name, presence: true, length: { maximum: 50}
  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :visible, inclusion: [true, false]

  after_save :log_save, if: Proc.new { |s| s.pages.visible.any? }

  before_validation :titleize_name

private

  def log_save 
    logger.info "Saved subject #{id} #{name}; subject has visible pages."
  end 

  def titleize_name
    self.name = name.titleize
  end 
end
