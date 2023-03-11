import { Input, TreeSelect } from 'antd';
import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import specialtyService from '../services/specialtyService';
import { objectToQueryString } from '../utils/function';

export default function SearchDoctor() {
   const navigate = useNavigate();
   const [searchParams] = useSearchParams();
   const [specialty, setSpecialty] = useState(searchParams.get('specialty'));
   const [specialties, setSpecialties] = useState([]);
   const [specialtiesSelect, setSpecialtiesSelect] = useState([]);
   useEffect(() => {
      const getSpecialties = async () => {
         try {
            const { data } = await specialtyService.getSpecialties();
            setSpecialties(data.result);
         } catch (error) {
            console.log(error);
         }
      };
      getSpecialties();
   }, []);
   useEffect(() => {
      setSpecialtiesSelect(
         specialties.map(item => ({
            value: item.id,
            title: item.name,
            children: item.subSpecialties?.map(subItem => ({ value: subItem.id, title: subItem.name }))
         }))
      );
   }, [specialties]);
   const [address, setAddress] = useState(searchParams.get('address'));

   const handleSubmit = async e => {
      e.preventDefault();
      navigate(`/findDoctor?${objectToQueryString({ specialty, address })}`);
   };

   return (
      <div className="bg-white search-banner p-3 mb-5 rounded">
         <h1 className="text-center font-bold text-[#ffffff]">Find Doctors using the Most Important Criteria: Yours</h1>
         <div className="max-w-[80%] mx-auto">
            <form className="flex justify-center gap-x-6 items-stretch " onSubmit={handleSubmit}>
               <div className="flex flex-col px-3 py-1 bg-[#ffffff] search-input rounded basis-[400px]">
                  <span className="text-[#00bdbd] text-xs font-semibold">Specialty</span>
                  <TreeSelect
                     showSearch
                     style={{ width: '100%' }}
                     value={specialty}
                     dropdownStyle={{ maxHeight: 400, overflow: 'auto' }}
                     placeholder="Please select"
                     allowClear
                     onChange={value => setSpecialty(value)}
                     treeData={specialtiesSelect}
                     className="select-customize"
                  />
               </div>

               <div className="flex flex-col px-3 py-1 bg-[#ffffff] search-input rounded basis-[300px]">
                  <span className="text-[#00bdbd] text-xs font-semibold">Location</span>
                  <Input
                     className="border-none px-0 "
                     placeholder="City/State or Zip"
                     onChange={e => setAddress(e.target.value)}
                     value={address}
                  />
               </div>
               <button className="bg-[#f3b634] border-none outline-none rounded-full py-2 px-5 text-[20px] font-bold text-white">
                  Find Doctor
               </button>
            </form>
         </div>
      </div>
   );
}
