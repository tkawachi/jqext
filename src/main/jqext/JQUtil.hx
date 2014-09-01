package jqext;

import jQuery.*;

using jqext.JQExt;

class JQUtil {
    public static function formAjaxSend(disableButtons: Bool): Dynamic -> JqXHR {
        return function (ev: Dynamic) {
            ev.preventDefault();
            var form = new JQuery(ev.currentTarget);
            var settings = {
                url: form.attr('action'),
                type: form.attr('method'),
                data: form.serialize()
            }
            if (disableButtons) {
                settings = JQueryStatic.extend(settings, {
                    beforeSend: function(xhr, settings) {
                        form.enableButtons(false);
                    },
                    complete: function(xhr, textStatus) {
                        form.enableButtons(true);
                    }
                });
            }
            return JQueryStatic.ajax(settings);
        };
    }
}
