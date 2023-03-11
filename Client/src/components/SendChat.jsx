import React from 'react';
import { useSelector } from 'react-redux';
import { selectUserAuth } from '../app/features/auth/authSlice';

export default function SendChat({ data }) {
   const { content, isYou, isRead, created_at } = data;
   const userLogin = useSelector(selectUserAuth);
   return (
      <div className="flex justify-end mb-3">
         <div className="flex items-center gap-[10px] flex-row-reverse">
            <img src={userLogin?.avatar} alt="" className="w-[30px] h-[30px] rounded-full" />
            <p className="mb-0 p-2 text-[white] text-[12px] bg-[#009962] rounded-tr rounded-br-xl rounded-bl-xl rounded-tl-xl">
               {content}
            </p>
         </div>
      </div>
   );
}
