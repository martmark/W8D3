class Response < ApplicationRecord
  validates :user_id, presence: true
	validates :answer_choice_id, presence: true
	validate :not_duplicate_response
  validate :not_creators_poll

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id

  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

	has_one :question,
		through: :answer_choice,
		source: :question

	# has_many :sibling_responses,
	# 	through: :question,
  #   source: :responses,
	# 	Response.where.not(id: self.id)
		
	def sibling_responses
		self.question.responses.where.not(id: self.id)
	end

	def respondent_already_answered?
		self.sibling_responses.any? { |response| response.user_id == self.user_id }
	end

	def not_duplicate_response
		if respondent_already_answered?
			errors[:respondent] << 'has already answered this question'
		end
	end

	def not_creators_poll
		if self.user_id == self.answer_choice.question.poll.author_id
			errors[:respondent] << 'cannot be author of poll'
		end
	end
end