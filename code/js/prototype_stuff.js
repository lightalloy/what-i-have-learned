function Car(options) {
  this.title = options.title;
}

const car = new Car({ title: 'Focus' })

Car.prototype.changeTitle = function(newTitle) {
  this.title = newTitle
}


Car.prototype.drive = function() {
  // this.title = ''
  return 'vrooom ' + this.title
}

// console.log(car)
console.log(car.drive())
car.changeTitle('Red Devyatka')
console.log(car.drive())

function Toyota(options) {
  Car.call(this, options)
  this.color = options.color
}

Toyota.prototype = Object.create(Car.prototype);
Toyota.prototype.constructor  = Toyota

Toyota.prototype.honk = function(){
  return 'honk '+this.color
}

const toyota = new Toyota({ color: 'red', title: 'Daily Driver'})
console.log(toyota.honk())
console.log(toyota.drive())

