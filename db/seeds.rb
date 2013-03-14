# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([
  { username: 'admin', email: 'admin@a.com', password: 'admin123', is_admin: 1 },
  { username: 'admin2', email: 'admin2@a.com', password: 'admin123', is_admin: 1 },
  { username: 'admin3', email: 'admin3@a.com', password: 'admin123', is_admin: 0 }
])
Post.create([
  {title: 'Post 1 lorem ipsum', slug: 'post-1', content: 'Lorem ipsum dolor amet', user_id: 2},
  {title: 'Post 2 lorem ipsum', slug: 'post-2', content: 'Lorem ipsum dolor amet', user_id: 1},
  {title: 'Post 3 lorem ipsum', slug: 'post-3', content: 'Lorem ipsum dolor amet', user_id: 1},
  {title: 'Post 4 lorem ipsum', slug: 'post-4', content: 'Lorem ipsum dolor amet', user_id: 2},
  {title: 'Post 5 lorem ipsum', slug: 'post-5', content: 'Lorem ipsum dolor amet', user_id: 3}
])