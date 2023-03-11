import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useSearchParams } from 'react-router-dom';
import { selectUsersFound, setUserFoundSuccess } from '../app/features/auth/authSlice';
import DoctorItem from '../components/DoctorItem';
import SearchDoctor from '../components/SearchDoctor';
import authService from '../services/authService';
export default function FindDoctor() {
   const [searchParams] = useSearchParams();
   const specialty = searchParams.get('specialty');
   const address = searchParams.get('address');
   const dispatch = useDispatch();
   const users = useSelector(selectUsersFound);

   useEffect(() => {
      async function getUsers() {
         try {
            const { data } = await authService.getUserByAddressAndSpecialty({
               specialtyId: specialty,
               address
            });
            dispatch(setUserFoundSuccess(data.result));
         } catch (error) {
            console.error(error);
         }
      }
      getUsers();
   }, [specialty, address, dispatch]);

   return (
      <div className="container !my-[40px]">
         <SearchDoctor></SearchDoctor>
         <div className="bg-[#FFFFFF] p-3 rounded-md">
            {users.length === 0 && <h2 className="mb-0 font-bold text-center">No doctors found</h2>}
            {users.map(item => (
               <DoctorItem data={item} key={item.id} />
            ))}
         </div>
      </div>
   );
}
