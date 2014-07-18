
  $(function(){

      // Animated popup
      $('.animated_popup').popup({
        show        : function($popup, $back){

          var plugin = this,
            center = plugin.getCenter();

          $popup
            .css({
              top     : - $popup.children().outerHeight(),
              left    : center.left,
              opacity : 1
            })
            .animate({top : center.top}, 500, 'easeOutBack', function(){
              // Call the open callback
              plugin.o.afterOpen.call(plugin);
            });

        }
      });

        $('.animated_popup-register').popup({
        show        : function($popup, $back){

          var plugin = this,
            center = plugin.getCenter();

          $popup
            .css({
              top     : - $popup.children().outerHeight(),
              left    : center.left,
              opacity : 1
            })
            .animate({top : center.top}, 500, 'easeOutBack', function(){
              // Call the open callback
              plugin.o.afterOpen.call(plugin);
            });

        }
      });

      // Different preloader
      $('.preloader_popup').popup({
        preloaderContent  : '<img src="assets/images/preloader.gif" class="preloader">'
      });

      // Error popup
      $('.error_popup').popup({
        error   : function(content, type){

          // Just call open again, it'll replace the content
          this.open('<h1>ERROR!</h1><p>Content "'+content+'" of type "'+type+'" could not be loaded.</p>', 'html');
        }
      });

    });

    $.extend($.easing, {
      easeOutBack: function (x, t, b, c, d, s) {
        if (s == undefined) s = 1.70158;
        return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
      },
      easeInBack: function (x, t, b, c, d, s) {
        if (s == undefined) s = 1.70158;
        return c*(t/=d)*t*((s+1)*t - s) + b;
      }
    });


    $.extend($.easing, {
      easeOutBack: function (x, t, b, c, d, s) {
        if (s == undefined) s = 1.70158;
        return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
      },
      easeInBack: function (x, t, b, c, d, s) {
        if (s == undefined) s = 1.70158;
        return c*(t/=d)*t*((s+1)*t - s) + b;
      }
    });
