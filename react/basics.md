## Component

## [Lifecycle](https://engineering.musefind.com/react-lifecycle-methods-how-and-when-to-use-them-2111a1b692b1)
- constructor - set initial state
- `componentWillMount` - your component is going to appear on the screen very shortly, use for app configuration in your root component, don't setState
- component `render` method is called
- `componentDidMount()` lifecycle hook is called
   Load in your data, add event listeners, call setState
- `componentWillReceiveProps`
  check which props will change (if any)
  If the props will change in a way that is significant, act on it
   is not called on initial render (actually no new props received)
- `setState()` call => React calls `render` method again
- if the component will ever be removed, its `componentWillUnmount() `lifecycle hook will be called


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


