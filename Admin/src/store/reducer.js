// third-party
import { combineReducers } from 'redux';
import menuReducer from './slices/menu';
import snackbarReducer from './slices/snackbar';
import authReducer from './slices/auth';
import accountReducer from './slices/account';
import topicReducer from './slices/topic';
import postReducer from './slices/post';
// project imports

// ==============================|| COMBINE REDUCER ||============================== //

const reducer = combineReducers({
   menu: menuReducer,
   auth: authReducer,
   topic: topicReducer,
   post: postReducer,
   account: accountReducer,
   snackbar: snackbarReducer
});

export default reducer;
