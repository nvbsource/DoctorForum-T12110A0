import { DeleteOutlined, FormOutlined } from '@ant-design/icons';
import { Button, Popconfirm } from 'antd';
import React, { useEffect, useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { Link } from 'react-router-dom';
import { getProfileStart, selectUserAuth } from '../../app/features/auth/authSlice';
import { formatDateTime } from '../../utils/function';
import postService from '../../services/postService';
import { toast } from 'react-toastify';
import Avatar from '../Avatar';

export default function PostInProfile({ data, user }) {
   const { title, content, created_at, id } = data;
   const dispatch = useDispatch();
   const [open, setOpen] = useState(false);
   const [confirmLoading, setConfirmLoading] = useState(false);
   const [idPostDelete, setIdPostDelete] = useState(null);
   const userLogin = useSelector(selectUserAuth);
   useEffect(() => {
      if (idPostDelete) {
         handleDeletePost(idPostDelete);
      }
   }, [idPostDelete]);
   const handleDeletePost = async postId => {
      setConfirmLoading(true);
      try {
         const { data } = await postService.deletePost(postId);
         if (data?.code === 200) {
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
      dispatch(getProfileStart(user?.id));
      setOpen(false);
      setConfirmLoading(false);
   };
   return (
      <div className="bg-white flex gap-3 p-3 rounded-xl mt-5">
         <div>
            <Avatar
               className="w-[50px] h-[50px]"
               url={user?.avatar}
               role={user?.role === 'Admin' ? 'Admin' : user?.isDoctor ? 'Doctor' : 'Member'}
            />
         </div>
         <div className="font-[500]">
            <h3 className="mb-0 font-[600] flex items-center gap-3">
               <Link to={`/posts/detail/${id}`} className="text-inherit">
                  {title}{' '}
               </Link>
               {user?.id === userLogin?.id && (
                  <div className="flex items-center gap-3">
                     <Link to={`/posts/edit/${id}`}>
                        <FormOutlined />
                     </Link>
                     <Popconfirm
                        title="Are you sure you want to delete?"
                        open={open}
                        onConfirm={() => setIdPostDelete(id)}
                        okButtonProps={{ loading: confirmLoading }}
                        onCancel={() => setOpen(false)}
                     >
                        <DeleteOutlined className="text-[red] cursor-pointer" onClick={() => setOpen(true)} />
                     </Popconfirm>
                  </div>
               )}
            </h3>
            <div className="max-h-[350px] overflow-auto" dangerouslySetInnerHTML={{ __html: content }}></div>
            <div className="flex items-center gap-1">
               <span>{user?.fullName || 'Anonymouse'}</span>
               <div className="w-[2px] h-[2px] rounded-full bg-[#000000D9]"></div>
               <span>Date: {formatDateTime(created_at)}</span>
               <div className="w-[2px] h-[2px] rounded-full bg-[#000000D9]"></div>
               <span>Topic: {data?.topic?.title}</span>
            </div>
         </div>
      </div>
   );
}
