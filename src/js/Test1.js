import React, {Component} from "react";
import PropTypes from "prop-types";
import "../css/Test1.css";
class Test1 extends Component
{
    static propTypes = 
    {
        value: PropTypes.number,
        time: PropTypes.string,
        callBackVaueChange: PropTypes.func
    }

    static defaultProps = 
    {
        value: 0,
        time: "",
        callBackVaueChange: null
    }

    render()
    {
        const {value, time, callBackValueChange} = this.props;
        return (
            <div>
                <span> count is {value}</span>
                <span> change count time {time}</span>
                <span className="btn-changeValue" onClick = {callBackValueChange}>+</span>
                <div className="div-test">test vertical center</div>
            </div>
        );
    }

}

export default Test1;