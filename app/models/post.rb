class Post < ApplicationRecord
  has_one_attached :image
  has_rich_text :body

  validates :title, :body, presence: true, if: :published?
  validates :image, attached: true, if: :published?

  scope :with_attached_image, -> { includes(image_attachment: :blob) }

  def image_as_thumbnail
    image.variant(resize_to_limit: [60, 60]).processed
  end

  def published?
    self.published
  end

  def publish
    self.published = true
    false unless save
  end
end
