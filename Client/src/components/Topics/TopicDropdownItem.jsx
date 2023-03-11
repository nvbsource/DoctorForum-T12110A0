import { CaretDownOutlined } from '@ant-design/icons';
import React, { useEffect, useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import { getTimeElapsed, sliceString } from '../../utils/function';
import Avatar from '../Avatar';

export default function TopicDropdownItem({ data, onLoad, topicId, topicFirstParent }) {
   const { title, description, icon, subTopics, lastPost, numberPost } = data || {};
   const [showSubTopic, setShowSubTopic] = useState(false);
   const subTopicRef = useRef();

   useEffect(() => {
      // event listener để ẩn sub topic khi bấm bên ngoài phạm vi của sub topic
      function handleClickOutside(event) {
         if (subTopicRef.current && !subTopicRef.current.contains(event.target)) {
            setShowSubTopic(false);
         }
      }

      // thêm event listener
      document.addEventListener('mousedown', handleClickOutside);

      // clean up
      return () => {
         document.removeEventListener('mousedown', handleClickOutside);
      };
   }, [subTopicRef]);

   // hàm xử lý khi bấm vào button hiển thị sub topic
   function handleShowSubTopic() {
      setShowSubTopic(!showSubTopic);
   }
   return (
      <div className="px-3 py-5 flex justify-between items-center border-b-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-r-0 cursor-pointer">
         <div className="flex gap-3 h-auto">
            <img src={icon} alt="" className="max-w-[50px]" onLoad={onLoad} />
            <div className="">
               <h4 className="font-bold mb-0 flex items-start">
                  <Link to={`/posts/${topicFirstParent}/?topicId=${topicId}`} className="link-no-color">
                     {title}
                  </Link>
                  <span className="inline-block py-[2px] px-2 bg-[#3e5062] text-white rounded-md text-[10px] ml-2">
                     Mới
                  </span>
               </h4>
               <div className="flex gap-3">
                  {description && (
                     <p className="mb-0 text-[12px] flex items-center gap-2 text-[#484848]">
                        <div className="w-[3px] h-[3px] bg-black rounded-full"></div>
                        {description}
                     </p>
                  )}
                  {subTopics.length > 0 && (
                     <div className="relative" ref={subTopicRef}>
                        <div className="text-[#01704b] text-[12px]" onClick={handleShowSubTopic}>
                           Sub Topics <CaretDownOutlined />
                        </div>
                        {showSubTopic && (
                           <ul className="absolute list-none bg-white rounded-md border border-solid m-w-[300px] border-[#cbcbcb] font-[400]">
                              {subTopics.map(item => (
                                 <Link to={`/posts/${topicFirstParent}/?topicId=${item.id}`} className="link-no-color">
                                    <li className="px-2 hover:bg-[#666] hover:text-white whitespace-nowrap">
                                       {item.title}
                                    </li>
                                 </Link>
                              ))}
                           </ul>
                        )}
                     </div>
                  )}
               </div>
            </div>
         </div>
         {lastPost && (
            <div className="flex items-center gap-2">
               <div className="text-center">
                  <span className="font-bold block">{numberPost}</span>
                  <span className="block font-[500] text-[12px]">Chủ đề</span>
               </div>
               <div className="flex gap-2">
                  <Avatar
                     url={lastPost.user?.avatar}
                     role={lastPost.user?.role === 'Admin' ? 'Admin' : lastPost.user?.isDoctor ? 'Doctor' : 'Member'}
                  />
                  <div className="">
                     <div className="flex items-center gap-2">
                        <span className="inline-block px-[5px] bg-[#008000] text-white rounded-md text-[10px]  ">
                           Share
                        </span>
                        <p className="text-[12px] font-[500] mb-0">
                           <Link to={`/posts/detail/${lastPost?.id}`} className="text-inherit">
                              {sliceString(lastPost?.title, 20, '...')}
                           </Link>
                        </p>
                     </div>
                     <div className="flex items-center gap-2">
                        <span className="text-[12px]">{getTimeElapsed(lastPost?.created_at)}</span>
                        <span className="block w-[3px] h-[3px] bg-black rounded-full"></span>
                        <span className="font-[600] text-[12px]">
                           <Link to={`/profile/${lastPost?.user?.id}`} className="text-inherit">
                              {lastPost?.user?.fullName || 'Anonymouse'}
                           </Link>
                        </span>
                     </div>
                  </div>
               </div>
            </div>
         )}
      </div>
   );
}
