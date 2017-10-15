Check only changed files by rubocop:
```bash
bundle exec rubocop $(git status --porcelain | cut -c4- | grep '.rb' | xargs)
bundle exec rubocop --auto-correct $(git status --porcelain | cut -c4- | grep '.rb' | xargs)
```
