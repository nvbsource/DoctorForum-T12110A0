import { createSlice } from '@reduxjs/toolkit';

const initialState = {
   loading: false,
   rooms: [],
   messages: [],
   numberMessageNew: 0,
   connectRoomId: null
};

const chatSlice = createSlice({
   name: 'chat',
   initialState,
   reducers: {
      getRoom: () => {},
      getRoomSuccess: (state, action) => {
         state.rooms = action.payload;
      },
      sendContentChatStart: state => {
         state.loading = true;
      },
      sendContentChatSuccess: state => {
         state.loading = false;
      },
      sendContentChatFailed: state => {
         state.loading = false;
      },
      getContentChat: () => {},
      getContentChatSuccess: (state, action) => {
         state.messages = action.payload;
      },
      pushContentChat: (state, action) => {
         const { chatId, receiverId, userId } = action.payload;
         const roomById = state.rooms.find(item => item.id === chatId);
         if (roomById) {
            roomById.lastChat = action.payload;
         }
         if (receiverId === parseInt(state.connectRoomId) || userId === parseInt(state.connectRoomId)) {
            state.messages.contentChats = [...state.messages.contentChats, action.payload];
         }
      },
      connectRoom: (state, action) => {
         state.connectRoomId = action.payload;
      },
      closeRoom: (state, action) => {
         state.connectRoomId = null;
      },
      IncrementNumberMessageNew: state => {
         state.numberMessageNew++;
      },
      DecrementNumberMessageNew: state => {
         state.numberMessageNew--;
      }
   }
});

export const {
   getRoom,
   sendContentChatStart,
   sendContentChatSuccess,
   sendContentChatFailed,
   getRoomSuccess,
   getContentChat,
   getContentChatSuccess,
   pushContentChat,
   userOnline,
   userOffline,
   connectRoom,
   closeRoom,
   IncrementNumberMessageNew,
   DecrementNumberMessageNew
} = chatSlice.actions;

export const selectAllRoomChat = state => state.chat.rooms;
export const selectAllContentChat = state => state.chat.messages;
export const selectNumberNewChat = state => state.chat.numberMessageNew;
export const selectConnectRoomIdChat = state => state.chat.connectRoomId;

export default chatSlice.reducer;
