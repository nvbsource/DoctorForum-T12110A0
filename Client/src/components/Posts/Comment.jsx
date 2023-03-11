import { CheckCircleFilled, EditFilled } from '@ant-design/icons';
import { Popconfirm } from 'antd';
import moment from 'moment';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import { getDetailPostStart, selectPostDetail } from '../../app/features/post/postSlice';
import commentService from '../../services/commentService';
import { getTimeElapsed } from '../../utils/function';
import Avatar from '../Avatar';
import CommentChild from './CommentChild';

export default function Comment({ data }) {
   const { content, user, created_at, replyComments, id } = data;
   const [parentId, setParentId] = useState(id);
   const [commentIdDelete, setCommentIdDelete] = useState(null);
   const [nameParent, setNameParent] = useState(null);
   const post = useSelector(selectPostDetail);
   const [mapReplyComments, setMapReplyComments] = useState([]);
   const dispatch = useDispatch();
   const { postId } = useParams();
   const [showInput, setShowInput] = useState(false);
   const [comment, setComment] = useState('');
   const userLogin = useSelector(selectUserAuth);
   const [open, setOpen] = useState(false);
   const [confirmLoading, setConfirmLoading] = useState(false);
   const showPopconfirm = () => {
      setOpen(true);
   };
   const handleCancel = () => {
      setOpen(false);
   };
   useEffect(() => {
      setMapReplyComments(flatArray(replyComments, data));
   }, [replyComments]);

   useEffect(() => {
      if (commentIdDelete) {
         handleDeleteComment(commentIdDelete);
      }
   }, [commentIdDelete]);

   const handleSubmitComment = async e => {
      e.preventDefault();
      try {
         const { data } = await commentService.createComment({
            content: comment,
            postId,
            parentId: parentId ? parentId : null
         });
         if (data?.code === 200) {
            dispatch(getDetailPostStart(postId));
            setComment('');
            setNameParent(null);
            setParentId(id);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const flatArray = (replyComments, parent = null, result = []) => {
      for (const comment of replyComments) {
         const { replyComments } = comment;
         result.push({
            ...comment,
            parent: parent ? parent : null
         });
         flatArray(replyComments, comment, result);
      }

      return result.sort((a, b) => {
         const aDate = moment(a.created_at);
         const bDate = moment(b.created_at);

         if (aDate.isBefore(bDate)) {
            return -1;
         } else if (aDate.isAfter(bDate)) {
            return 1;
         } else {
            return 0;
         }
      });
   };
   const handleChangeComment = e => {
      console.log(e.target.value.length, comment?.length);
      setComment(e.target.value);
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
      <div className="flex gap-3 items-start relative">
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
               <p className="mb-0 font-[500]">{content}</p>
            </div>
            <div className="flex justify-between text-[12px] font-[500] ml-2">
               <div className="flex gap-3">
                  {/* <span>Like</span> */}
                  {/* {userLogin?.id !== user.id && ( */}
                  <span
                     onClick={() => {
                        setShowInput(true);
                        setParentId(id);
                        setNameParent(`@${user?.fullName || 'Anonymouse'}`);
                     }}
                  >
                     Reply
                  </span>
                  {/* )} */}
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
            <div className="absolute h-[calc(100%-102px)] w-[2px] bg-[#ccc] top-[50px] left-[25px] z-0"></div>
            {mapReplyComments.map(item => (
               <CommentChild
                  data={item}
                  key={item.id}
                  setShowInput={setShowInput}
                  setParentId={setParentId}
                  setNameParent={setNameParent}
                  setCommentIdDelete={setCommentIdDelete}
               />
            ))}
            {showInput && (
               <div className="my-3">
                  {nameParent && <span className="pl-[40px]">Tag: {nameParent}</span>}
                  <div className="flex items-center gap-3">
                     <img src={userLogin?.avatar} alt="" className="w-[30px] h-[30px] rounded-full" />
                     <form onSubmit={handleSubmitComment} className="w-full">
                        <input
                           type="text"
                           className="bg-[#eee] border-none outline-none px-3 py-2 w-full rounded-full"
                           placeholder="Write the answer"
                           value={comment}
                           onChange={handleChangeComment}
                        />
                     </form>
                  </div>
               </div>
            )}
         </div>
      </div>
   );
}
