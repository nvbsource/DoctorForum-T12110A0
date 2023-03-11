import axiosInstance from './AxiosInstance';
async function createComment({ content, postId, parentId }) {
   const body = { content, postId, parentId };
   return await axiosInstance.post(`/Comment`, body);
}
async function deleteComment(commentId) {
   return await axiosInstance.delete(`/Comment/${commentId}`);
}

const commentService = {
   createComment,
   deleteComment
};
export default commentService;
