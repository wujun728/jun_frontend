(function () {

  'use strict';

  window.createCropperImage = function (attrs) {
    var image = new Image();

    if (!$.isPlainObject(attrs)) {
      attrs = {};
    }

    if (!attrs.src) {
      attrs.src = '../assets/img/picture.jpg';
    }

    $('<div>').addClass('container').append($(image).attr(attrs)).appendTo(document.body);

    return image;
  };

})();
