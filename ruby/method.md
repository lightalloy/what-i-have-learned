#[Method](https://ruby-doc.org/core-2.4.1/Method.html)

Couple of examples:

```ruby
meth = 1.method('*')
# => #<Method: Fixnum#*>
meth.arity
# => +
```

Rails:
```ruby
> User.last.method(:save).source_location
  User Load (236.3ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" DESC LIMIT 1
=> ["/home/light/.rbenv/versions/2.3.3/lib/ruby/gems/2.3.0/gems/activerecord-4.2.7.1/lib/active_record/transactions.rb", 284]
```