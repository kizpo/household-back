require "csv"

CSV.foreach(Rails.root.join('db/Bank_list.csv'), headers: true) do |row|
    BankList.create({
        name: row['name']
    })
end

User.create!(
    name: "デモユーザー",
    email: "demo@example.com",
    password: "password123",
)
