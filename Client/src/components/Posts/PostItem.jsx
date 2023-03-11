import moment from 'moment';
import React from 'react';
import { Link } from 'react-router-dom';
import Avatar from '../Avatar';

export default function PostItem({ data }) {
   const { title, created_at, user, comments, id } = data;
   return (
      <div className="flex justify-between border-b-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-r-0 px-5 py-3">
         <div className="flex items-center gap-3">
            <Avatar url={user?.avatar} role={user?.role === 'Admin' ? 'Admin' : user?.isDoctor ? 'Doctor' : 'Member'} />
            <div>
               <div className="flex items-center gap-2">
                  <span className="inline-block py-1 px-2 bg-[#3e5062] text-white rounded-md text-[10px]">Share</span>
                  <h4 className="mb-0 font-bold">
                     <Link to={`/posts/detail/${id}`} className="text-inherit">
                        {title}
                     </Link>
                  </h4>
               </div>
               <div className="flex items-center gap-2 ">
                  <span className="font-[400]">
                     <Link to={`/profile/${user?.id}`} className="text-inherit">
                        {user?.fullName || 'Anonymouse'}
                     </Link>
                  </span>
                  <div className="w-[3px] h-[3px] rounded-full bg-[#3e5062]"></div>
                  <span className="font-[400]">{moment(created_at).format('DD/MM/YYYY')}</span>
               </div>
            </div>
         </div>
         <div className="flex gap-[50px]">
            <div className="flex text-center gap-[30px]">
               <div>
                  <span>Reply</span>
                  <h5>{comments.length}</h5>
               </div>
            </div>
            <div>
               At the time {moment(created_at).format('HH:MM')} - {moment(created_at).format('DD/MM/YYYY')}
            </div>
         </div>
      </div>
   );
}
