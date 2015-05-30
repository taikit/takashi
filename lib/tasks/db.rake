namespace :db do
  desc 'サンプルデータを登録する'
  task populate: :environment do
    10.times do |n|
      User.create(
        email:    "email#{n}@example.com",
        password: "#{n}" * 8
        )
    end
    30.times do |n|
      Plan.create(
        user_id: 1,
        image:   "/public/uploads/plan/image/2/IMG_2845.JPG",
        title:   "Plan #{n}th's Title",
        body:    "Plan #{n}th's Body Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore optio architecto, id explicabo libero aspernatur aperiam voluptatibus doloribus autem repudiandae.",
        amount:  "3.5",
        area_id: 1
      )
    end
  end
end
