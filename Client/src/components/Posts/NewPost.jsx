import { FormOutlined, LoadingOutlined, StopOutlined } from '@ant-design/icons';
import { Editor } from '@tinymce/tinymce-react';
import { Spin } from 'antd';
import React, { useRef, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import { createPostStart, selectPostLoading } from '../../app/features/post/postSlice';

export default function NewPost({ topicId }) {
   const contentRef = useRef(null);
   const dispatch = useDispatch();
   const [showInput, setShowInput] = useState(false);
   const [title, setTitle] = useState('');
   const userLogin = useSelector(selectUserAuth);
   const loading = useSelector(selectPostLoading);

   const handleSubmit = e => {
      e.preventDefault();
      dispatch(
         createPostStart({
            topicId: topicId,
            title: title,
            image: '',
            content: contentRef.current?.getContent()
         })
      );
   };
   return (
      <form onSubmit={handleSubmit}>
         <div className="flex shadow-sm	text-[16px] pl-5 items-center gap-3" onClick={() => setShowInput(true)}>
            <img src={userLogin?.avatar} alt="" className="w-[40px] h-[40px] rounded-full" />
            <div className="bg-[#ebebeb] flex flex-1">
               <div className="flex items-center px-5">Title</div>
               <input
                  type="text"
                  placeholder="Title Post"
                  className="flex-1 outline-none border-none px-3 py-3 bg-[#f8f5f5]"
                  defaultValue={title}
                  onChange={e => setTitle(e.target.value)}
               />
            </div>
         </div>
         {showInput && (
            <div className="p-3">
               <Editor
                  onInit={(evt, editor) => (contentRef.current = editor)}
                  apiKey="nqbiutl3i83bkdoklqoybhc2v3c6wyy9kyj5nx24n96puhel"
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
                  <button
                     className="border-none px-3 py-2 rounded-md bg-[#009962] text-white cursor-pointer"
                     disabled={loading}
                  >
                     {loading ? (
                        <>
                           <Spin indicator={<LoadingOutlined style={{ fontSize: 24 }} spin className="text-white" />} />{' '}
                           Creating...
                        </>
                     ) : (
                        <>
                           <FormOutlined /> Create New Post
                        </>
                     )}
                  </button>
                  <button
                     className="border-none px-3 py-2 rounded-md bg-[#009962] text-white"
                     onClick={() => setShowInput(false)}
                     type="submit"
                  >
                     <StopOutlined />
                  </button>
               </div>
            </div>
         )}
      </form>
   );
}
