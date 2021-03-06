# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Editpage.create([
  { title:'About', content:'Lorem ipsum Quis mollit cupidatat veniam Duis dolor pariatur non eiusmod ut aliqua enim ex cupidatat mollit veniam dolor deserunt ea ea adipisicing minim minim laboris proident esse aute elit nostrud aute ex ut enim proident exercitation adipisicing sed eiusmod velit deserunt esse consequat nostrud consectetur anim veniam Excepteur sit esse non anim labore dolore sed commodo minim exercitation sit sed est voluptate Duis reprehenderit ullamco sit occaecat ex eu Ut dolore laboris reprehenderit anim exercitation aliquip et sunt aliquip nisi nisi consectetur incididunt esse consequat aliqua anim adipisicing adipisicing incididunt in aliqua cillum aute nostrud ad officia non dolor eu dolore sint minim consequat anim ullamco labore ut anim aliqua ut amet qui incididunt sint anim nulla minim consequat dolore proident Duis id qui dolore commodo elit cupidatat reprehenderit proident voluptate mollit laborum in in ut aute nisi ut consectetur sint proident nostrud irure occaecat Ut fugiat deserunt sint exercitation incididunt fugiat eu proident aute est incididunt cillum ex ullamco laboris laboris sint ut qui minim dolore.' },
  { title:'Tools', content:'Lorem ipsum Quis mollit cupidatat veniam Duis dolor pariatur non eiusmod ut aliqua enim ex cupidatat mollit veniam dolor deserunt ea ea adipisicing minim minim laboris proident esse aute elit nostrud aute ex ut enim proident exercitation adipisicing sed eiusmod velit deserunt esse consequat nostrud consectetur anim veniam Excepteur sit esse non anim labore dolore sed commodo minim exercitation sit sed est voluptate Duis reprehenderit ullamco sit occaecat ex eu Ut dolore laboris reprehenderit anim exercitation aliquip et sunt aliquip nisi nisi consectetur incididunt esse consequat aliqua anim adipisicing adipisicing incididunt in aliqua cillum aute nostrud ad officia non dolor eu dolore sint minim consequat anim ullamco labore ut anim aliqua ut amet qui incididunt sint anim nulla minim consequat dolore proident Duis id qui dolore commodo elit cupidatat reprehenderit proident voluptate mollit laborum in in ut aute nisi ut consectetur sint proident nostrud irure occaecat Ut fugiat deserunt sint exercitation incididunt fugiat eu proident aute est incididunt cillum ex ullamco laboris laboris sint ut qui minim dolore.' },
  { title:'Lessons', content:'Lorem ipsum Quis mollit cupidatat veniam Duis dolor pariatur non eiusmod ut aliqua enim ex cupidatat mollit veniam dolor deserunt ea ea adipisicing minim minim laboris proident esse aute elit nostrud aute ex ut enim proident exercitation adipisicing sed eiusmod velit deserunt esse consequat nostrud consectetur anim veniam Excepteur sit esse non anim labore dolore sed commodo minim exercitation sit sed est voluptate Duis reprehenderit ullamco sit occaecat ex eu Ut dolore laboris reprehenderit anim exercitation aliquip et sunt aliquip nisi nisi consectetur incididunt esse consequat aliqua anim adipisicing adipisicing incididunt in aliqua cillum aute nostrud ad officia non dolor eu dolore sint minim consequat anim ullamco labore ut anim aliqua ut amet qui incididunt sint anim nulla minim consequat dolore proident Duis id qui dolore commodo elit cupidatat reprehenderit proident voluptate mollit laborum in in ut aute nisi ut consectetur sint proident nostrud irure occaecat Ut fugiat deserunt sint exercitation incididunt fugiat eu proident aute est incididunt cillum ex ullamco laboris laboris sint ut qui minim dolore.' }
])

