import { DownCircleFilled, FileSyncOutlined } from '@ant-design/icons';
import { Rate } from 'antd';
import CollapsePanel from 'antd/lib/collapse/CollapsePanel';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link, useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import {
   getDetailPostStart,
   getNewPostsStart,
   selectPostDetail,
   selectPostDetailComments,
   selectPostNews
} from '../../app/features/post/postSlice';
import commentService from '../../services/commentService';
import postService from '../../services/postService';
import { formatDateTime, getTimeElapsed, sliceString } from '../../utils/function';
import Avatar from '../Avatar';
import Comment from './Comment';

export default function DetailPost() {
   const dispatch = useDispatch();
   const { postId } = useParams();
   const [comment, setComment] = useState('');
   const [parentComment, setParentComment] = useState(null);
   const [height, setHeight] = useState(500);
   const [isMore, setIsMore] = useState(false);
   const newPosts = useSelector(selectPostNews);
   const post = useSelector(selectPostDetail);
   const comments = useSelector(selectPostDetailComments);
   const userLogin = useSelector(selectUserAuth);

   useEffect(() => {
      dispatch(getDetailPostStart(postId));
      dispatch(getNewPostsStart(5));
   }, [dispatch, postId]);

   const handleShowFullContent = () => {
      setHeight('auto');
      setIsMore(true);
   };
   const handleSubmitComment = async e => {
      e.preventDefault();
      const { data } = await commentService.createComment({
         content: comment,
         postId,
         parentId: parentComment ? parentComment : null
      });
      if (data?.code === 200) {
         dispatch(getDetailPostStart(postId));
         setComment('');
         toast(data.message, { type: 'success', autoClose: 2000 });
      }
   };
   return (
      <div className="container !my-[40px] rounded-md">
         <div className="grid grid-cols-4 gap-6 items-start">
            <div className="col-span-3">
               <div className="bg-[#47a7eb] p-3 rounded-t-md text-white">
                  <h3 className="text-white font-bold mb-0 text-[20px]">{post?.title}</h3>
                  <div className="font-[500]">
                     <p className="mb-0">
                        {formatDateTime(post?.created_at)} - {post?.user?.fullName || 'Anonymouse'}
                     </p>
                  </div>
               </div>
               <div className="bg-white rounded-md overflow-hidden">
                  <div className="flex items-center justify-between p-3 border-b-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-r-0 ">
                     <div className="flex items-center gap-[20px]">
                        <Avatar
                           className="w-[80px] h-[80px]"
                           url={post?.user?.avatar}
                           role={post?.user?.role === 'Admin' ? 'Admin' : post?.user?.isDoctor ? 'Doctor' : 'Member'}
                        />
                        <div className="">
                           <div className="text-[16px]">
                              <Link to={`/profile/${post?.user?.id}`} className="text-inherit">
                                 {post?.user?.fullName || 'Anonymouse'}
                              </Link>
                           </div>
                        </div>
                     </div>
                     <ul className="list-none mb-0 basis-[auto]">
                        <li className="flex justify-between font-[500]">
                           <span>Join:</span>
                           <span className="ml-3">{formatDateTime(post?.user?.created_at)}</span>
                        </li>
                        <li className="flex justify-between font-[500]">
                           <span>Posts:</span>
                           <span>{post?.user?.posts?.length}</span>
                        </li>
                     </ul>
                  </div>
                  <div className="relative overflow-hidden">
                     <div
                        className={`px-10 py-5 ${isMore ? 'overflow-hidden' : ''}`}
                        style={{ height }}
                        dangerouslySetInnerHTML={{ __html: post?.content }}
                     ></div>
                     {!isMore && (
                        <div className="show-more" onClick={handleShowFullContent}>
                           Show more <DownCircleFilled />
                        </div>
                     )}
                  </div>
               </div>
               <div className="p-3 bg-white mt-5 rounded-md">
                  <h1 className="font-bold">Comments ({post?.numberComments})</h1>
                  {comments.map(item => (
                     <Comment data={item} key={item.id} />
                  ))}
                  <div className="mt-3 flex items-center gap-3">
                     <img src={userLogin?.avatar} alt="" className="w-[40px] h-[40px] rounded-full relative z-10" />
                     <form onSubmit={handleSubmitComment} className="w-full">
                        <input
                           type="text"
                           className="bg-[#eee] border-none outline-none px-3 py-2 w-full rounded-full"
                           placeholder="Write the answer"
                           value={comment}
                           onChange={e => setComment(e.target.value)}
                        />
                     </form>
                  </div>
               </div>
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
                              url={item?.user?.avatar}
                              role={item?.user?.role === 'Admin' ? 'Admin' : item?.user?.isDoctor ? 'Doctor' : 'Member'}
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
                                 <span className="font-[600] text-[12px]">{item.user?.fullName || 'Anonymouse'}</span>
                              </div>
                           </div>
                        </div>
                     </div>
                  ))}
               </div>
            </div>
         </div>
      </div>
   );
}
