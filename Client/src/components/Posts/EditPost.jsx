import { FormOutlined } from '@ant-design/icons';
import { Editor } from '@tinymce/tinymce-react';
import React, { useEffect, useRef, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import { editPostStart, getDetailPostStart, selectPostDetail } from '../../app/features/post/postSlice';

export default function EditPost() {
   const contentRef = useRef(null);
   const dispatch = useDispatch();
   const { postId } = useParams();
   const [title, setTitle] = useState('');
   const userLogin = useSelector(selectUserAuth);
   const post = useSelector(selectPostDetail);

   useEffect(() => {
      dispatch(getDetailPostStart(postId));
   }, [dispatch, postId]);

   useEffect(() => {
      setTitle(post?.title);
   }, [post]);

   const handleSubmit = e => {
      e.preventDefault();
      dispatch(
         editPostStart({
            postId: postId,
            title: title,
            content: contentRef.current?.getContent()
         })
      );
   };
   return (
      <div className="container !my-[40px] bg-white p-3 rounded-md">
         <h1 className="font-bold">Edit Post</h1>
         <form onSubmit={handleSubmit}>
            <div className="flex shadow-sm	text-[16px] pl-5 items-center gap-3">
               <img src={userLogin?.avatar} alt="" className="w-[40px] h-[40px] rounded-full" />
               <div className="bg-[#ebebeb] flex flex-1">
                  <div className="flex items-center px-5">Title</div>
                  <input
                     type="text"
                     placeholder="Tiêu đề bài viết"
                     className="flex-1 outline-none border-none px-3 py-3 bg-[#f8f5f5]"
                     value={title}
                     onChange={e => setTitle(e.target.value)}
                  />
               </div>
            </div>
            <div className="p-3">
               <Editor
                  onInit={(evt, editor) => (contentRef.current = editor)}
                  apiKey="nqbiutl3i83bkdoklqoybhc2v3c6wyy9kyj5nx24n96puhel"
                  initialValue={post?.content}
                  init={{
                     height: 500,
                     menubar: false,
                     plugins: [
                        'mentions advlist autolink lists link image charmap print preview anchor',
                        'searchreplace visualblocks code fullscreen',
                        'insertdatetime media paste code help wordcount'
                     ],
                     toolbar:
                        'undo redo | formatselect | ' +
                        'bold italic backcolor | alignleft aligncenter ' +
                        'alignright alignjustify | bullist numlist outdent indent | ' +
                        'removeformat | emoticons| help',
                     content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }',
                     emoticons_append: {
                        custom_mind_explode: {
                           keywords: ['brain', 'mind', 'explode', 'blown'],
                           char: '🤯'
                        }
                     }
                  }}
               />
               <div className="flex justify-end gap-3 mt-3">
                  <button className="border-none px-3 py-2 rounded-md bg-[#009962] text-white">
                     <FormOutlined /> Chỉnh sửa chủ đề
                  </button>
               </div>
            </div>
         </form>
      </div>
   );
}
