Check only changed files by rubocop:
```bash
bundle exec rubocop $(git status --porcelain | cut -c4- | grep '.rb' | xargs)
```
