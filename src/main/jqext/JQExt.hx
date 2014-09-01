package jqext;

import jQuery.*;
import haxe.ds.Option;
import jqext.JQUtil.*;

using hxopt.OptionOp;

class JQExt {

    /**
     * Returns None if jq.length == 0, otherwise reutrn Some(jq).
     */
    public static function jqOpt(jq: JQuery): Option<JQuery> {
        return if (jq.length == 0) None else Some(jq);
    }

    /**
     * Check inputs with a value.
     */
    public static function check(jq: JQuery, value: String): JQuery {
        jq.each(function(i, elem) {
            var el = new JQuery(elem);
            el.prop("checked", el.val() == value);
        });
        return jq;
    }

    public static function isChecked(checkbox: JQuery): Bool {
        return checkbox.is(':checked');
    }

    static function hasLength(selector: String, i: Int): JQuery -> Option<String> {
        return function(result) {
            return
                if (result.length != i)
                    Some('length of $selector is not $i but ${result.length}');
                else None;
        };
    }

    static function hasMoreThan(selector: String, i: Int): JQuery -> Option<String> {
        return function(result) {
            return
                if (result.length <= i)
                    Some('length of $selector should greater than $i, ${result.length}');
                else None;
        };
    }

    public static function findOne(jq: JQuery, selector: String): JQuery {
        return findAssert(jq, selector, hasLength(selector, 1));
    }

    public static function findMul(jq: JQuery, selector: String): JQuery {
        return findAssert(jq, selector, hasMoreThan(selector, 0));
    }

    public static function findOption(jq: JQuery, selector: String): Option<JQuery> {
        return jqOpt(jq.find(selector));
    }

    /**
     * Execute jq.find(selector) and check with function.
     * check returns None when no error found, returns Some(error message)
     * when error occured.
     */
    public static function findAssert(jq: JQuery, selector: String, check: JQuery -> Option<String>) {
        var result = jq.find(selector);
        check(result).foreach(function(err){ throw err; });
        return result;
    }

    static function inputSelector(name: String) {
        return "input[name='" + name + "']";
    }

    /**
     * Find <input> by name.
     */
    public static function findInput(jq: JQuery, name: String): JQuery {
        return jq.find(inputSelector(name));
    }

    public static function findInputOne(jq: JQuery, name: String): JQuery {
        var selector = inputSelector(name);
        return findAssert(jq, selector, hasLength(selector, 1));
    }

    public static function findInputMul(jq: JQuery, name: String): JQuery {
        var selector = inputSelector(name);
        return findAssert(jq, selector, hasMoreThan(selector, 0));
    }

    /**
     * Override submit event of <form> to send by ajax POST.
     */
    public static function ajaxfyForm(jqForm: JQuery, disableButtons=true, f: JqXHR -> Void) {
        jqForm.submit(function(ev) {
            f(formAjaxSend(disableButtons)(ev));
        });
    }


    public static function selected(jq: JQuery, b: Bool = true): JQuery {
        return jq.prop('selected', true);
    }

    public static function enable(jq: JQuery, b: Bool = true): JQuery {
        return disable(jq, !b);
    }

    public static function disable(jq: JQuery, b: Bool = true): JQuery {
        // From Bootstrap document, <A> is disabled by '.disabled' class.
        // http://getbootstrap.com/css/#buttons-disabled
        //
        // Other elements are disabled by a disabled property.
        //
        // This function handles both for all elements.
        if (b) jq.addClass(DISABLED) else jq.removeClass(DISABLED);
        jq.prop(DISABLED, b);
        return jq;
    }
    static inline var DISABLED = 'disabled';

    public static function enableButtons(jq: JQuery, enabled: Bool = true) {
        var btns = jq.find('button,input[type="submit"]');
        enable(btns, enabled);
    }

    /**
     * Similar to JQuery.map().
     * It returns an Array instead of JQuery object.
     */
    public static function jqMap<A>(jq: JQuery, f: Int -> js.html.Node -> A): Array<A> {
        var result: Array<A> = [];
        jq.each(function(i, el) {
            result.push(f(i, el));
        });
        return result;
    }

    public static function foreach<A>(jq: JQuery, f: JQuery -> A) {
        jq.each(function(i, el) {
            f(new JQuery(el));
        });
    }

    /**
     * highlight elements.
     * It creates <div> over the elements.
     * It cann't be clicked until the fadeOut is finished.
     *
     * ref. http://stackoverflow.com/a/13106698/339515
     */
    public static function highlight(jq: JQuery) {
        foreach(jq, function(el) {
            var div = new JQuery("<div/>");
            div.width(el.outerWidth())
                .height(el.outerHeight())
                .css({
                    "position": "absolute",
                        "left": el.offset().left,
                        "top": el.offset().top,
                        "background-color": "#ffff99",
                        "opacity": ".7",
                        "z-index": "9999999"
                }).appendTo('body')
                .fadeOut(1000, function () { div.remove(); });
        });
    }

    /**
     * Toggle CSS class on collapsing/uncollapsing.
     */
    public static function toggleClassOnCollapse(
        jq: JQuery,
        jqTarget: JQuery,
        closedClass: String = "glyphicon-chevron-down",
        openedClass: String = "glyphicon-chevron-up"
    ) {
        jq.on('show.bs.collapse', function(ev) {
            jqTarget
                .removeClass(closedClass)
                .addClass(openedClass);
        })
        .on('hide.bs.collapse', function(ev) {
            jqTarget
                .removeClass(openedClass)
                .addClass(closedClass);
        });
        return jq;
    }
}