User.create([
  { username: 'admin', email: 'admin@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: true },
  { username: 'admin2', email: 'admin2@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: true },
  { username: 'admin3', email: 'admin3@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: false },
  { username: 'admin4', email: 'admin4@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: false },
  { username: 'admin5', email: 'admin5@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: false }
])

Event.create([
  {title: 'Event 1 lorem ipsum', slug: 'event-1', content: 'Lorem ipsum Sit minim cillum officia elit occaecat irure sint esse qui dolore dolore deserunt dolor.'},
  {title: 'Event 2 lorem ipsum', slug: 'event-2', content: 'Lorem ipsum Sed dolor sint labore deserunt in anim est veniam amet qui id anim aliqua commodo tempor et consequat elit quis.'},
  {title: 'Event 3 lorem ipsum', slug: 'event-3', content: 'Lorem ipsum Sunt pariatur in amet velit fugiat sunt deserunt qui officia proident sed sit cupidatat adipisicing.'},
  {title: 'Event 4 lorem ipsum', slug: 'event-4', content: 'Lorem ipsum Voluptate voluptate elit est non laborum non ea deserunt in sed laborum in id nisi aliqua quis quis velit.'},
  {title: 'Event 5 lorem ipsum', slug: 'event-5', content: 'Lorem ipsum In non laboris mollit aliquip adipisicing aliquip ea non dolore.'}
])

Category.create([
  {title: 'General', description: 'Lorem ipsum Sit minim cillum officia elit occaecat irure sint esse qui dolore dolore deserunt dolor.'},
  {title: 'Discussion', description: 'Lorem ipsum Sed dolor sint labore deserunt in anim est veniam amet qui id anim aliqua commodo tempor et consequat elit quis.'},
  {title: 'Teachers', description: 'Lorem ipsum Sunt pariatur in amet velit fugiat sunt deserunt qui officia proident sed sit cupidatat adipisicing.'}
])

Post.create([
  {title: 'Post 1 lorem ipsum', slug: 'post-1', content: 'Lorem ipsum Tempor cupidatat non ex minim nulla quis Excepteur sunt sunt officia sit adipisicing in dolor tempor.', user_id: 2, category_id: 1},
  {title: 'Post 2 lorem ipsum', slug: 'post-2', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 3, category_id: 2},
  {title: 'Post 3 lorem ipsum', slug: 'post-3', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 1, category_id: 3},
  {title: 'Post 4 lorem ipsum', slug: 'post-4', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 2, category_id: 1},
  {title: 'Post 5 lorem ipsum', slug: 'post-5', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 4, category_id: 2},
  {title: 'Post 6 lorem ipsum', slug: 'post-6', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 1, category_id: 3},
  {title: 'Post 7 lorem ipsum', slug: 'post-7', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 4, category_id: 1},
  {title: 'Post 8 lorem ipsum', slug: 'post-8', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 4, category_id: 2},
  {title: 'Post 9 lorem ipsum', slug: 'post-9', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 4, category_id: 3},
  {title: 'Post 10 lorem ipsum', slug: 'post-10', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 2, category_id: 1},
  {title: 'Post 11 lorem ipsum', slug: 'post-11', content: 'Lorem ipsum Id consectetur velit deserunt commodo minim in adipisicing laboris dolor elit incididunt nisi ullamco labore culpa.', user_id: 3, category_id: 3},
  {title: 'Post 12 lorem ipsum', slug: 'post-12', content: 'Lorem ipsum Cillum velit esse do Excepteur sit quis proident velit nulla cillum dolor qui aliquip Ut cupidatat consectetur Ut commodo.', user_id: 4, category_id: 3},
  {title: 'Post 13 lorem ipsum', slug: 'post-13', content: 'Lorem ipsum Reprehenderit adipisicing mollit cillum laborum officia culpa ea labore magna.', user_id: 2, category_id: 2},
  {title: nil, slug: 'post-14', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 2, category_id: nil, parent_id: 13},
  {title: nil, slug: 'post-15', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 3, category_id: nil, parent_id: 7},
  {title: nil, slug: 'post-16', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 1, category_id: nil, parent_id: 7},
  {title: nil, slug: 'post-17', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 4, category_id: nil, parent_id: 7},
  {title: nil, slug: 'post-18', content: 'Lorem ipsum Occaecat Ut quis nulla aute incididunt cillum sint officia dolore dolore dolore nisi reprehenderit officia.', user_id: 3, category_id: nil, parent_id: 10},
  {title: nil, slug: 'post-19', content: 'Lorem ipsum Fugiat eiusmod ullamco enim ad nostrud qui veniam nisi laboris nisi mollit.', user_id: 1, category_id: nil, parent_id: 10},
  {title: nil, slug: 'post-20', content: 'Lorem ipsum Eu quis aliqua adipisicing in mollit officia laboris minim ullamco fugiat dolor dolor non aliquip eiusmod.', user_id: 2, category_id: nil, parent_id: 10}
])