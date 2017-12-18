import {REQ_ADD_COUNT, REQ_CHANGE_TIME} from "../redux/action.js";
import {combineReducers} from 'redux';

function addCount(state=0, action)
{
    switch(action.type)
    {
        case REQ_ADD_COUNT:
        {
            return state + 1;
        }
        default:
        {
            return state;
        }

    }
}

function changeTime(state="not change time yet", action)
{
    switch(action.type)
    {
        case REQ_CHANGE_TIME:
        {
            return new Date().toTimeString();
        }
        default:
        {
            return state;
        }
    }
}

const changeValue = combineReducers({
    value: addCount,
    time: changeTime
});

export default changeValue;
