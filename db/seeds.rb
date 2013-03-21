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
  { username: 'admin3', email: 'admin3@a.com', password: 'admin123', is_admin: 0 },
  { username: 'admin4', email: 'admin4@a.com', password: 'admin123', is_admin: 0 },
  { username: 'admin5', email: 'admin5@a.com', password: 'admin123', is_admin: 0 }
])
Event.create([
  {title: 'Event 1 lorem ipsum', slug: 'event-1', content: 'Lorem ipsum dolor amet'},
  {title: 'Event 2 lorem ipsum', slug: 'event-2', content: 'Lorem ipsum dolor amet'},
  {title: 'Event 3 lorem ipsum', slug: 'event-3', content: 'Lorem ipsum dolor amet'},
  {title: 'Event 4 lorem ipsum', slug: 'event-4', content: 'Lorem ipsum dolor amet'},
  {title: 'Event 5 lorem ipsum', slug: 'event-5', content: 'Lorem ipsum dolor amet'}
])

Post.create([
  {title: 'Post 1 lorem ipsum', slug: 'post-1', content: 'Lorem ipsum dolor amet', user_id: 2},
  {title: 'Post 2 lorem ipsum', slug: 'post-2', content: 'Lorem ipsum dolor amet', user_id: 3},
  {title: 'Post 3 lorem ipsum', slug: 'post-3', content: 'Lorem ipsum dolor amet', user_id: 1},
  {title: 'Post 4 lorem ipsum', slug: 'post-4', content: 'Lorem ipsum dolor amet', user_id: 2},
  {title: 'Post 5 lorem ipsum', slug: 'post-5', content: 'Lorem ipsum dolor amet', user_id: 3},
  {title: 'Post 6 lorem ipsum', slug: 'post-6', content: 'Lorem ipsum dolor amet', user_id: 3},
  {title: 'Post 7 lorem ipsum', slug: 'post-7', content: 'Lorem ipsum dolor amet', user_id: 4},
  {title: 'Post 8 lorem ipsum', slug: 'post-8', content: 'Lorem ipsum dolor amet', user_id: 5},
  {title: 'Post 9 lorem ipsum', slug: 'post-9', content: 'Lorem ipsum dolor amet', user_id: 1},
  {title: 'Post 10 lorem ipsum', slug: 'post-10', content: 'Lorem ipsum dolor amet', user_id: 2}
])