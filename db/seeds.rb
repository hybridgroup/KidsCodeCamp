# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([
  { username: 'admin', email: 'admin@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: 1 },
  { username: 'admin2', email: 'admin2@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: 1 },
  { username: 'admin3', email: 'admin3@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: 0 },
  { username: 'admin4', email: 'admin4@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: 0 },
  { username: 'admin5', email: 'admin5@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: 0 }
])
Event.create([
  {title: 'Event 1 lorem ipsum', slug: 'event-1', content: 'Lorem ipsum Sit minim cillum officia elit occaecat irure sint esse qui dolore dolore deserunt dolor.'},
  {title: 'Event 2 lorem ipsum', slug: 'event-2', content: 'Lorem ipsum Sed dolor sint labore deserunt in anim est veniam amet qui id anim aliqua commodo tempor et consequat elit quis.'},
  {title: 'Event 3 lorem ipsum', slug: 'event-3', content: 'Lorem ipsum Sunt pariatur in amet velit fugiat sunt deserunt qui officia proident sed sit cupidatat adipisicing.'},
  {title: 'Event 4 lorem ipsum', slug: 'event-4', content: 'Lorem ipsum Voluptate voluptate elit est non laborum non ea deserunt in sed laborum in id nisi aliqua quis quis velit.'},
  {title: 'Event 5 lorem ipsum', slug: 'event-5', content: 'Lorem ipsum In non laboris mollit aliquip adipisicing aliquip ea non dolore.'}
])

Post.create([
  {title: 'Post 1 lorem ipsum', slug: 'post-1', content: 'Lorem ipsum Tempor cupidatat non ex minim nulla quis Excepteur sunt sunt officia sit adipisicing in dolor tempor.', user_id: 2, category: 'General'},
  {title: 'Post 2 lorem ipsum', slug: 'post-2', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 3, category: 'Discussion'},
  {title: 'Post 3 lorem ipsum', slug: 'post-3', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 1, category: 'Teachers'},
  {title: 'Post 4 lorem ipsum', slug: 'post-4', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 2, category: 'General'},
  {title: 'Post 5 lorem ipsum', slug: 'post-5', content: 'Lorem ipsum Id consectetur velit deserunt commodo minim in adipisicing laboris dolor elit incididunt nisi ullamco labore culpa.', user_id: 3, category: 'Teachers'},
  {title: 'Post 6 lorem ipsum', slug: 'post-6', content: 'Lorem ipsum Cillum velit esse do Excepteur sit quis proident velit nulla cillum dolor qui aliquip Ut cupidatat consectetur Ut commodo.', user_id: 3, category: 'Teachers'},
  {title: 'Post 7 lorem ipsum', slug: 'post-7', content: 'Lorem ipsum Reprehenderit adipisicing mollit cillum laborum officia culpa ea labore magna.', user_id: 2, category: 'Discussion'}
])