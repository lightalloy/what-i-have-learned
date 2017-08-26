## Component

## Props
Immutable

'''
render() {
  <Text>{this.props.text}</Text>
}
'''
default props:
'''
HelloComponent.defaultProps = {text: "Default Text!"};
'''
validating:
'''
HelloComponent.propTypes = {text: React.PropTypes.string};
'''

## State
Mutable and private set of data.
'''
class HelloComponent extends React.Component{
  constructor (props) {
    super(props);
    this.state = { // Set Initial State
    appendText: ''
  };
  render(){
  //...
  <Text>{this.state.appendText}</Text>
  //...
  }
}
'''
The setState function will merge the object you pass into the first argument with the current state of the component. Calling setState will trigger a new render with a new state!


