import { toast } from 'react-toastify';
import axiosInstance from './AxiosInstance';

async function getTopics() {
   return await axiosInstance.get('/Topic');
}
async function getTopicsOfParent(parentId) {
   return await axiosInstance.get(`/Topic/getTopicOfParent/${parentId}`);
}

const topicService = {
   getTopics,
   getTopicsOfParent
};
export default topicService;
