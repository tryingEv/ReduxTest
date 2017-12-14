export default (state = {value: 0, time: new Date().toTimeString()}, action)=>
{
    switch(action.type)
    {
        case "CHANGE_COUNTER":
        {
            return Object.assign({}, {value: state.value + 1, time: new Date().toTimeString()});
        }

        default:
            return state;
    }
}