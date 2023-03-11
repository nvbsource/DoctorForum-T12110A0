import axiosInstance from './AxiosInstance';
async function createPost({ title, image, content, topicId }) {
   const body = { title, image, content, topicId };
   return await axiosInstance.post(`/Post`, body);
}
async function deletePost(id) {
   return await axiosInstance.delete(`/Post/${id}`);
}
async function updatePost({ title, image, content, postId }) {
   const body = { title, image, content, postId };
   return await axiosInstance.put(`/Post/${postId}`, body);
}
async function getNewPosts(perPage) {
   return await axiosInstance.get(`/Post/getNewsPost?perPage=${perPage}`);
}
async function getDetailPost(postId) {
   return await axiosInstance.get(`/Post/${postId}`);
}
async function getPostsOfTopic(topicId) {
   return await axiosInstance.get(`/Post/postOfTopic/${topicId}`);
}

const postService = {
   createPost,
   getNewPosts,
   getPostsOfTopic,
   getDetailPost,
   updatePost,
   deletePost
};
export default postService;
