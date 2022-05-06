Tagging.delete_all
Tag.delete_all
Product.delete_all
Review.delete_all
User.delete_all

PASSWORD='supersecret'
super_user=User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    location: '50.64.108.159',
    is_admin: true
)
User.create(
    first_name: "Cheng",
    last_name: "Pham",
    email: "chengpham@gmail.com",
    password: "Password0",
    location: '50.64.108.159',
    is_admin: true
)
10.times do 
    first_name= Faker::Name.first_name 
    last_name= Faker::Name.last_name 
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: PASSWORD,
        location: '50.64.108.159',
        created_at: Faker::Date.backward(days: 365)
    )
end
users=User.all
10.times do 
    Tag.create(
        name:Faker::Vehicle.make
    )
end
tags=Tag.all
20.times do 
    p=Product.create(
        title: Faker::Games::Fallout.character,
        description: Faker::Games::Fallout.quote,
        price: rand(100),
        user: users.sample
    )
    if p.valid?
        p.reviews = rand(0..15).times.map do 
            Review.new(
                body: Faker::GreekPhilosophers.quote,
                rating: rand(1..5),
                user: users.sample
            )
        end
        p.tags= tags.shuffle.slice(0,rand(tags.count))
    end
end


puts "Product Count #{Product.count}"
puts "Review Count #{Review.count}"
puts "User Count #{User.count}"
puts "Tags Count: #{Tag.count}"
puts "Login with  #{super_user.email} and password:#{PASSWORD}."