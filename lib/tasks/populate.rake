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
      Category.create(:name => category_name)
    end

    puts "------> Новые категори успешно добавлены:"
    Category.find_each do |category|
     puts " - #{category.name}"
    end
    
    

  
  end
end
