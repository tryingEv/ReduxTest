import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';
import App from './App';
import {Provider} from "react-redux";
import {createStore} from "redux";
import changeValue from "./redux/Counter.js";

let store = createStore(changeValue)

ReactDOM.render(
<Provider store={store}>
    <App />
</Provider>, 
document.getElementById('root'));
registerServiceWorker();
