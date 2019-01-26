## [Introduction to rom](https://www.rubytapas.com/2018/12/03/getting-started-with-rom-rb/)
`ROM::Repository` - repository pattern
Serves between the app's domain layer (business logic) and the persistance layer (the details of interacting with the database).

`Relation` - contain the low-level query logic for each data source.
The repository calls relation methods (like `artile.ordered_by_date`)

Relations are intended to be chainable and composable, so the `Relation` object will be returned.
To get the data you need materialize them with calling `to_a`.
After materializing the simple `ROM::Struct`s will be returned, they contain only data.

 We can customize our structs: make an article module, then define an Article class within it, inheriting from `ROM::Struct`, add the needed methods.
+ add `struct_namespace` in the repository.

You can also add another relation and associate it to the first with `associations {}`
Ask for the associated data with `combine`.

The benefits: the logic is separated: `repository` is the front door, `relations` - query logic, `structs` - data representation.
`Rom` is dedicated to persistence only.

- что за паттерн репозиторий? What is the repository patern for?
- как получить данные из базы в репозитории (релейшены)?
- что возвращают relations? (Какие объекты)
- как их преобразовать в данные?
- что делать, если нужен какой-то кастомный метод в данных?
- как делать ассоциации?
- в чём преимущество данного подхода?
- что делает ром, а что не делает,

## [Writing changes with rom-rb](https://www.rubytapas.com/2018/12/11/writing-changes-with-rom-rb/)

Add `create` method to your repo.
```ruby
  def create(attrs)
    articles.changeset(:create, attrs).commit
  end

  def update(id, attrs)
    articles.by_pk(id).changeset(:update, attrs).commit
  end
```
It'll return an instance of `ROM::Changeset::Create,`

```ruby
repo = ArticleRepo.new(rom)
repo.create(title: "Together breakfast", published_at: Time.now).to_h
```

Rom changesets:
- connect with a relation
- carry the data we've passed
- convert to a hash

Call `commit` on a changeset => newly created struct with an `id`

### Custom behaviour
E.g. you want to generate a slug for an article.
You can make a changeset responsible for the slug.

```ruby
class CreateArticle < ROM::Changeset::Create
  map do |attrs|
    attrs.merge(
      slug: attrs[:title].downcase.gsub(/\s/, "-"),
    )
  end
end

# in a repo
  def create(attrs)
    articles.changeset(CreateArticle, attrs).commit
  end
```

You can create associated record in a repo:

```ruby
transaction do
  author = authors.changeset(:create, attrs[:author]).commit

  articles.changeset(CreateArticle, attrs).associate(author).commit
end
```

Changesets are _dedicated_ to making changes, nothing more. They represent the changes we make.

## [Building queries with rom-rb](https://www.rubytapas.com/2018/12/19/building-queries-with-rom-rb/)

```ruby
articles
  .select(:id, :title)
  .to_a

articles
  .select(articles[:id], articles[:title])
  .to_a

articles
  .select { [id, title] }
  .to_a

articles
  .select { [id, string::concat(title, ': ',  subtitle).as(:full_title)] }
  .to_a

articles
  .select { [id, title] }
  .where { title.like('%breakfast%') }
  .to_a

articles
  .select { [id, title] }
  .where { title.like('%breakfast%') | (id > 1) }
  .to_a

articles
  .select { [id, title, authors[:name].as(:author_name)] }
  .join(authors)
  .select_append(authors[:name].as(:author_name))
  .to_a

articles
  .select { [id, title, relations[:authors][:name].as(:author_name)] }
  .join(authors)
  .to_a

articles
  .select { [id, title] }
  .combine(:comments)
  .to_a

articles
  .select { [id, title] }
  .combine(:comments)
  .node(:comments) { |comments| comments.order { created_at.desc } }
  .to_a

articles
  .select { [id, title] }
  .combine(:comments)
  .node(:comments) { |comments| comments.limit(2) }
  .to_a

```
