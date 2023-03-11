import { toast } from 'react-toastify';
import { push } from 'redux-first-history';
import { call, put, takeLatest } from 'redux-saga/effects';
import authService from '../../../services/authService';
import connection from '../../HubConnection/hubConnection';
import {
   changePasswordFailed,
   changePasswordStart,
   changePasswordSuccess,
   createUserFail,
   createUserStart,
   createUserSuccess,
   getProfileStart,
   getProfileSuccess,
   loginFail,
   loginStart,
   loginSuccess,
   saveProfileFailed,
   saveProfileStart,
   saveProfileSuccess
} from './authSlice';

function* watchLoginUser(action) {
   try {
      const response = yield call(authService.login, action.payload);
      if (response.data?.code == 200) {
         const { token, user } = response.data.result;
         yield put(loginSuccess(user));
         localStorage.setItem('access_token', token);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
         connection.start();
         yield put(push('/'));
      } else {
         yield put(loginFail(null));
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      yield put(loginFail(error.response?.data?.errors));
   }
}
function* watchCreateUser(action) {
   try {
      const response = yield call(authService.create, action.payload);
      if (response.data?.code == 200) {
         const { token, user } = response.data.result;
         yield put(createUserSuccess(user));
         localStorage.setItem('access_token', token);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
         connection.start();
         yield put(push('/'));
      } else {
         yield put(createUserFail(null));
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      toast(error.response.data?.message, { type: 'error', autoClose: 2000 });
      yield put(createUserFail(error.response?.data?.errors));
   }
}
function* watchSaveProfile(action) {
   try {
      const response = yield call(authService.saveProfile, action.payload);
      if (response.data?.code == 200) {
         yield put(saveProfileSuccess(response.data?.result));
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } else {
         yield put(saveProfileFailed(null));
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      toast(error.response.data?.message, { type: 'error', autoClose: 2000 });
      yield put(saveProfileFailed(error.response?.data?.errors));
   }
}

function* watchChangePassword(action) {
   try {
      const response = yield call(authService.changePassword, action.payload);
      if (response.data?.code == 200) {
         yield put(changePasswordSuccess(response.data?.result));
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } else {
         yield put(changePasswordFailed(null));
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      toast(error.response.data?.message, { type: 'error', autoClose: 2000 });
      yield put(changePasswordFailed(error.response?.data?.errors));
   }
}
function* watchGetProfileById(action) {
   try {
      const response = yield call(authService.getProfileById, action.payload);
      if (response.data?.code == 200) {
         yield put(getProfileSuccess(response.data?.result));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      console.log(error);
      toast(error.response.data?.message, { type: 'error', autoClose: 2000 });
   }
}
export function* watchAuthSaga() {
   yield takeLatest(loginStart.type, watchLoginUser);
   yield takeLatest(createUserStart.type, watchCreateUser);
   yield takeLatest(saveProfileStart.type, watchSaveProfile);
   yield takeLatest(changePasswordStart.type, watchChangePassword);
   yield takeLatest(getProfileStart.type, watchGetProfileById);
}
