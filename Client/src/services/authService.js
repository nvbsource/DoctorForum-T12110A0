import axiosInstance from './AxiosInstance';

async function login({ username, password }) {
   let body = {
      username,
      password
   };
   return await axiosInstance.post('/User/login', body);
}
async function create(data) {
   return await axiosInstance.post('/User/create', data);
}
async function saveProfile(data) {
   const { positionId, firstName, lastName, gender, location, phoneNumber, description } = data;
   const body = {
      positionId,
      firstName,
      lastName,
      gender,
      location,
      phoneNumber,
      description
   };
   return await axiosInstance.put('/User/update', body);
}
async function changePassword(data) {
   const { passwordOld, passwordNew, confirmPasswordNew } = data;
   const body = {
      passwordOld,
      passwordNew,
      confirmPasswordNew
   };
   return await axiosInstance.post('/User/changePassword', body);
}
async function getEmailReceiverRequest(data) {
   return await axiosInstance.get('/EmailReceivedRequest');
}
async function addEmailReceiverRequest(data) {
   const { email, status } = data;
   const body = {
      email,
      status
   };
   return await axiosInstance.post('/EmailReceivedRequest', body);
}
async function updateEmailReceiverRequest(data) {
   const { id, email, status } = data;
   const body = {
      email,
      status
   };
   return await axiosInstance.put(`/EmailReceivedRequest/${id}`, body);
}
async function deleteEmailReceiverRequest(id) {
   return await axiosInstance.delete(`/EmailReceivedRequest/${id}`);
}
async function getProfile() {
   return await axiosInstance.get('/User/profile');
}
async function getStatistics() {
   return await axiosInstance.get('/User/statistics');
}
async function getProfileById(userId) {
   return await axiosInstance.get(`/User/profile/${userId}`);
}
async function getUserByAddressAndSpecialty({ address, specialtyId }) {
   return await axiosInstance.post('/User/findDoctor', { address, specialtyId });
}
const authService = {
   login,
   create,
   getProfile,
   saveProfile,
   changePassword,
   addEmailReceiverRequest,
   getEmailReceiverRequest,
   getProfileById,
   updateEmailReceiverRequest,
   deleteEmailReceiverRequest,
   getUserByAddressAndSpecialty,
   getStatistics
};
export default authService;
