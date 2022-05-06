import './App.css';
import { Component } from 'react';
import ProductShowPage from './components/ProductShowPage';
import ProductIndexPage from './components/ProductIndexPage';
import ShapeMaker from './components/ShapeMaker';
import ProductNewPage from './components/ProductNewPage';
import SignInPage from './components/SignInPage';
import AuthRoute from './components/AuthRoute';
import SignUpPage from './components/SignUpPage';
import { BrowserRouter, Route, Switch } from 'react-router-dom'
import { Session } from './requests';
import Navbar from './components/Navbar';

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      user: null
    }
  }

  componentDidMount() {
    Session.currentUser()
    .then(user=>{
      console.log('user', user);
      this.setState(()=>{
        return {user: user}
      })
    })
  }
  handleSubmit(params){
    Session.create(params).then(()=>{
      return Session.currentUser()
    }).then(user=>{
        this.setState(()=>{
          return {user: user}
        })
    })
  }
  destroySession(){
    Session.destroy()
    .then(res=>{
      this.setState(()=>{
        return {user: null}
      })
    })
  }
  handleSignUp(){
    Session.currentUser().then(user=>{
      this.setState((state)=>{
        return {user: user}
      })
    })
  }

  render() {
    return (
      <div className="App">
        <BrowserRouter>
        <Navbar currentUser={this.state.user} destroySession={this.destroySession.bind(this)} />
          <Switch>
            <Route path='/' exact render={() => <div>Hello World</div> } />
            {/* <Route path='/products/new' component={ProductNewPage} /> */}
            <AuthRoute path='/products/new' isAuth={this.state.user} component={ProductNewPage} />
            <Route path='/products/:id' component={ProductShowPage} />
            <Route path='/products' component={ProductIndexPage} />
            <Route path='/shapemaker' component={ShapeMaker} />
            <Route path='/sign_in' render={(routeProps)=><SignInPage handleSubmit={this.handleSubmit.bind(this)} {...routeProps}/>} />
            <Route path='/sign_up' render={(routeProps)=><SignUpPage handleSignUp={this.handleSignUp.bind(this)} {...routeProps}/>}/> 
          </Switch>
        </BrowserRouter>
      </div>
    );
  }
}

export default App;
