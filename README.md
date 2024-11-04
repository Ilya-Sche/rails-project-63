[![CI](https://github.com/Ilya-Sche/rails-project-63/actions/workflows/lint.yml/badge.svg)](https://github.com/Ilya-Sche/rails-project-63/actions/workflows/lint.yml)
[![hexlet-check](https://github.com/Ilya-Sche/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Ilya-Sche/rails-project-63/actions/workflows/hexlet-check.yml)

# HexletCode

HexletCode — это гем, предназначенный для создания HTML-форм в Ruby. Он упрощает процесс генерации форм, связанных с объектами пользователей.

## Установка

Добавьте гем HexletCode в ваш `Gemfile`:

```ruby
gem 'hexlet_code'

Затем выполните команду: bundle install

Примеры использования:

Создайте файл example.rb с содержимым:

ruby

require 'hexlet_code'

user = User.new(name: 'Иван', email: 'ivan@example.com')

html = HexletCode.form_for(user, url: '/users', method: 'post') do |f|
  f.input(:name)
  f.input(:email)
  f.submit('Создать')
end

puts html

Запустите скрипт:

ruby example.rb

Ожидаемый вывод:

html

<form action='/users' method='post'>
  <label for='name'>Name</label>
  <input name='name' type='text' value='Иван'>
  <label for='email'>Email</label>
  <input name='email' type='text' value='ivan@example.com'>
  <input type='submit' value='Создать'>
</form>
Генерация HTML-тегов
Создайте файл tag_example.rb с содержимым:

ruby

require 'hexlet_code'

html_tag = HexletCode.build('div', class: 'container', id: 'main')
puts html_tag

Запуск примера
Запустите скрипт:


ruby tag_example.rb
Ожидаемый вывод:

html

<div class='container' id='main'/>

Лицензия
MIT License

markdown


### Описание структуры README:
1. **Заголовок**: Название вашего гема.
2. **Описание**: Краткое введение о функциональности.
3. **Установка**: Инструкция по установке.
4. **Примеры использования**: Два примера с кодом, инструкциями по запуску и ожидаемым выводом.
5. **Лицензия**: Информация о лицензии.

Теперь README содержит примеры использования в файлах, что позволяет пользователям легко протестировать функциональность вашего гема!