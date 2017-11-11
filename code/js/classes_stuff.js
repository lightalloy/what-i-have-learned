class Car {
  constructor(options) {
    this.title = options.title
  }

  drive(){
    return 'vroom '+this.title
  }
}

class Uaz extends Car{
  constructor(options){
    super(options)
    this.color = options.color
  }

  honk(){
    return 'beep '+this.color
  }
}

// const car = new Car({ title: 'Lada' })

const car = new Uaz({ color: 'green', title: 'uaz' })
console.log(car)
console.log(car.honk())
console.log(car.drive())
