# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

i_chris = Instructor.create(name: "Chris McCord", email: "chrismccord@phoenix.com", password: "password")
i_sandi = Instructor.create(name: "Sandi Metz", email: "sandimetz@object.com", password: "password")
i_1 = Instructor.create(name: "Obi-Wan Kenobi", email: "obiwan@tatooine.com", password: "password")
i_2 = Instructor.create(name: "Qui Gon Jinn", email: "quigon@jedicouncil.com", password: "password")
i_3 = Instructor.create(name: "Yoda", email: "yoda@dagoba.com", password: "password")

c_elixir = Course.create(title: "Elixir", description: "Learn Elixir with Phoenix", password: "password")
c_1 = Course.create(title: "The Force and You", description: "An introductory look at the Force and its users", password: "password")
c_2 = Course.create(title: "Lightsaber Dueling 101", description: "Basics of positioning, defense, and wild flailing", password: "password")
c_3 = Course.create(title: "Losing a Hand, Saving a Land", description: "A seminar discussing the most popular pastime of Jedi everywhere--getting a hand cut off.", password: "password")

s_john = Student.create(name: "Louis Clarke", email: "pocahontas@explorers.com", password: "password")
s_belle = Student.create(name: "Belle Storison", email: "codeasoldastime@storison.com", password: "password")
s_1 = Student.create(name: "Luke Skywalker", email: "luke@tatooine.com", password: "password")
s_2 = Student.create(name: "Rey", email: "rey@jakku.com", password: "password")
s_3 = Student.create(name: "Han Solo", email: "solo@corellia.com", password: "password")
s_4 = Student.create(name: "R2-D2", email: "r2@d2.com", password: "password")

c_elixir.instructors << i_chris
c_elixir.students << s_john << s_belle
c_1.instructors << i_1
c_1.students << s_2 << s_3
c_2.instructors << i_2 << i_3
c_2.students << s_1 << s_2
c_3.instructors << i_3
c_3.students << s_1 << s_2 << s_3 << s_4

####unlocked lecture with two unlocked reviews and two students
l_match = Lecture.create(title: "Match statements in Elixir", description: "one of the great features of Elixir", instructor: i_chris, course: c_elixir, locked: false, created_at: (Time.now - 5.hours), finish_time: (Time.now - 1.hours))

r_john = Review.create(student: s_john, lecture: l_match, content: "Great lecture! would appreciate a few more examples of using matches with functions arguments to tell which function should be called", locked: false)

r_belle = Review.create(student: s_belle, lecture: l_match, content: "I got confused by the Elixir case statment. Is it different from Ruby's? Also, I'd love to have a lecture on Phoenix sometime!", locked: false)

#### locked lecture with one review and two students
l_phoenix = Lecture.create(title: "The Phoenix Framework", description: "take flight with Phoenix!", instructor: i_chris, course: c_elixir, locked: true, created_at: (Time.now - 50.hours), finish_time: (Time.now - 40.hours))

r_john2 = Review.create(student: s_john, lecture: l_phoenix, content: "I feel like I need to see the setup a few more times to get the hang of it. Can you do a similarly thorough explanation during tomorrow's lecture as well?", locked: true)

#### unlocked lecture, but about to lock, with two reviews and two students
l_add_ons = Lecture.create(title: "Add-ons in Elixir", description: "third party code will allow us to accomplish significantly more", instructor: i_chris, course: c_elixir, locked: false, created_at: (Time.now - 25.hours), finish_time: (Time.now - 23.9.hours))

r_john3 = Review.create(student: s_john, lecture: l_add_ons, content: "Would love to get a list of addons that you recommend we take a look at", locked: false)

r_belle2 = Review.create(student: s_belle, lecture: l_add_ons, content: "This lecture was a bit too long. Can we have breaks a little more frequently/dependably? Other than that, really enjoyed!", locked: false)

#### unlocked lecture with one review and two students
l_regex = Lecture.create(title: "Regex in Elixir", description: "This should be a familiar topic, but worth review", instructor: i_chris, course: c_elixir, locked: false, created_at: (Time.now - 16.hours), finish_time: (Time.now + 1.hours))

r_belle3 = Review.create(student: s_belle, lecture: l_regex, content: "since we did this for Ruby already, maybe we could get a few labs instead? I feel like more practice would be great", locked: false)

######### course with two instructors and one student
c_intro = Course.create(title: "Intro to Coding", description: "Learn some basic principles of coding", password: "password")
c_intro.instructors << i_chris << i_sandi
c_intro.students << s_john

####unlocked lecture with one unlocked review and one student
l_oop = Lecture.create(title: "Object Oriented Principles", description: "An overview of the basics", instructor: i_sandi, course: c_intro, locked: false, created_at: (Time.now - 4.hours), finish_time: (Time.now - 3.hours))

r_john4 = Review.create(student: s_john, lecture: l_oop, content: "fantastic lecture! Are there any acronyms you suggest we can memorize to help keep these principles in mind?", locked: false)

####unlocked lecture with one unlocked review and one student and a different instructor
l_framework = Lecture.create(title: "Designing a Framework", description: "How did Pheonix come to be?", instructor: i_chris, course: c_intro, locked: false, created_at: (Time.now - 13.hours), finish_time: (Time.now - 10.hours))
