import React from 'react';
import { useSelector } from 'react-redux';
import { selectPostOfTopic } from '../../app/features/post/postSlice';
import PostItem from './PostItem';

export default function PostList() {
   const posts = useSelector(selectPostOfTopic);
   return (
      <div>
         {posts.map(item => (
            <PostItem data={item} key={item.id} />
         ))}
      </div>
   );
}
