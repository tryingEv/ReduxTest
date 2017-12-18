import React, {Component} from "react";
import PropTypes from "prop-types";
import "../css/Test1.css";
class Test1 extends Component
{
    static propTypes = 
    {
        value: PropTypes.number.isRequired,
        time: PropTypes.string.isRequired,
        callChangeValue: PropTypes.func.isRequired,
        callChangeTime: PropTypes.func.isRequired
    }

    static defaultProps = 
    {
        value: 0,
        time: "",
        callChangeValue: null,
        callChangeTime: null
    }

    render()
    {
        return (
            <div>
                <span> Count : {this.props.value}</span>
                <span> Time : {this.props.time}</span>
                <span className="btn-change-value" onClick = {this.props.callChangeValue}>+</span>
                <span className='btn-change-time' onClick = {this.props.callChangeTime}> change time </span>
            </div>
        );
    }

}

export default Test1;