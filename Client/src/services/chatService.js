import axiosInstance from './AxiosInstance';

async function getRoomsChat() {
   return await axiosInstance.get('/Chat');
}
async function getContentChat(receiverId) {
   return await axiosInstance.get(`/ContentChat?receiverId=${receiverId}`);
}
async function sendContentChat({ receiverId, content, parentId }) {
   const body = {
      receiverId,
      content,
      parentId
   };
   return await axiosInstance.post(`/ContentChat`, body);
}

const chatService = {
   getRoomsChat,
   getContentChat,
   sendContentChat
};
export default chatService;
