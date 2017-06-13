# [Redux Core Concepts](http://redux.js.org/)
- a predictable state container for JavaScript apps.

Your app state is descibed as a plain object.
Different parts of the code can’t change the state arbitrarily.
To change smth in the state you need to dispatch an action.
An action is a plain js object.

To tie state and actions together, we write a function called a reducer.
Reducer takes state and action as an arguments and returns the next state of the app.
Small functions manage parts of the state.

And we write another reducer that manages the complete state of our app.

3 principles:
- single source of truth
  The state of your whole application is stored in an object tree within a single store.
- state is read-only
  The only way to change the state is to emit an action, an object describing what happened.
  Views and callbacks don't write directly to the state, they just express the intent to transform the state.
- changes are made with pure functions
  To specify how the state tree is transformed by actions, you write pure reducers.
  Remember to return new state objects, instead of mutating the previous state. 


