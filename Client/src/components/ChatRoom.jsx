import Paragraph from 'antd/lib/skeleton/Paragraph';
import { useEffect, useState } from 'react';
import { useSelector } from 'react-redux';
import { selectUserAuth } from '../app/features/auth/authSlice';
import { selectUsersOnlineAuth } from '../app/features/auth/authSlice';
import { findUserOnlineByUserId, findUserReceiverByLogin, getTimeElapsed, sliceString } from '../utils/function';
import Avatar from './Avatar';

export function ChatRoom({ data, handleClick }) {
   const { nameChat, receiverUserId, lastChat, userId, receiverUser } = data;
   const inforReceiver = { nameChat, receiverUserId, lastChat, userId, receiverUser };
   const usersOnline = useSelector(selectUsersOnlineAuth);
   const userLogin = useSelector(selectUserAuth);
   const [online, setOnline] = useState(false);

   useEffect(() => {
      const idReceiver = findUserReceiverByLogin({
         users: [receiverUserId, userId],
         userIdLogin: userLogin?.id
      });
      setOnline(findUserOnlineByUserId({ usersOnline, userId: idReceiver }));
   }, [usersOnline, receiverUserId, userId, userLogin?.id]);
   return (
      <div
         className="flex items-center py-3 gap-[15px] px-5 group hover:bg-[#009962a8] ease-linear duration-100 cursor-pointer"
         onClick={() => handleClick(inforReceiver)}
      >
         <div className="relative">
            <Avatar
               className="w-[50px] h-[50px]"
               url={receiverUser?.avatar}
               role={receiverUser?.role === 'Admin' ? 'Admin' : receiverUser?.isDoctor ? 'Doctor' : 'Member'}
            />
            {online ? (
               <div className="bg-[#31a24c] w-[13px] h-[13px] rounded-full absolute bottom-0 right-0"></div>
            ) : (
               <div className="bg-[#c42525] w-[13px] h-[13px] rounded-full absolute bottom-0 right-0"></div>
            )}
         </div>
         <div className="flex-1">
            <h3 className="font-bold mb-0 group-hover:text-[white]">{nameChat || 'Anonymouse'}</h3>
            <p className="text-xs text-[#67696a] group-hover:text-[white] mb-0 font-[500]">
               {sliceString(lastChat?.content, 70, '...')}- {getTimeElapsed(lastChat?.created_at)}
            </p>
         </div>
      </div>
   );
}
