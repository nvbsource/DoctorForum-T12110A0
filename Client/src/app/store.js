import { configureStore } from '@reduxjs/toolkit';
import createSagaMiddleware from 'redux-saga';
import rootSaga from './rootSaga';
import authReducer from './features/auth/authSlice';
import chatReducer from './features/chat/chatSlice';
import topicReducer from './features/topic/topicSlice';
import postReducer from './features/post/postSlice';
import { createReduxHistoryContext } from 'redux-first-history';
import { createBrowserHistory } from 'history';
const sagaMiddleware = createSagaMiddleware();
const { createReduxHistory, routerMiddleware, routerReducer } = createReduxHistoryContext({
   history: createBrowserHistory()
   //other options if needed
});

export const store = configureStore({
   reducer: {
      auth: authReducer,
      chat: chatReducer,
      topic: topicReducer,
      post: postReducer,
      router: routerReducer
   },
   middleware: getDefaultMiddleware => getDefaultMiddleware().concat(sagaMiddleware, routerMiddleware)
});
sagaMiddleware.run(rootSaga);

export const history = createReduxHistory(store);
export default store;
