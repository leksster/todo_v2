# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.destroy_all


3.times { |n| Project.create(name: "Lorem ipsum dolor_#{n}") }

5.times { |n| Task.create(text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet, corporis._#{n}", project: Project.first) }
3.times { |n| Task.create(text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet, corporis._#{n}", project: Project.last) }
