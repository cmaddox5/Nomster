class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  after_create :send_comment_email

  RATINGS = {
    '1 Star'    => '1_star',
    '2 Stars'    => '2_star',
    '3 Stars'  => '3_star',
    '4 Stars'   => '4_star',
    '5 Stars'   => '5_star'
  }

  def humanized_rating
    RATINGS.invert[self.rating]
  end

  def send_comment_email
    NotificationMailer.comment_added(self).deliver
  end
end
