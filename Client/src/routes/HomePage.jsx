import {
   ChromeOutlined,
   FileDoneOutlined,
   FileSyncOutlined,
   PieChartOutlined,
   ProfileOutlined,
   ThunderboltOutlined,
   UserAddOutlined,
   UserOutlined,
   VideoCameraOutlined,
   WomanOutlined
} from '@ant-design/icons';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import { selectIsAuthenticatedAuth } from '../app/features/auth/authSlice';
import { getNewPostsStart, selectPostNews } from '../app/features/post/postSlice';
import { getTopicStart, selectAllTopics } from '../app/features/topic/topicSlice';
import SearchDoctor from '../components/SearchDoctor';
import TopicDropdown from '../components/Topics/TopicDropdown';
import { getTimeElapsed, sliceString } from '../utils/function';
import authService from '../services/authService';
import Avatar from '../components/Avatar';

export default function HomePage() {
   const topics = useSelector(selectAllTopics);
   const newPosts = useSelector(selectPostNews);
   const isAuthenticated = useSelector(selectIsAuthenticatedAuth);
   const [statistics, setStatistics] = useState({});
   const dispatch = useDispatch();
   useEffect(() => {
      dispatch(getTopicStart());
      dispatch(getNewPostsStart(5));
      handleGetStatistics();
   }, [dispatch]);
   const handleGetStatistics = async () => {
      try {
         const { data } = await authService.getStatistics();
         setStatistics(data.result);
      } catch (error) {
         console.log(error);
      }
   };
   return (
      <div className="container !my-[40px]">
         <SearchDoctor></SearchDoctor>
         {!isAuthenticated && (
            <div className="bg-white py-3 px-5 mb-3 rounded">
               <h1 className="font-bold text-black">WELLCOME</h1>
               <p>
                  By registering with us, you will be able to discuss, share and message privately with other members of
                  our community.
               </p>
               <Link
                  to="/signup"
                  className="px-5 py-2 rounded-full border-none bg-[#ff7f50] text-white hover:text-inherit inline-block"
               >
                  <UserAddOutlined /> Register now
               </Link>
            </div>
         )}

         <div className="flex items-center justify-between bg-white rounded py-3 px-5 mb-3">
            <h1 className="font-bold mb-0">Forum | World Community of Doctors</h1>
         </div>
         <div className="grid grid-cols-4 gap-6 items-start">
            <div className="col-span-3">
               {topics.map(item => (
                  <TopicDropdown data={item} key={item.id} parentFirst={item.id} />
               ))}
            </div>
            <div className="col-span-1">
               <div className="mb-3">
                  <div className="bg-[#009962] p-3 flex justify-between items-center border-b-[#E4E4E4] border-[3px] border-solid border-t-0 border-l-0 border-r-0 topic-parent">
                     <h3 className="font-bold mb-0 text-white">
                        <FileSyncOutlined /> Posts New
                     </h3>
                  </div>
                  {newPosts?.map(item => (
                     <div className="bg-white p-3" key={item.id}>
                        <div className="flex gap-2">
                           <Avatar
                              url={item.user.avatar}
                              role={item.user.role === 'Admin' ? 'Admin' : item.user.isDoctor ? 'Doctor' : 'Member'}
                           />
                           <div className="">
                              <div className="flex items-center gap-2">
                                 <span className="inline-block px-[5px] bg-[#008000] text-white rounded-md text-[10px]  ">
                                    Share
                                 </span>
                                 <p className="text-[12px] font-[500] mb-0">
                                    <Link to={`/posts/detail/${item?.id}`} className="text-inherit">
                                       {sliceString(item?.title, 20, '...')}
                                    </Link>
                                 </p>
                              </div>
                              <div className="flex items-center gap-2">
                                 <span className="text-[12px]">{getTimeElapsed(item.created_at)}</span>
                                 <span className="block w-[3px] h-[3px] bg-black rounded-full"></span>
                                 <span className="font-[600] text-[12px]">
                                    <Link to={`/profile/${item.user?.id}`} className="text-inherit">
                                       {item.user?.fullName || 'Anonymouse'}
                                    </Link>
                                 </span>
                              </div>
                           </div>
                        </div>
                     </div>
                  ))}
               </div>
               <div className="mb-3">
                  <div className="bg-[#009962] p-3 flex justify-between items-center border-b-[#E4E4E4] border-[3px] border-solid border-t-0 border-l-0 border-r-0 topic-parent">
                     <h3 className="font-bold mb-0 text-white">
                        <PieChartOutlined /> Forum Statistics
                     </h3>
                  </div>
                  <div className="bg-white p-3">
                     <ul className="list-none mb-0">
                        <li className="flex justify-between font-bold text-[15px]">
                           <span>
                              <ProfileOutlined /> Topics:
                           </span>{' '}
                           {statistics?.topics}
                        </li>
                        <li className="flex justify-between font-bold text-[15px]">
                           <span>
                              <FileDoneOutlined /> Posts:
                           </span>{' '}
                           {statistics?.posts}
                        </li>
                        <li className="flex justify-between font-bold text-[15px]">
                           <span>
                              <UserOutlined /> Members:
                           </span>{' '}
                           {statistics?.members}
                        </li>
                        <li className="flex justify-between font-bold text-[15px]">
                           <span>
                              <UserAddOutlined /> New Members
                           </span>{' '}
                           {statistics?.newMembers}
                        </li>
                     </ul>
                  </div>
               </div>
            </div>
         </div>
      </div>
   );
}
