import { FacebookFilled, LinkedinFilled, TwitterSquareFilled } from '@ant-design/icons';
import { images } from '../assets';
export default function Footer() {
   return (
      <div className="bg-white">
         <div className="w-full h-[1px] bg-[#e7dfdf]"></div>
         <div className="container">
            <div className="flex justify-around text-[#828e8e] py-[40px]">
               <span>© 2023 Doctor.com</span>
               <div className="w-[150px] h-[20px]">
                  <img src={images.googlePartner} className="w-full h-full object-cover" />
               </div>
               <span>Privacy </span>
               <span>Terms of Service </span>
               <span>Do Not Sell my Personal Information</span>
               <span>Accessibility Statement</span>
            </div>
         </div>
      </div>
   );
}
