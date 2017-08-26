# Hanami Interactors

Service Object-like.
Hides business login, has 1 public method #call.
Returns data object with state (success/failed) and specified getters.

- isolating business logic, easy callable
- easy code sharing
- easy control flow (e.g. redirect to url depending on the returned state)
