Date.prototype.customFormat = function (formatString) {
   var YYYY, YY, MMMM, MMM, MM, M, DDDD, DDD, DD, D, hhhh, hhh, hh, h, mm, m, ss, s, ampm, AMPM, dMod, th;
   YY = ((YYYY = this.getFullYear()) + '').slice(-2);
   MM = (M = this.getMonth() + 1) < 10 ? '0' + M : M;
   DD = (D = this.getDate()) < 10 ? '0' + D : D;
   th = D >= 10 && D <= 20 ? 'th' : (dMod = D % 10) == 1 ? 'st' : dMod == 2 ? 'nd' : dMod == 3 ? 'rd' : 'th';
   formatString = formatString
      .replace('#YYYY#', YYYY)
      .replace('#YY#', YY)
      .replace('#MMMM#', MMMM)
      .replace('#MM#', MM)
      .replace('#M#', M)
      .replace('#DDDD#', DDDD)
      .replace('#DD#', DD)
      .replace('#D#', D)
      .replace('#th#', th);
   h = hhh = this.getHours();
   //if (h == 0) h = 24;
   //if (h > 12) h -= 12;
   hh = h < 10 ? '0' + h : h;
   hhhh = hhh < 10 ? '0' + hhh : hhh;
   //AMPM = (ampm = hhh < 12 ? 'am' : 'pm').toUpperCase();
   AMPM = '';
   mm = (m = this.getMinutes()) < 10 ? '0' + m : m;
   ss = (s = this.getSeconds()) < 10 ? '0' + s : s;
   return formatString
      .replace('#hhhh#', hhhh)
      .replace('#hhh#', hhh)
      .replace('#hh#', hh)
      .replace('#h#', h)
      .replace('#mm#', mm)
      .replace('#m#', m)
      .replace('#ss#', ss)
      .replace('#s#', s);
   // .replace('#ampm#', ampm)
   // .replace('#AMPM#', AMPM);
};

function round(value, precision) {
   var multiplier = Math.pow(10, precision || 0);
   return Math.round(value * multiplier) / multiplier;
}
const readMoney = number => {
   if (number > 999999999) {
      var number_ = number / 1000000000;
      return round(number_, 2) + ' Tỷ';
   } else if (number > 999999) {
      var number_ = number / 1000000;
      return round(number_, 2) + ' Triệu';
   } else if (number > 999) {
      var number_ = number / 1000;
      return round(number_, 2) + ' nghìn';
   } else {
      var number_ = number / 1;
      return round(number_, 2) + 'đ';
   }
};

const validateEmail = email => {
   var re =
      /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
   return re.test(String(email).toLowerCase());
};

const priceFormat = (price, unit = 'đ') => {
   if (price == undefined) {
      return '';
   } else {
      let str = typeof price == 'string' ? price : price.toString();
      return str.replace(/\B(?=(\d{3})+(?!\d))/g, '.') + unit;
   }
};

const unPriceFormat = price => {
   try {
      if (!price) {
         return 0;
      }
      var data = price.replace(/\,/g, '');
      return data;
   } catch (error) {}
   return price;
};

const dateFormat = (miliseconds, formatString, isHour = true) => {
   if (miliseconds == undefined || miliseconds === 0) {
      return '';
   }
   let date = new Date(miliseconds);
   if (formatString) {
      return date.customFormat(formatString);
   }
   if (isHour) {
      return date.customFormat('#DD#/#MM#/#YYYY# #hh#:#mm#');
   }
   return date.customFormat('#DD#/#MM#/#YYYY#');
};

const preprocessNews = html => {
   const result = html.replace(/start/g, 'left').replace(/end/g, 'right');
   return result;
};

const times = [
   ['giây', 1],
   ['phút', 60],
   ['giờ', 3600],
   ['ngày', 86400],
   ['tuần', 604800],
   ['tháng', 2592000],
   ['năm', 31536000]
];

function timeAgo(miliseconds) {
   let NOW = new Date();
   var diff = Math.round((NOW - miliseconds) / 1000);
   for (var t = 0; t < times.length; t++) {
      if (diff < times[t][1]) {
         if (t == 0) {
            return 'Just now';
         } else {
            diff = Math.round(diff / times[t - 1][1]);
            return diff + ' ' + times[t - 1][0] + ' trước';
         }
      }
   }
}

function distanceFormat(distance) {
   if (distance > 1000) {
      var km = distance / 1000;
      return Math.round(km * 10) / 10 + 'km';
   }
   return Math.round(distance * 10) / 10 + 'm';
}

function queryParams(params) {
   return Object.keys(params)
      .map(k => encodeURIComponent(k) + '=' + encodeURIComponent(params[k]))
      .join('&');
}

function showMarkSearch(status = true) {
   const loaderContainer = document.getElementsByClassName('_maskSearch')[0];
   if (loaderContainer) {
      if (status) {
         loaderContainer.classList.remove('hidden');
         document.body.classList.add('_noselect');
      } else {
         loaderContainer.classList.add('hidden');
         document.body.classList.remove('_noselect');
      }
   }
}

function getMarkSearch() {
   const loaderContainer = document.getElementsByClassName('_maskSearch')[0];
   let show = true;
   loaderContainer.classList.forEach(item => {
      if (item == 'hidden') {
         show = false;
      }
   });
   return show;
}

function showModalSearch(status = true) {
   const loaderContainer = document.getElementsByClassName('ant-select')[0];
   if (loaderContainer) {
      if (status) {
         document.body.classList.add('ant-select-open');
      } else {
         document.body.classList.remove('ant-select-open');
      }
   }
}

function saveCookies(string) {
   var LastReportGenerated = 'Jul 11 2013',
      baseDomain = '.sphacy.vn',
      expireAfter = new Date();
   //setting up  cookie expire date after a week
   expireAfter.setDate(expireAfter.getDate() + 7);
   //now setup cookie
   console.log(
      "auth={'json':" +
         string +
         ", 'lastGenerated':" +
         LastReportGenerated +
         '}; domain=' +
         baseDomain +
         '; expires=' +
         expireAfter +
         '; path=/'
   );
   document.cookie = "auth={'json':" + string + '}; domain=' + baseDomain + '; expires=' + expireAfter + '; path=/';
}

export {
   validateEmail,
   priceFormat,
   unPriceFormat,
   dateFormat,
   preprocessNews,
   timeAgo,
   readMoney,
   distanceFormat,
   queryParams,
   showMarkSearch,
   showModalSearch,
   getMarkSearch,
   saveCookies
};
