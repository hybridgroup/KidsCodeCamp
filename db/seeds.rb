Editpage.create([
  { title:'About', content:'...' },
  { title:'Tools', content:'...' },
  { title:'Lessons', content:'...' },
  { title:'Home', content:'...' }
])

User.create([
  { username: 'admin', email: 'admin@a.com', password: 'admin123', password_confirmation: 'admin123', is_admin: true }
])

Category.create([
  {title: 'General', description: '...'},
  {title: 'Discussion', description: '...'},
  {title: 'Teachers', description: '...'}
])