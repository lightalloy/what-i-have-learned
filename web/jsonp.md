### Jsonp
- JSON with padding
- костыль для кроссдоменных ajax-запросов

Padding -- обычно имя функции обратного вызова (callback).

Добавляем на страницу скрипт с внешним адресом:
<script src="http://example.com/api.js?method=get_user&user_id=42&callback=processUser"></script>

Только GET
