# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "1234",
    admin: true
)
#u.skip_confirmation!
u.save!

u = User.new(
    email: "operator1@example.com",
    password: "1234",
    admin: false
)
#u.skip_confirmation!
u.save!

u = User.new(
    email: "operator2@example.com",
    password: "1234",
    admin: false
)
#u.skip_confirmation!
u.save!
