class Product < ApplicationRecord
  before_save :strip_html_description, :set_lower_title
  belongs_to :category
  validates :title, :price, :description, presence: true
  validates_numericality_of :price, greater_than: 0
  validate :title_is_shorter_than_description

  def title_is_shorter_than_description
    return if title.blank? || description.blank?
    if description.length < title.length
      errors.add(:title, 'can\'t longer than description')
    end
  end

  def strip_html_description
    self.description =ActionView::Base.full_sanitizer.sanitize(self.description)
  end

  def set_lower_title
    self.title.downcase!
  end
end
