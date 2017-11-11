```js
promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve()
  // reject
  }, 3000)
});

// callbacks
promise
    .then(() => { console.log('finished')})
    .then(() => { console.log('i also ran')})
    .catch(() => { console.log('rejected')})

// fetch
url = "https://jsonplaceholder.typicode.com/posts"
fetch(url)
  .then(response => response.json())
  .then(data => console.log(data))
```
