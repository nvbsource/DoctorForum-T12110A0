import { CheckCircleOutlined, DatabaseOutlined, PhoneOutlined } from '@ant-design/icons';
import { Link } from 'react-router-dom';
import { printDistance } from '../utils/function';
import Avatar from './Avatar';
export default function DoctorItem({ data }) {
   return (
      <div className="w-full border-[1px] border-solid border-[#eee] shadow-sm mb-5 rounded-md">
         <div className="flex items-center px-2 py-2">
            <div className="flex items-center border-l-[1px] border-l-[#cccc] border-l-solid">
               <span className="text-[20px] mr-3 font-[600]">{data?.fullName || 'Anonymouse'}</span>
               <CheckCircleOutlined className="text-[#00bdbd] text-[25px]" />
            </div>
            {data?.distance && <span className="ml-3">Distance {printDistance(data?.distance)}</span>}
         </div>
         <div className="w-full h-[1px] bg-[#eee]"></div>
         <div className="flex pl-2 gap-x-5 min-h-[120px] items-center">
            <Avatar
               className="basis-[92px] h-[92px]"
               url={data?.avatar}
               role={data?.role === 'Admin' ? 'Admin' : data?.isDoctor ? 'Doctor' : 'Member'}
            />
            <div className="flex flex-col gap-y-[5px] pb-[15px] basis-[300px]">
               <span className="text-[12px] text-[#364343] uppercase">Main Location</span>
               <span className="text-[12px] font-light text-[#465259]">{data?.location?.streetAddress}</span>
            </div>
            <div className="flex flex-col gap-y-[5px] pb-[15px] flex-1">
               <span className="text-[12px] text-[#364343] uppercase">SUMMARY</span>
               <span className="text-[12px] font-light text-[#465259]  leading-[16px]">{data?.description}</span>
            </div>
         </div>
         <div className="w-full h-[1px] bg-[#eee]"></div>
         <div className="p-[15px] flex justify-between">
            <div className="flex justify-center items-center text-[18px] hover:text-[#27bcbb] cursor-pointer transition-all">
               <PhoneOutlined className="mr-2" />
               <span>{data?.phoneNumber || 'Anonymouse'}</span>
            </div>
            <div className="flex gap-x-3">
               <Link to={`/profile/${data?.id}`} className="text-inherit">
                  <button className="px-[20px] py-[10px] font-bold cursor-pointer flex justify-center items-center bg-[#ffffff] hover:bg-[black] hover:text-[#ffffff] border-[1px] rounded border-solid border-[#eee]">
                     <DatabaseOutlined className="mr-[8px]" />
                     View Profile
                  </button>
               </Link>
               <Link to={`/messages/${data?.id}`} className="text-inherit">
                  <button className="px-[20px] py-[10px] font-bold cursor-pointer flex justify-center items-center bg-[#ffffff] hover:bg-[black] hover:text-[#ffffff] border-[1px] rounded border-solid border-[#eee]">
                     <PhoneOutlined className="mr-[8px]" />
                     Send Message
                  </button>
               </Link>
            </div>
         </div>
      </div>
   );
}
