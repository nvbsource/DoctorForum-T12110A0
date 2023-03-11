import { toast } from 'react-toastify';
import { call, put, take, takeEvery, takeLatest } from 'redux-saga/effects';
import chatService from '../../../services/chatService';
import connection from '../../HubConnection/hubConnection';
import {
   connectRoom,
   getContentChat,
   getContentChatSuccess,
   getRoom,
   getRoomSuccess,
   pushContentChat,
   sendContentChatFailed,
   sendContentChatStart,
   sendContentChatSuccess
} from './chatSlice';

function* watchGetRoomChat() {
   try {
      const response = yield call(chatService.getRoomsChat);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getRoomSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchGetContentChat(action) {
   try {
      const receiverId = action.payload;
      const response = yield call(chatService.getContentChat, receiverId);
      if (response.data?.code === 200) {
         const data = response.data.result;
         yield put(getContentChatSuccess(data));
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
   }
}
function* watchSendContentChat(action) {
   try {
      const { receiverId, content, parentId } = action.payload;
      const body = { receiverId, content };
      if (parentId) body.parentId = parentId;
      const response = yield call(chatService.sendContentChat, body);
      if (response.data?.code === 200) {
         yield put(sendContentChatSuccess());
      } else {
         toast(response.data.message, { type: 'error', autoClose: 2000 });
         yield put(sendContentChatFailed());
      }
   } catch (error) {
      toast(error.data.message, { type: 'error', autoClose: 2000 });
      yield put(sendContentChatFailed());
   }
}

export function* watchChatSaga() {
   yield takeLatest(getRoom.type, watchGetRoomChat);
   yield takeLatest(getContentChat.type, watchGetContentChat);
   yield takeEvery(sendContentChatStart.type, watchSendContentChat);
}
