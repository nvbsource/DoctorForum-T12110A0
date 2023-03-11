class images {
   constructor() {
      if (!images.instance) {
         images.instance = this;
      }
      return images.instance;
   }

   logo = require('./images/logo.png');
   doctorCreate = require('./images/doctor-information.jpg');
   googlePartner = require('./images/google-partner.png');
   doctor1 = require('./images/doctor1.jpeg');
}

const instance = new images();
export default instance;
