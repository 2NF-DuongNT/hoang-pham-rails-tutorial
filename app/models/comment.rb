class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :micropost
    has_many :sub_comments, class_name: "Comment",
                        foreign_key: "parent_comment_id",
                        dependent: :destroy

    validates :user_id, presence: true
    validates :micropost_id, presence: true
    validates :content, presence: true, length: { maximum: Settings.content_maximum}

    

    # def show_sub_comment
    #     self.sub_comments
    # end
    scope :sub_comments, ->{where parent: id}

end
