import { LikeFilled } from '@ant-design/icons';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { selectUserAuth, selectUsersOnlineAuth } from '../app/features/auth/authSlice';
import { sendContentChatStart } from '../app/features/chat/chatSlice';
import { findUserOnlineByUserId, findUserReceiverByLogin } from '../utils/function';
import Avatar from './Avatar';
import ReplyChat from './ReplyChat';
import SendChat from './SendChat';
export function JoinChatRoom({ refMessage, roomChat = {} }) {
   const { id } = useParams();
   const { userReceiver, contentChats } = roomChat;
   const [messageText, setMessageText] = useState('');
   const dispatch = useDispatch();
   const usersOnline = useSelector(selectUsersOnlineAuth);
   const userLogin = useSelector(selectUserAuth);

   const [online, setOnline] = useState(false);
   useEffect(() => {
      const idReceiver = findUserReceiverByLogin({
         users: [userReceiver?.id, userLogin?.id],
         userIdLogin: userLogin?.id
      });
      setOnline(findUserOnlineByUserId({ usersOnline, userId: idReceiver }));
   }, [usersOnline, userReceiver, userLogin]);
   const renderChats = () => {
      return contentChats?.map(message => {
         const { isYou } = message;
         if (isYou) {
            return <SendChat data={message} key={message.id} />;
         } else {
            return <ReplyChat data={message} key={message.id} receiverUser={userReceiver} />;
         }
      });
   };
   const handleSendMessage = async e => {
      e.preventDefault();
      dispatch(sendContentChatStart({ content: messageText, receiverId: id }));
      setMessageText('');
   };
   return (
      <div className="flex-1">
         <div className="flex items-center py-3 gap-[15px] px-5 group hover:bg-[#009962a8] ease-linear duration-100 cursor-pointer border-b-[1px] border-b-[#ededed] border-solid border-t-0 border-l-0 border-r-0">
            <div className="relative">
               <Avatar
                  className="w-[50px] h-[50px]"
                  url={userReceiver?.avatar}
                  role={userReceiver?.role === 'Admin' ? 'Admin' : userReceiver?.isDoctor ? 'Doctor' : 'Member'}
               />
               {online ? (
                  <div className="bg-[#31a24c] w-[13px] h-[13px] rounded-full absolute bottom-0 right-0"></div>
               ) : (
                  <div className="bg-[#e81e1e] w-[13px] h-[13px] rounded-full absolute bottom-0 right-0"></div>
               )}
            </div>
            <div>
               <h3 className="font-bold mb-0 group-hover:text-[white]">{userReceiver?.fullName || 'Anonymouse'}</h3>
               <p className="text-xs text-[#67696a] group-hover:text-[white] mb-0 font-[500]">
                  {online ? 'Đang hoạt động' : 'Không hoạt động'}
               </p>
            </div>
         </div>
         <div className="p-5 h-[calc(100vh-210px-153px)] overflow-auto">
            {renderChats()}
            <div ref={refMessage}></div>
         </div>
         <form className="p-5 flex items-center gap-3" onSubmit={handleSendMessage}>
            <input
               type="text"
               placeholder="Aa"
               className="border-none block w-full py-2 px-4 focus:outline-none rounded-full bg-[#88abab40]"
               onChange={e => setMessageText(e.target.value)}
               defaultValue={messageText}
               value={messageText}
            />
         </form>
      </div>
   );
}
