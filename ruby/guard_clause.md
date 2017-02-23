# Guard clause

If you use if-else both cases are seen as equally important.
If you need to deal with special case, use guard clause.

```ruby
def work
  return if sick?
  tasks.each do |task|
    # do smth ...
  end
end
```

Instead of:

```ruby
def work
  unless sick?
    tasks.each do |task|
      # do smth ...
    end
  end
end
```

Benefits: clearer code, reduced nesting.