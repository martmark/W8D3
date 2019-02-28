class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id

	has_many :responses,
		through: :answer_choices,
    source: :responses
    
  def results
    # choices = self.answer_choices
    choices = self.answer_choices
      .select('answer_choices.text', 'COUNT(responses.id) as something' )
      .left_outer_joins(:responses)
      .where('answer_choices.question_id = ?', self.id)
      .group('answer_choices.id')

    counts = Hash.new(0)
    choices.each do |answ_choice|
      counts[answ_choice.text] += answ_choice.something
    end 

    counts
	end
	

#  choices = self.answer_choices
#   .select('answer_choices.*, COUNT(responses.id) ')
#   .left_outer_joins(:responses)
#   .where('answer_choices.question_id = ?', self.id)
#   .group('answer_choices.id')


end