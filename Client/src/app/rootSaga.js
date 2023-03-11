import { all } from 'redux-saga/effects';
import { watchAuthSaga } from './features/auth/authSaga';
import { watchChatSaga } from './features/chat/chatSaga';
import { watchPostSaga } from './features/post/postSaga';
import { watchTopicSaga } from './features/topic/topicSaga';
export default function* rootSaga() {
   yield all([watchAuthSaga(), watchChatSaga(), watchTopicSaga(), watchPostSaga()]);
}
