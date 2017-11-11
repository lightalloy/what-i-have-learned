mix - create, compile projects, run 'tasks', manage dependencies

mix new cards

install dependencies

mix deps.get

mix test

module - collection of methods and functions, no instance vars
-------
Elixir is transpiled into Erlang Code, executed on BEAM - Erlang Abstract Machine

console:
```bash
iex -S mix
# recompile - reload
# ctrl+c - exit
```

We can have several methods with the same name, that accept different arguments.
Elixir forces u to use the correct number of args.

Enum(erables)

List comprehensions - a mapping function; for every element we run a do block and what is returned from a block gets put to a new array.
You can have multiple comprehensions:
```elixir
for suit <- suits, value <- values do
  "#{value} of #{suit}"
end
```

Tuple is like an array where the indexes have a special meaning.

Pattern matching - special way of variable assignment.

:ok, :error, :etc => atoms

Pipes:
```elixir
Cards.create_deck
|> Cards.shuffle
|> Cards.deal(hand_size)
```

```elixir
# maps
colors = %{ primary: "red" }
# modify a Map
colors = %{ colors | primary: "blue" }
# add a property
colors = Map.put(colors, :secondary_color, "green")
```

```elixir
# keyword list
colors = [primary: "red", secondary: "blue"]
colors = [{:primary, "red"}, {:secondary, "green"}]

# you can specify same keys
[primary: "red", primary: "blue"]
# e.g. for db access ()
User.find_where({where: user.age > 20, where: user.subscribed == true})

# you can also remove square braces - still 1 arg
User.find_where(where: user.age > 20, where: user.subscribed == true)

# still the same
User.find_where where: user.age > 20, where: user.subscribed == true
```