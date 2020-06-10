require 'faker'
require 'uri'

User.delete_all
Pet.delete_all

ActionMailer::Base.perform_deliveries = false

admin = FactoryBot.create(:user, email: 'admin@test.com', password: '123456', role: 'admin')
admin.confirm

user = FactoryBot.create(:user, email: 'test@test.com', password: '123456')
user.confirm

puts "-> User created with email #{user.email} and password #{user.password}"

20.times do
  FactoryBot.create(:pet, user: user)
end

puts "-> #{Pet.count} pets created"
