# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(name: 'yurii', email: 'yuriy.kurilenko7@gmail.com')
todo1 = Todo.create(title: 'Finish async arch course', user: user)
todo2 = Todo.create(title: 'Create a repository', user: user)
