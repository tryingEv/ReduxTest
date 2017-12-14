import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Test1 from "./js/Test1.js";
import {createStore} from "redux";
import counter from "./redux/Counter.js";

class App extends Component {
  constructor(props)
  {
    super(props);
    this.store = createStore(counter);
    this.store.subscribe(this.render.bind(this));
  }
  render() {
    let storeValue = this.store.getState();
    let {value, time} = storeValue;
    return(
      <div>
        <Test1 value={this.store.getState().value} time={this.store.getState().time}
        callBackValueChange={()=>{this.store.dispatch({type: "CHANGE_COUNTER"})}}/>
      </div>
    );
  }
}

export default App;

// value={value} 
// time = {time} 
// callBackVaueChang={()=>{this.store.dispatch({type:"CHANGE_COUNTER"})}} 
