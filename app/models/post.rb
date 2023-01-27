class Post < ApplicationRecord
  has_one_attached :image
  has_rich_text :body

  def image_as_thumbnail(limit)
    image.variant(resize_to_limit: [limit, limit]).processed
  end
end
