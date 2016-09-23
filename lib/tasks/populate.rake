namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Category, Target].each(&:delete_all)
     
	
    target_list= [
		"Молочный завод", "Сильпо", "Новая почта", "Фабрика печенья", "Офис", "Фокус-покус", "Караоке", "Скорая помощь ", "Пожарка", "Полиция", "Радио", "ТВ студия", "Студия моды", "Флористика", "Салон красоты", "Инвестиции _ Станции", "Инвестиции _ Капитальные ", "Издательство" 
		]
    
    category_list =  ["Расходные материалы", "Хоз.материалы", "Печатная продукция", "Канцтовары для станций", "Муляжи", "Канцтовары для офиса", "Бренд-партнер Яготин", "Бренд-партнер Сильпо", "Бренд-партнер Новая почта", "На списание", "Форма персонала", "Детская форма", "Картриджи", "Артибутика - Новый год", "Атрибутика - Фотостудия", "RFID", "Мебель", "Оборудование станций ", "Строительство ", "Эксплуатация оборудования ", "Инвестиции" ]
    target_list.each do |target_name|
      Target.create(:name => target_name)
    end
    puts "------> Новые станции успешно добавлены:"
    Target.find_each do |target|
     puts " - #{target.name}"
    end
    
    category_list.each do |category_name|
      Category.create(:name => category_name, :user_id => User.order("RANDOM()").first.id )
    end

    puts "------> Новые категори успешно добавлены:"
    Category.find_each do |category|
     puts " - #{category.name} #{category.user.email}"
    end
    
   
  
  end



  desc "Erase and fill database"
  task :fake => :environment do
  
    [Item, Transaction].each(&:delete_all)
  #require 'populator'
  require 'faker'
  #binding.pry 
  Category.all[0..10].each do |category|
    3.times do |k|
         item = Item.new   
         #item.name = "Product #{rand(0..10000)}"
         item.name = Faker::Commerce.product_name
         item.sku = Faker::Code.asin 
         item.description = "short description" 
         item.price = Faker::Commerce.price 
         item.amount = Faker::Number.between(1, 100)
         item.red_line = Faker::Number.between(10, 20)
         item.unit_type = ' p.'
         item.save  
         category.items << item
         item.save
         item.transactions.create(
              :item_id => item.id, :action_type => "In", :user_id => item.category.user_id, :amount => item.amount, :cost => item.amount*item.price)
         
         transaction = item.transactions.create(
              :item_id => item.id, :target_id => Target.order("RANDOM()").first.id, :action_type => "Out", :user_id => item.category.user_id, :amount => rand(item.amount))
         
        transaction.cost = transaction.amount*item.price
        transaction.save
    end
  end
  end
end
