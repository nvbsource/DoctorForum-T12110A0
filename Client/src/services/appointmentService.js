import axiosInstance from './AxiosInstance';

async function getAppointmentResons() {
   return await axiosInstance.get('/AppointmentReason');
}
async function getAppointment() {
   return await axiosInstance.get('/Appointment');
}
async function getAppointmentResonsByUser(userId) {
   return await axiosInstance.get(`/AppointmentReason/${userId}`);
}
async function createAppointment(data) {
   return await axiosInstance.post('/Appointment', data);
}
async function createAppointmentResons(data) {
   return await axiosInstance.post('/AppointmentReason', data);
}
async function updateAppointmentReson({ id, ...data }) {
   return await axiosInstance.put(`/AppointmentReason/${id}`, data);
}
async function deleteAppointmentReson(id) {
   return await axiosInstance.delete(`/AppointmentReason/${id}`);
}
async function updateStateAppointment(data) {
   return await axiosInstance.post('/User/update-state', data);
}

const appointmentResonService = {
   getAppointmentResons,
   createAppointmentResons,
   updateAppointmentReson,
   deleteAppointmentReson,
   updateStateAppointment,
   createAppointment,
   getAppointmentResonsByUser,
   getAppointment
};
export default appointmentResonService;
