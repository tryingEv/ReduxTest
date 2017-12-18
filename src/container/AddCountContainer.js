import {connect} from 'react-redux';
import Test1 from "../js/Test1.js";
import {addCount, changeTime} from "../redux/action.js";

function mapStateToProps(state){
    return {
      value: state.value,
      time: state.time
    };
  }

function mapDispatchToProps(dispatch){
    return{
      callChangeValue: ()=>{dispatch(addCount());},
      callChangeTime: ()=>{dispatch(changeTime());}
    };
  }

const AddCountContainer = connect(mapStateToProps, mapDispatchToProps)(Test1);
export default AddCountContainer;