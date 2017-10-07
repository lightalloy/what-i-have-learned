# CQS (Command Query Separation)

Each method should either be a command that performs action or a query that returns data.

Queries: Return a result and do not change the observable state of the system (are free of side effects).
Commands: Change the state of a system but do not return a value.

# CQRS (Command and Query Responsibility Segregation)
- creation of two objects where there was previously only one.
