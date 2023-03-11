import { EditFilled } from '@ant-design/icons';
import { Popconfirm } from 'antd';
import React from 'react';
import { useEffect } from 'react';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import { getDetailPostStart, selectPostDetail } from '../../app/features/post/postSlice';
import commentService from '../../services/commentService';
import { getTimeElapsed } from '../../utils/function';
import Avatar from '../Avatar';

export default function CommentChild({ data, setShowInput, setParentId, setNameParent }) {
   const { content, user, created_at, parent, id } = data;
   const post = useSelector(selectPostDetail);
   const userLogin = useSelector(selectUserAuth);
   const [open, setOpen] = useState(false);
   const [confirmLoading, setConfirmLoading] = useState(false);
   const [commentIdDelete, setCommentIdDelete] = useState(null);
   const { postId } = useParams();
   const dispatch = useDispatch();
   useEffect(() => {
      if (commentIdDelete) {
         handleDeleteComment(commentIdDelete);
      }
   }, [commentIdDelete]);
   const showPopconfirm = () => {
      setOpen(true);
   };
   const handleCancel = () => {
      setOpen(false);
   };
   const handleDeleteComment = async commentId => {
      setConfirmLoading(true);
      try {
         const { data } = await commentService.deleteComment(commentId);
         if (data?.code === 200) {
            dispatch(getDetailPostStart(postId));
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
      setOpen(false);
      setConfirmLoading(true);
   };
   return (
      <div className="relative">
         <div className="absolute h-[2px] w-[30px] bg-[#ccc] top-[25px] left-[-35px] z-0 rounded-r-full"></div>
         <div className="flex gap-3 items-start mt-3">
            <Avatar
               className="w-[50px] h-[50px]"
               url={user?.avatar}
               role={user?.role === 'Admin' ? 'Admin' : user?.isDoctor ? 'Doctor' : 'Member'}
            />
            <div className="flex-1">
               <div className="bg-[#eee] rounded-lg py-2 px-3">
                  <h4 className="mb-0 font-bold">
                     {user?.fullName || 'Anonymouse'}{' '}
                     {user?.id === post?.user?.id ? <EditFilled className="text-[#0099ff]" /> : ''}
                  </h4>
                  <p className="mb-0 font-[500]">
                     <span className={`font-bold ${parent && parent.user.id != user.id ? 'mr-2' : ''}`}>
                        {parent && parent.user.id !== user.id ? `@${parent.user?.fullName || 'Anonymouse'}` : ''}
                     </span>
                     {content}
                  </p>
               </div>
               <div className="flex justify-between text-[12px] font-[500] ml-2">
                  <div className="flex gap-3">
                     {/* <span>Like</span> */}
                     {userLogin?.id !== user.id && (
                        <span
                           onClick={() => {
                              setShowInput(true);
                              setParentId(id);
                              setNameParent(`@${user?.fullName || 'Anonymouse'}`);
                           }}
                        >
                           Reply
                        </span>
                     )}
                     {userLogin?.id === user.id && (
                        <Popconfirm
                           title="Are you sure you want to delete?"
                           open={open}
                           onConfirm={() => setCommentIdDelete(id)}
                           okButtonProps={{ loading: confirmLoading }}
                           onCancel={handleCancel}
                        >
                           <span onClick={showPopconfirm}>delete</span>
                        </Popconfirm>
                     )}
                     <span>{getTimeElapsed(created_at)}</span>
                  </div>
               </div>
            </div>
         </div>
      </div>
   );
}
