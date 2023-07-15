class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  after_save :update_post_counter

  validates :title, presence: true, length: {maximum: 250}
  validates :comments_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0} 
  validates :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0} 

  def update_post_counter
    author.update(post_counter: author.post_counter + 1)
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private :update_post_counter
end
