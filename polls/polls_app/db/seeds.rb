# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
Response.destroy_all
AnswerChoice.destroy_all
# ApplicationRecord.connection.reset_pk_sequence!('actors')
# ApplicationRecord.connection.reset_pk_sequence!('movies')
# ApplicationRecord.connection.reset_pk_sequence!('castings')

martin = User.create!(username: 'Martin')
sergey = User.create!(username: 'Sergey')
mashu = User.create!(username: 'Mashu')

foods = martin.authored_polls.create!(title: 'Favorite foods')
sports = sergey.authored_polls.create!(title: 'Favorite sports')

foodquestion = foods.questions.create!(text: 'Which of these do you like?')
sportquestion = sports.questions.create!(text: 'Which of these do you prefer?')

foodanswer1 = foodquestion.answer_choices.create!(text: 'Pizza')
foodanswer2 = foodquestion.answer_choices.create!(text: 'Pasta')
foodanswer3 = foodquestion.answer_choices.create!(text: 'Borshct')

sportanswer1 = sportquestion.answer_choices.create!(text: 'Football')
sportanswer2 = sportquestion.answer_choices.create!(text: 'Hockey')
sportanswer3 = sportquestion.answer_choices.create!(text: 'Baseball')

sportresponse1 = mashu.responses.create!(answer_choice_id: sportanswer1.id)
sportresponse2 = martin.responses.create!(answer_choice_id: sportanswer3.id)

foodresponse1 = mashu.responses.create!(answer_choice_id: foodanswer1.id)
foodresponse3 = sergey.responses.create!(answer_choice_id: foodanswer3.id)