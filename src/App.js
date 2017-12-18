import React, { Component } from 'react';
import {connect} from 'react-redux';
import './App.css';
import AddCountContainer from './container/AddCountContainer.js';
import {addCount, changeTime} from'./redux/action.js';
class App extends Component {
  constructor(props)
  {
    super(props);
  }
  render() {
    return(
      <div>
        <AddCountContainer />
      </div>
    );
  }

  
}
export default App;

