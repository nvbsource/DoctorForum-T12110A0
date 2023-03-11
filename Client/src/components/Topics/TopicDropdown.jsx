import { CaretDownOutlined, CaretUpOutlined } from '@ant-design/icons';
import React, { useEffect, useRef, useState } from 'react';
import TopicDropdownItem from './TopicDropdownItem';

export default function TopicDropdown({ data, parentFirst }) {
   const { title, description, icon, subTopics } = data || {};
   const [showDropdownItem, setShowDropdownItem] = useState(true);
   const toggleRef = useRef(null);
   const [props, setProps] = useState({});
   const [numImagesLoaded, setNumImagesLoaded] = useState(0);

   const handleShowHideDropdownItem = () => setShowDropdownItem(state => !state);

   useEffect(() => {
      const height = showDropdownItem ? toggleRef.current.scrollHeight : 0;
      setProps(prev => ({ ...prev, style: { height } }));
   }, [showDropdownItem, numImagesLoaded, subTopics]);

   const handleImageLoad = () => {
      setNumImagesLoaded(prev => prev + 1);
   };

   return (
      <div className="mb-5">
         <div className="bg-[#009962] p-3 flex justify-between items-center border-b-[#E4E4E4] border-[3px] border-solid border-t-0 border-l-0 border-r-0 topic-parent">
            <h3 className="font-bold mb-0 text-white">{title}</h3>
            {showDropdownItem ? (
               <CaretDownOutlined className="text-xl leading-none text-white" onClick={handleShowHideDropdownItem} />
            ) : (
               <CaretUpOutlined className="text-xl leading-none text-white" onClick={handleShowHideDropdownItem} />
            )}
         </div>
         <div
            className={`flex flex-col border-b-[1px] topic-dropdown-item bg-white ${showDropdownItem ? 'show' : ''}`}
            {...props}
            ref={toggleRef}
         >
            {subTopics?.map(item => (
               <TopicDropdownItem
                  data={item}
                  key={item.id}
                  onLoad={handleImageLoad}
                  topicId={item.id}
                  topicFirstParent={parentFirst}
               />
            ))}
         </div>
      </div>
   );
}
