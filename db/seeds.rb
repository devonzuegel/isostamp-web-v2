400.times do
  User.create(
    name:       Faker::Name.name,
    provider:   'facebook',
    created_at: Faker::Time.between(1.year.ago, 1.minute.ago)
  )
end

400.times do
  user = User.order('RANDOM()').first
  Document.create(
    user:         user,
    created_at:   Faker::Time.between(user.created_at, 1.minute.ago)
  )
end