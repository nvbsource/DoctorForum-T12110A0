import axiosInstance from './AxiosInstance';

async function getSpecialties() {
   return await axiosInstance.get('/Specialty');
}
async function createSpecialtyDoctor({ specialtyId, educational }) {
   return await axiosInstance.post('/SpecialtyDoctor', { specialtyId, educational });
}
async function deleteSpecialtyDoctor(id) {
   return await axiosInstance.delete(`/SpecialtyDoctor/${id}`);
}
async function updateSpecialtyDoctor(id, educational) {
   return await axiosInstance.put(`/SpecialtyDoctor/${id}`, { educational });
}
async function getSpecialtiesDoctor() {
   return await axiosInstance.get('/SpecialtyDoctor');
}

const specialtyService = {
   getSpecialties,
   createSpecialtyDoctor,
   getSpecialtiesDoctor,
   deleteSpecialtyDoctor,
   updateSpecialtyDoctor
};
export default specialtyService;
