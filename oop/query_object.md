# Query Object
- a PORO which represents a database query.

Use for complex SQL queries.

http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

```ruby
class AbandonedTrialQuery
  def initialize(relation = Account.scoped)
    @relation = relation
  end

  def find_each(&block)
    @relation.
      where(plan: nil, invites_count: 0).
      find_each(&block)
  end
end

AbandonedTrialQuery.new.find_each do |account|
  account.send_offer_for_support
end

old_accounts = Account.where("created_at < ?", 1.month.ago)
old_abandoned_trials = AbandonedTrialQuery.new(old_accounts)
```

http://craftingruby.com/posts/2015/06/29/query-objects-through-scopes.html
```ruby
class Video < ActiveRecord::Base
  scope :featured_and_popular, Videos::FeaturedAndPopularQuery
end

module Videos
  class FeaturedAndPopularQuery
    class << self
      delegate :call, to: :new
    end

    def initialize(relation = Video.all)
      @relation = relation
    end

    def call
      @relation.where(featured: true).where('views_count > ?', 100)
    end
  end
end
```

