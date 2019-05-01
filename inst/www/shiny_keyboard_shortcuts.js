  var keyboardShortcutInputBinding = new Shiny.InputBinding();
  $.extend(keyboardShortcutInputBinding, {
    find: function find(scope) {
      return $(scope).find(".shiny-keyboard-shortcut");
    },
    getValue: function getValue(el) {
      return $(el).data('val') || 0;
    },
    setValue: function setValue(el, value) {
      $(el).data('val', value);
    },
//    getType: function getType(el) {
//      return 'shiny.keyboard.shortcut';
//    },
    subscribe: function subscribe(el, callback) {
      $(document).on('keydown.shiny-keyboard-shortcut', function(e) {
        let $el = $(el);
        let data = $el.data();
        let current_key = String.fromCharCode(e.which).toLowerCase();
        let target_key = data.key.toLowerCase();
        if(current_key === target_key) {
          let ctrlKey = data.ctrl === 'TRUE';
          let altKey = data.alt === 'TRUE';
          let shiftKey = data.shift === 'TRUE';
          if(e.altKey === altKey && e.ctrlKey === ctrlKey && e.shiftKey === shiftKey) {
            let val = data.val || 0;
            $el.data('val', val + 1);
            callback();
          }
        }

      });
    },
    getState: function getState(el) {
      return { value: this.getValue(el) };
    }
  });
  Shiny.inputBindings.register(keyboardShortcutInputBinding, 'shiny.keyboardShortcutInput');
