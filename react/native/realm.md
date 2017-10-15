## Synchronously Opening Realms (not recommended)
`const realm = new Realm({schema: [PersonSchema]});`

## Async Opening Realms
```
Realm.open({schema: [Car, Person]})
  .then(realm => {
    // ...use the realm instance here
  })
  .catch(error => {
    // Handle the error here if something went wrong
  });
```


