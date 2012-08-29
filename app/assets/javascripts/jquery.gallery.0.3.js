/**
 * jQuery Gallery Plugin
 *   http://code.google.com/p/jquery-gallery-plugin/
 *
 * Copyright (c) 2009 Yusuke Horie
 *
 * Released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Since  : 0.1.0 - 08/02/2009
 * Version: 0.3.0 - 08/25/2009
 */
(function(jQuery) {

  /** private properties **/

  var _inc = 0;

  /** public methods **/

  jQuery.fn.gallery = function (options) {
    var options = jQuery.extend({}, jQuery.fn.gallery.defaults, options);

    return this.each(function(i, e) {
      var
        $this = jQuery(e),
        id = options.prefix + _inc,
        i = 0,
        n = 0,
        limit = 5,
        step = 1,
        duration = Math.ceil(options.interval*0.3),
        timeId = null;

      var height;
      if (!options.height) {
        if (!parseInt($this.css('height'), 10)) {
          height = '450px';
        } else {
          height = $this.height();
        }
      } else {
        height = options.height;
      }

      var
        width = (!options.width) ? $this.width(): options.width,
        paddingTop = parseInt($this.css('padding-top'), 10),
        paddingBottom = parseInt($this.css('padding-bottom'), 10),
        pheight = parseInt(height, 10),
        contentHeight = pheight - options.thumbHeight + paddingTop,
        o = $this.offset(),
        barWidth = jQuery(window).width() - o.left;

      // thumbnail bar
      var barTop = (options.barPosition == 'top') ? paddingTop: contentHeight;

      if (options.toggleBar) {
        if (options.barPosition == 'top') {
          $this.hover(
            function() {
              $('#thumbnails_' + id).animate({top: paddingTop}, {queue: false, duration: 300});
            },
            function() {
              $('#thumbnails_' + id).animate({top: barTop}, {queue: false, duration: 300});
            });
          barTop = (options.thumbHeight + paddingTop) * (-1);
        } else {
          var outerHeight = pheight + paddingTop + paddingBottom;
          $this.hover(
            function() {
              $('#thumbnails_' + id).animate({top: contentHeight}, {queue: false, duration: 300});
            },
            function() {
              $('#thumbnails_' + id).animate({top: outerHeight}, {queue: false, duration: 300});
            });
          barTop = outerHeight;
        }
      }

      $this
        .css({
          width: width,
          height: height,
          zIndex: options.zIndex
        })
        .prepend('<div id="' + id + '"></div>')
        .find('ul')
          .attr('id', 'thumbnails_' + id)
          .addClass(options.barClass)
          .css({
            top: barTop,
            height: options.thumbHeight + 'px',
            width: barWidth + 'px',
            zIndex: options.zIndex + 2000
          })
          .find('li')
            .css({
              width: options.thumbWidth + 'px',
              height: options.thumbHeight + 'px'
            })
            .each(function (index) {
              jQuery.data(this, 'index', index);
            })
            .click(function (event) {
              event.preventDefault();
              if (options.slideshow) clearInterval(timeId);

              if ($.isFunction(options.onSelect))
                options.onSelect.apply(this, [event]);

              var $e = this;
              bar.find('li').each(function (index, e) {
                if (e == $e) {
                  step = index;
                  return false;
                }
              });

              i = jQuery.data(this, 'index');

              // pre load
              for (var j=i; j<i+limit; j++) {
                var o = pictures.eq(j);
                if (o.length > 0 && typeof o.data('loaded') == 'undefined') {
                  preLoad(o.attr('href'));
                  o.data('loaded', true);
                }
              }

              display();
              if (options.slideshow)
                timeId = setInterval(display, options.interval);
            });

      if (options.showOverlay) {
        var
          itop = pheight*(1-options.ratio) + paddingTop,
          ileft = $this.css('padding-left'),
          iheight = (pheight*options.ratio) + paddingTop;

        // screen
        $('<div />')
          .addClass(options.screenClass)
          .css({
            opacity: 0.5,
            top: itop,
            left: 0,
            height: iheight,
            width: $this.outerWidth(),
            zIndex: options.zIndex + 1000
          })
          .insertAfter('#' + id);

        $('<div />')
          .addClass(options.infoClass)
          .html('<div id="gtitle_' + id + '" class="' + options.titleClass + '" style="display:none;"></div>' +
            '<div id="gdesc_' + id + '" class="' + options.descClass + '" style="display:none;"></div>')
          .css({
            top: itop,
            left: 0,
            height: iheight,
            zIndex: options.zIndex + 1500
          })
          .insertAfter('#' + id);
      }

      // content container
      var c = jQuery('#' + id).css({
        position: 'relative',
        width: width,
        height: height,
        overflow: 'hidden'
      }).addClass(options.contentClass);

      var
        bar = $this.find('ul').show(),
        thumbnails = bar.find('img'),
        pictures = $this.find('a').bind('click.gallery', function (e) { e.preventDefault(); }),
        gtitle = $('#gtitle_' + id),
        gdesc = $('#gdesc_' + id),
        len =  thumbnails.length,
        w = $this.find('li:first').outerWidth(true);

      var display = function () {
        var t = thumbnails.eq(i);
        var pict = pictures.eq(i);
        var p = pict.attr('href');
        var pid = id + '_' + i;

        // pre load
        var next = pictures.eq(i+limit);
        if (next.length > 0 && typeof next.data('loaded') == 'undefined') {
          preLoad(next.attr('href'));
        }

        // delete previous picture
        c.find('img').animate({opacity: 0.0}, {
          queue: false,
          duration: duration,
          easing: 'linear',
          complete: function() { jQuery(this).remove(); }
        });

        // append new picture
        jQuery('<img />')
          .attr('src', p)
          .attr('id', pid)
          .css({
            position: 'absolute',
            top: 0,
            left: 0,
            opacity: 0.0
          })
          .bind('click.gallery', function (event) {
            options.onClick.apply(this, [event, pict.get()]);
          })
          .appendTo('#' + id)
          .animate({opacity: 1.0}, {
            queue: false,
            duration: duration,
            easing: 'linear'
          })
          .load(function () {
            pict.data('loaded', true);
          });

        var title = t.attr('title');
        var id_of_desc = pict.attr('rel');
        var desc = (id_of_desc && $('#' + id_of_desc).length > 0)
          ? $('#' + id_of_desc).html(): pict.attr('title');

        if (n != 0) {
          // title
          if (typeof title != 'undefined')
            gtitle.fadeOut(duration*0.3, function () {
              jQuery(this).html(title).show();
            });

          // description
          if (typeof desc != 'undefined')
            gdesc.fadeOut(duration*0.3, function () {
              jQuery(this).html(desc).show();
            });

          // scrolle
          bar.animate({left: w*(-1)*step}, {
            queue: false,
            duration: 300,
            easing: options.easing,
            complete: function () {
              var $t = jQuery(this).css({left: 0});
              var f = $t.find('li').slice(0, step);
              var indexes = f.map(function () {
                return jQuery.data(this, 'index');
              });
              var cln = f.clone(true).each(function (j) {
                jQuery.data(this, 'index', indexes[j]);
              }).hide().appendTo(this).fadeIn(duration);
              f.remove();
              step = 1;
            }
          });
        } else {
          // title & description
          if (typeof title != 'undefined') gtitle.html(title).show();
          if (typeof desc != 'undefined') gdesc.html(desc).show();
        }

        options.onChange.apply($this.get(), [i, pict.get()]);

        if (i < (len-1)) {
          i++;
        } else {
          i = 0;
        }
        n++;
      };

      // pre load
      for (var j=0; j<limit; j++) {
        var o = pictures.eq(j);
        if (o.length > 0) {
          preLoad(o.attr('href'));
          o.data('loaded', true);
        }
      }

      display();
      if (options.slideshow)
        timeId = setInterval(display, options.interval);

      _inc++;
    });
  };

  jQuery.fn.gallery.defaults = {
    width: null,
    height: null,
    thumbWidth: 55,
    thumbHeight: 55,
    zIndex: 1000,
    interval: 4500,
    prefix: 'gallery_',
    easing: 'linear',
    ratio: 0.35,
    slideshow: true,
    toggleBar: true,
    showOverlay: true,
    barPosition: null,
    barClass: 'galleryBar',
    contentClass: 'galleryContent',
    infoClass: 'galleryInfo',
    screenClass: 'galleryScreen',
    titleClass: 'galleryTitle',
    descClass: 'galleryDesc',
    onClick: function () { return; },
    onSelect: function () { return; },
    onChange: function () { return; }
  };

  /** private methods **/

  var preLoad = function (url) {
    jQuery('<img />').attr('src', url);
  };

})(jQuery);