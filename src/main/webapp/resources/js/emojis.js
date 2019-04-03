(function ($) {
    var defaults = {
        data: [{
            "typ": "twitter",
            "nm": "人物",
            "items": [
            ]
        }],
        path: 'emoji/',
        category: ['twitter'],
        showbar: true,
        trigger: 'click',
        insertAfter: function () {
        }
    };
    /*var replaceDiv=function(obj,options){
        if(options.divId==""|| options.divId==null)
            return;
        var items=options.data[0].items;
        for(var i=0;i<items.length;i++){
            var t="["+items[i].name+"]";
            var newStr=options.path+items[i].src;
            $(options.divId).html(replaceStr($(options.divId).html(),t,newStr));
        }


    }
    var replaceStr=function(str,oldStr,newStr){
        str = str.replace(oldStr,'<img src="'+newStr+'" width=24 height=24/>');
        return str;
    }*/
    var render_nav = function (obj, options) {
        $(obj).append('<div class="emoji-inner"><ul class="emoji-nav"></ul><div class="emoji-content"></div></div>');
        if (!options.showbar) {
            $(obj).addClass('no-bar');
            return
        }
        ;
        var navs = _.reduce(options.category, function (items, item) {
            var citem = _.find(options.data, function (da) {
                return da.typ == item
            });
            return items + '<li data-name="' + item + '">' + citem.nm + '</li>'
        }, '');
        $(obj).find('.emoji-nav').empty().append(navs)
    };
    var render_emoji = function (obj, options, typ) {
        var list = _.find(options.data, function (item) {
            return item.typ == typ
        });
        if (!list) {
            list = options.data[0]
        }
        ;
        var imgs = _.reduce(list.items, function (items, item) {
            if (item) {
                return items + '<img title="' + item.name + '" src="' + options.path + item.src + '" data-name="' + item.name + '" data-src="' + options.path + item.src + '">'
            } else {
                return items
            }
        }, '');
        $(obj).find('.emoji-content').empty().append(imgs);
        $(obj).find('.emoji-nav li[data-name=' + list.typ + ']').addClass('on').siblings().removeClass("on");
    };
    var switchitem = function (obj, options) {
        $(obj).on(options.trigger, '.emoji-nav > li', function () {
            render_emoji(obj, options, $(this).attr('data-name'));
            return false
        });
        $(obj).on('click', '.emoji-content > img', function () {
            options.insertAfter({name: $(this).attr('data-name'), src: $(this).attr('data-src')})
        })
    };
    var togglew = function (obj, option) {
        $(obj).on('click', '.emoji-tbtn', function () {
            $(obj).find('.emoji-inner').toggle();
            return false
        });
        $(document).click(function () {
            $(obj).find('.emoji-inner').hide()
        })
    };
    $.fn.emoji = function (opt) {
        var options = $.extend({}, defaults, opt || {});
        //replaceDiv(this,options);
        this.hide = function () {
            $(this).find('.emoji-inner').hide()
        };
        this.show = function () {
            $(this).find('.emoji-inner').show()
        };
        return this.each(function () {
            if (!$(this).find('.val').length > 0) {
                return false
            }
            ;
            render_nav(this, options);
            render_emoji(this, options);
            switchitem(this, options);
            togglew(this, options)
        })
    };
    $.fn.insertContent = function (myValue, t) {
        var $t = $(this)[0];
        if (document.selection) {
            this.focus();
            var sel = document.selection.createRange();
            sel.text = myValue;
            this.focus();
            sel.moveStart('character', -l);
            var wee = sel.text.length;
            if (arguments.length == 2) {
                var l = $t.value.length;
                sel.moveEnd("character", wee + t);
                t <= 0 ? sel.moveStart("character", wee - 2 * t - myValue.length) : sel.moveStart("character", wee - t - myValue.length);
                sel.select()
            }
        } else if ($t.selectionStart || $t.selectionStart == '0') {
            var startPos = $t.selectionStart;
            var endPos = $t.selectionEnd;
            var scrollTop = $t.scrollTop;
            $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
            this.focus();
            $t.selectionStart = startPos + myValue.length;
            $t.selectionEnd = startPos + myValue.length;
            $t.scrollTop = scrollTop;
            if (arguments.length == 2) {
                $t.setSelectionRange(startPos - t, $t.selectionEnd + t);
                this.focus()
            }
        } else {
            this.value += myValue;
            this.focus()
        }
    }
})(jQuery);
$(function () {
    var em1 = $('#emoji1').emoji({
        insertAfter: function (item) {
            $('#area1').insertContent('[:' + item.name + ':]')
        }
    });
    var em2 = $('#emoji2').emoji({
        trigger: 'mouseover', insertAfter: function (item) {
            $('#area2').html($('#area2').html() + "<img src='" + item.src + "' class='emoji-img' />")
        }
    });
    var em4 = $('#emoji4').emoji({category: ['EmojiCategory-People', 'EmojiCategory-Nature']});
    var em3 = $('#emoji3').emoji();
    $('#open').click(function () {
        em3.show();
        return false
    });
    $('#close').click(function () {
        em3.hide();
        return false
    })
})