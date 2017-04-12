# %w vs %W

[Percent Strings](http://ruby-doc.org/core-2.4.0/doc/syntax/literals_rdoc.html#label-Percent+Strings)

Lower case - no code interpolation, upper case - uses code interpolation.

```ruby
nick = 'lightalloy'
%w(anna #{nick}) # =>  ["anna", "\#{nick}"]
%W(anna #{nick}) # => ["anna", "lightalloy"]

%w(anna light\ alloy) # => ["anna", "light alloy"]
```

