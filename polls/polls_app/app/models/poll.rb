class Poll < ApplicationRecord
    validates :title, presence: true
    validates :author_id, presence: true

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id,
        primary_key: :id

    has_many :questions,
        class_name: :Question,
        primary_key: :id,
        foreign_key: :poll_id
end