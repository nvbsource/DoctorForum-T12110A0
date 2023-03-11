import { Popover, Badge, Avatar } from 'antd';
import { NotificationOutlined } from '@ant-design/icons';
import Paragraph from 'antd/lib/typography/Paragraph';

export default function Notifications({ visible, handleVisibleChange }) {
   const notifications = (
      <div>
         <h4 className="font-bold">Notifications</h4>
         <ul className="list-none mb-0 max-w-[400px]">
            <li className="flex gap-2 mb-3">
               <img
                  src="https://diendanit.net/data/avatars/m/23/23743.jpg?1675574184"
                  alt=""
                  className="w-[50px] h-[50px] rounded-full"
               />
               <div className="">
                  <div className="flex items-center gap-2">
                     <div className="font-[500] mb-0">
                        <Paragraph ellipsis={{ rows: 2 }} className="!mb-0">
                           <strong>Phạm Minh Nhật</strong> commented on the post
                           <strong>Rules of the Doctor Forum Page</strong>.
                        </Paragraph>
                     </div>
                  </div>
                  <div className="flex items-center gap-2">
                     <span className="font-bold text-[12px] text-primary">42 minutes ago</span>
                  </div>
               </div>
            </li>
            <li className="flex gap-2">
               <img
                  src="https://diendanit.net/data/avatars/m/23/23743.jpg?1675574184"
                  alt=""
                  className="w-[50px] h-[50px] rounded-full"
               />
               <div className="">
                  <div className="flex items-center gap-2">
                     <div className="font-[500] mb-0">
                        <Paragraph ellipsis={{ rows: 2 }} className="!mb-0">
                           <strong>Phạm Minh Nhật</strong> commented on the post
                           <strong>Rules of the Doctor Forum Page</strong>.
                        </Paragraph>
                     </div>
                  </div>
                  <div className="flex items-center gap-2">
                     <span className="font-bold text-[12px] text-primary">42 minutes ago</span>
                  </div>
               </div>
            </li>
         </ul>
      </div>
   );

   return (
      <Popover content={notifications} trigger="click" open={visible} onOpenChange={handleVisibleChange}>
         <Badge count={1} className="cursor-pointer">
            <Avatar
               shape="circle"
               icon={<NotificationOutlined />}
               className="cursor-pointer bg-[#009962] h-[40px] w-[40px] flex items-center justify-center"
            />
         </Badge>
      </Popover>
   );
}
