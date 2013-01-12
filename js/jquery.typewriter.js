
(function($) {
  var Typewriter;
  Typewriter = (function() {

    function Typewriter(i, el, settings) {
      var blink, hidden,
        _this = this;
      this.settings = settings;
      this.$el = $(el);
      this.text = this.settings.text || this.$el.text();
      this.$el.data('orig-text', this.text);
      this.text = this.$el.data('orig-text');
      this.$el.text('');
      this.letters = this.text.split('');
      if (this.settings.caret.visible) {
        this.caret = $("<span class='typewriter-caret-" + i + "'>|</span>").appendTo(this.$el);
        this.caret.appendTo(this.$el);
        if (this.settings.caret.blink) {
          hidden = false;
          blink = setInterval((function() {
            if (hidden) {
              _this.caret.css('opacity', 1);
              return hidden = false;
            } else {
              _this.caret.css('opacity', 0);
              return hidden = true;
            }
          }), this.settings.caret.interval);
        }
      }
    }

    Typewriter.prototype.type = function() {
      var i, typeLetter,
        _this = this;
      i = 0;
      return typeLetter = setInterval((function() {
        var last_typed;
        if (i < _this.letters.length) {
          _this.$el.append(_this.letters[i]);
          if (_this.settings.caret.visible) _this.caret.appendTo(_this.$el);
          last_typed = _this.letters[i];
          _this.settings.onLetter.call(_this, last_typed);
          return ++i;
        } else {
          clearInterval(typeLetter);
          _this.settings.onComplete.call(_this, _this.$el);
          return $(window).trigger('typingComplete', _this.$el);
        }
      }), this.settings.interval);
    };

    return Typewriter;

  })();
  return $.fn.extend({
    typewriter: function(option) {
      var settings;
      settings = {
        interval: 80,
        text: void 0,
        auto: true,
        caret: {
          visible: true,
          blink: true,
          interval: 500
        },
        onLetter: function(letter) {},
        onComplete: function($el) {}
      };
      return this.each(function(i, el) {
        var data, options;
        data = $(el).data('typewriter');
        options = $.extend({}, settings, $(el).data(), typeof option === "object" && option);
        if (!data) {
          $(el).data("typewriter", (data = new Typewriter(i, el, options)));
        }
        if (typeof option === "string") {
          return data[option]();
        } else {
          if (options.auto) return data.type();
        }
      });
    }
  });
})(jQuery);
