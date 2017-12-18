export const REQ_ADD_COUNT = 'req_add_count';
export const REQ_CHANGE_TIME = 'req_change_time';

export function addCount(){
    return {type: REQ_ADD_COUNT};
}

export function changeTime(){
    return {type: REQ_CHANGE_TIME};
}
   