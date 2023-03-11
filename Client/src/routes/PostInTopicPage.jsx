import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link, Outlet, useParams } from 'react-router-dom';
import { selectUserAuth } from '../app/features/auth/authSlice';
import { getPostsOfTopicStart, selectPostOfTopic } from '../app/features/post/postSlice';
import { getTopicsOfParentStart, selectAllTopicsOfParent } from '../app/features/topic/topicSlice';
import NewPost from '../components/Posts/NewPost';
import PostItem from '../components/Posts/PostItem';
const PostInTopicPage = () => {
   const dispatch = useDispatch();
   const { topicParentId } = useParams();
   const topics = useSelector(selectAllTopicsOfParent);
   const posts = useSelector(selectPostOfTopic);
   const userLogin = useSelector(selectUserAuth);
   const params = new URLSearchParams(window.location.search);
   const topicId = params.get('topicId');
   const [activeTopic, setActiveTopic] = useState();
   const isShowCreatePost = userLogin?.role === 'Admin' || (!activeTopic?.isAdmin && userLogin?.isDoctor);
   useEffect(() => {
      dispatch(getTopicsOfParentStart(topicParentId));
      window.scrollTo(0, 0);
   }, [dispatch]);

   useEffect(() => {
      dispatch(getPostsOfTopicStart(topicId));
   }, [topicId, dispatch]);
   useEffect(() => {
      const findTopicById = topics?.subTopics?.find(item => item.id === parseInt(topicId));
      setActiveTopic(findTopicById);
   }, [topics, topicId]);

   return (
      <div className="container !my-[40px] rounded-md grid grid-cols-4 bg-white overflow-hidden">
         <div className="col-span-1 border-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-b-0">
            <div className="bg-[#009962] p-3 flex justify-between items-center border-b-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-r-0 h-[71px]">
               <h3 className="font-bold mb-0 text-white">FORUM OPERATION CENTER</h3>
            </div>
            {topics.subTopics?.map(item => (
               <div
                  className={`p-3 flex gap-3 h-auto border-b-[#E4E4E4] border-[1px] border-solid border-t-0 border-l-0 border-r-0 ${
                     item.id === parseInt(topicId) ? 'bg-[#e6e6e8]' : ''
                  }`}
                  key={item.id}
               >
                  <img src={item.icon} className="max-w-[40px]" />
                  <div className="flex items-start">
                     <h4 className="font-bold mb-0">
                        <Link to={`/posts/${topicParentId}/?topicId=${item.id}`} className="link-no-color">
                           {item.title}
                        </Link>
                     </h4>
                     <span className="inline-block py-[2px] px-2 bg-[#3e5062] text-white rounded-md text-[10px] ml-2">
                        Mới
                     </span>
                  </div>
               </div>
            ))}
         </div>
         <div className="col-span-3">
            <div className="bg-[#009962] p-3 flex items-center h-[70px] gap-3">
               <img src={activeTopic?.icon} className="max-w-[40px]" alt=""></img>
               <h3 className="font-bold mb-0 text-white">{activeTopic?.title}</h3>
            </div>
            {isShowCreatePost && <NewPost topicId={topicId} />}

            {posts.map(item => (
               <PostItem data={item} key={item.id} />
            ))}
         </div>
      </div>
   );
};

export default PostInTopicPage;
