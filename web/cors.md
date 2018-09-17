## Cross-Origin Resource Sharing
Special headers that tell, that the request comes from another domain.

GET, POST, HEAD

В заголовек ответа `Access-Control-Allow-Origin` сервер Z отдаёт список доверенных доменов.
После этого страницы серверов A, B, C смогут загружать контент с сервера Z.

Инициация CORS-запроса:
- браузер клиента добавляет в HTTP запрос Origin (домен сайта, с к-го идёт запрос)
Страница http://www.a.com/page.html пытается получить данные со страницы http://www.b.com/cors.txt:
```
GET /cors.txt HTTP/1.1
Host: www.b.com
Origin: www.a.com
```

www.b.com разрешает  получение данных с www.a.com :
В ответе сервера: `Access-Control-Allow-Origin: http://www.a.com`

Разрешить доступ всем доменам: `Access-Control-Allow-Origin: *`

Разрешить доступ нескольким доменам:
`Access-Control-Allow-Origin: http://www.a.com http://www.b.com http://www.c.com`

ruby - `rack-cors`
