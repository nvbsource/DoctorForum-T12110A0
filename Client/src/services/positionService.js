import axiosInstance from './AxiosInstance';

async function getPositions() {
   return await axiosInstance.get('/Position');
}

const positionService = {
   getPositions
};
export default positionService;
