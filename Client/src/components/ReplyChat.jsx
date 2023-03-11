import React from 'react';

export default function ReplyChat({ data, receiverUser }) {
   const { content, isYou, isRead, created_at } = data;
   return (
      <div className="flex items-center gap-[10px] mb-3">
         <img src={receiverUser?.avatar} alt="" className="w-[30px] h-[30px] rounded-full" />
         <p className="mb-0 p-2 text-[black] text-[12px] bg-[#e5e5e5b3] rounded-tr-xl rounded-br-xl rounded-bl-xl rounded-tl">
            {content}
         </p>
      </div>
   );
}
