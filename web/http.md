HTTP - HyperText Transfer Protocol
TCP - Transmission Control Protocol


HTTP/1.1
An HTTP client initiates a request by establishing a TCP connection to a particular port (typically, 80) on a server.

An HTTP server listening on that port waits for a client's request message.
When the server receives the request, the server sends back a status line, such as "HTTP/1.1 200 OK", and a message, which is the requested resource or an error message, or other information.

------------------------------------------------------------------

методы HTTP (get, post, head)
   OPTIONS - возможности соединения ресурса, не кэшируется
   GET - запрос содержимого, idempotent, 
   head - get без тела, кэшируется
   POST - вызвать action на сервере, не кэшируется, non-idempotent
   PUT  - замена ресурса полностью, типа заменили файл, не кэшируется, idempotent
        клиент предполагает, что загружаемое содержимое соответствует находящемуся по данному URI ресурсу.
   PATCH - allows full and partial updates and side-effects on other resources
          non-idempotent, cacheable
   TRACE
     Возвращает полученный запрос так, что клиент может увидеть, какую информацию промежуточные серверы добавляют или изменяют в запросе.
   CONNECT
     - Преобразует соединение запроса в прозрачный TCP/IP-туннель, обычно чтобы содействовать установлению защищённого SSL-соединения через нешифрованный прокси.

   Условные запросы:
   Условные GET 
    - тело запрашиваемого ресурса передаётся только если он изменялся после даты, указанной в заголовке If-Modified-Since
        - если не менялся, вернёт 304 Not Modified
Заголовки HTTP:
- запроса (Cache-Control, referer, Content-Type? user-agent, Accept-Charset, accept-enconding, If-Modified-Since, if-match, if-range, etc)
- ответа (Cache-Control, Content-Type, Content-Encoding, last-modified, Access-Control-*, Vary)

Управление запросом:
- управление сервером
  анализ заголовков клиента (Accept, Accept-Charset, Accept-Encoding, Accept-Languages и User-Agent)

Кэширование:

Cache-Control -- заголовок и в запросах, и в ответах







HTTP/2
leaves most of HTTP 1.1's high-level syntax.
increased speed.
New features like multiplexing queries.






