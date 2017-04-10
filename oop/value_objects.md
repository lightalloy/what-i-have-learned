# Value objects

- objects that are equal due to the value of their properties. 
- should be immutable.
- are small.

What to extract:
Anything more than basic text fields and counters are candidates for Value Object extraction.
In Rails: when you have an attribute or small group of attributes that have logic associated with them.

Date, URI, and Pathname from Ruby’s standard library.

More examples: 
- Small objects, such as points, money, addresses or range.
- Parameter objects
- View objects (passed to view for rendering)

Value objects should have methods relying only on the value represented by the object and had no external side effects. They are useful when you need to compare concepts that aren't just straight database fields.

Value objects are often overlooked, but they are a good spot for refactoring in many cases.
E.g. in rails: extracting value objects from AR models.

Simplest way:
```ruby
Point = Struct.new(:x, :y)
```
But structs are mutable. You can overcome it by using [gem 'values'](https://github.com/tcrayford/values).

Links:  
https://martinfowler.com/bliki/ValueObject.html  
http://www.informit.com/articles/article.aspx?p=2220311&seqNum=11  
https://forum.upcase.com/t/value-objects/1996/2  
http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/  
