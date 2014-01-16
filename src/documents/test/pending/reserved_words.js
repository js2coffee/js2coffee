//TODO: any coffee keywords can't be used like 'off' and 'on'
// so throw exception or convert into raw js mode? 
var off = 2;
window = 2;
(function (window, undefined) { console.log(off); })(window);
