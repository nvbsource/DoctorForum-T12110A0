import { MessageFilled } from '@ant-design/icons';
import React, { useEffect, useRef, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate, useParams } from 'react-router-dom';
import { selectUserAuth } from '../app/features/auth/authSlice';
import {
   connectRoom,
   getContentChat,
   getRoom,
   pushRoom,
   selectAllContentChat,
   selectAllRoomChat
} from '../app/features/chat/chatSlice';
import connection from '../app/HubConnection/hubConnection';
import { ChatRoom } from '../components/ChatRoom';
import { JoinChatRoom } from '../components/JoinChatRoom';
import PleaseChooseMessage from '../components/PleaseChooseMessage';
import { audioNewMessage } from '../utils/function';

export default function ChatPage() {
   const dispatch = useDispatch();
   const { id } = useParams();
   const userLogin = useSelector(selectUserAuth);
   const roomChats = useSelector(selectAllRoomChat);
   const contentChats = useSelector(selectAllContentChat);
   const bodyMessageRef = useRef(null);
   const navigate = useNavigate();

   useEffect(() => {
      dispatch(getRoom());
      connection.on('newRoom', () => {
         audioNewMessage();
         dispatch(getRoom());
      });
   }, [dispatch]);

   useEffect(() => {
      if (id) {
         handleGetContentChats(id);
         dispatch(connectRoom(id));
      }
   }, [id, roomChats]);

   useEffect(() => {
      bodyMessageRef?.current?.scrollIntoView({ behavior: 'smooth', block: 'end', inline: 'nearest' });
   }, [contentChats]);

   const handleGetContentChats = async receiverId => {
      dispatch(getContentChat(receiverId));
   };

   const renderJoinChatRoom = () => {
      return id ? <JoinChatRoom roomChat={contentChats} refMessage={bodyMessageRef} /> : <PleaseChooseMessage />;
   };

   const handleSetChooseInforReceiver = async inforReceiver => {
      navigate(
         `/messages/${userLogin.id === inforReceiver.userId ? inforReceiver.receiverUserId : inforReceiver.userId}`
      );
   };

   return (
      <div className="container !my-[40px]">
         <div className="bg-white rounded-xl flex h-[calc(100vh-210px)]">
            <div className="basis-[300px] pt-5 border-r-[1px] border-r-[#ededed] border-solid border-t-0 border-l-0 border-b-0">
               <div className="px-5">
                  <div className="flex justify-between items-center mb-3">
                     <h2 className="font-bold mb-0">Chat</h2>
                     <MessageFilled className="text-xl leading-0" />
                  </div>
               </div>
               <div className="h-[calc(100vh-210px-115px)] overflow-auto">
                  {roomChats.map(room => (
                     <ChatRoom data={room} handleClick={handleSetChooseInforReceiver} key={room.id} />
                  ))}
               </div>
            </div>
            {renderJoinChatRoom()}
         </div>
      </div>
   );
}
