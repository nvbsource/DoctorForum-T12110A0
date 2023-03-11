import { toast } from 'react-toastify';
import { call, put, takeLatest } from 'redux-saga/effects';
import topicService from '../../../services/topicService';
import {
   getTopicFailed,
   getTopicsOfParentStart,
   getTopicsOfParentSuccess,
   getTopicStart,
   getTopicSuccess
} from './topicSlice';

function* watchGetTopics() {
   try {
      const response = yield call(topicService.getTopics);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getTopicSuccess(data));
      } else {
         yield put(getTopicFailed());
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      yield put(getTopicFailed());
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchGetTopicsOfParent(action) {
   try {
      const response = yield call(topicService.getTopicsOfParent, action.payload);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getTopicsOfParentSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}

export function* watchTopicSaga() {
   yield takeLatest(getTopicStart.type, watchGetTopics);
   yield takeLatest(getTopicsOfParentStart.type, watchGetTopicsOfParent);
}
