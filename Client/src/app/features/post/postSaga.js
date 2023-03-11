import { toast } from 'react-toastify';
import { push } from 'redux-first-history';
import { call, put, takeLatest } from 'redux-saga/effects';
import postService from '../../../services/postService';
import { history } from '../../store';
import {
   createPostFailed,
   createPostStart,
   createPostSuccess,
   editPostStart,
   editPostSuccess,
   getDetailPostStart,
   getDetailPostSuccess,
   getNewPostsStart,
   getNewPostsSuccess,
   getPostsOfTopicStart,
   getPostsOfTopicSuccess,
   getPostsStart
} from './postSlice';

function* watchGetNewPosts(action) {
   try {
      const response = yield call(postService.getNewPosts, action.payload);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getNewPostsSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchGetPostsOfTopic(action) {
   try {
      const response = yield call(postService.getPostsOfTopic, action.payload);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getPostsOfTopicSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchDetailGetPost(action) {
   try {
      const response = yield call(postService.getDetailPost, action.payload);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getDetailPostSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* createPost(action) {
   try {
      const response = yield call(postService.createPost, action.payload);
      const data = response.data.result;
      if (response.data?.code === 200) {
         yield put(createPostSuccess(data));
         yield put(getPostsOfTopicStart(data?.topicId));
      } else {
         yield put(createPostFailed());
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      yield put(createPostFailed());
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchUpdatePost(action) {
   try {
      const response = yield call(postService.updatePost, action.payload);
      const data = response.data.result;
      if (response.data?.code === 200) {
         yield put(editPostSuccess(data));
         yield put(push(`/posts/detail/${data?.id}`));
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      toast(error.data?.message, { type: 'error', autoClose: 2000 });
   }
}

export function* watchPostSaga() {
   yield takeLatest(createPostStart.type, createPost);
   yield takeLatest(getNewPostsStart.type, watchGetNewPosts);
   yield takeLatest(getPostsOfTopicStart.type, watchGetPostsOfTopic);
   yield takeLatest(getDetailPostStart.type, watchDetailGetPost);
   yield takeLatest(editPostStart.type, watchUpdatePost);
}
