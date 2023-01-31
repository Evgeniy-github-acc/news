class Post < ApplicationRecord
  has_one_attached :image
  has_rich_text :body

  validates :publish_date, presence: true
  validates :title, :body,  presence: true, if: :published?
  validates :image, attached: true, if: :published?

  validates :image,
    content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'needs to be an PNG or JPEG image' }
    #dimension: { width: {min: 60, max: 2400}, height: {min: 60, max: 2400} }

  default_scope { order("publish_date DESC") }

  scope :index_page, -> { where("published = ? AND publish_date <= ?", true, Date.today) }
  scope :main_page, -> { index_page.where( on_main_page: true ) }

  def image_as_thumbnail
    return image unless image.variable?
    image.variant(resize_to_limit: [60, 60]).processed
  end

  def published?
    self.published
  end

  def publish
    self.published = true
    false unless save
  end

  def self.for_main_page
    main_page.size >= 3 ? main_page.first(3) : index_page.first(3)
  end
end
