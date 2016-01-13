(function($) { 
    
	// 初始化打印预览
	$.fn.printPreview = function() {
		this.each(function() {
			$(this).bind('click', function(e) {
			    e.preventDefault();//该方法将通知 Web 浏览器不要执行与事件关联的默认动作
			    if (!$('#print-modal').length) {
			        $.printPreview.loadPrintPreview();
			    }
			});
		});
		return this;
	};
    
    // Private functions
    var mask, size, print_modal, print_controls;
    $.printPreview = {
        loadPrintPreview: function() {
            // 声明 DOM 对象
			//print_modal:打印预览的模板
            print_modal = $('<div id="print-modal"></div>');
            print_controls = $('<div id="print-modal-controls">' + 
                                    '<a href="#" class="print" title="Print page">Print page</a>' +
                                    '<a href="#" class="close" title="Close print preview">Close</a>').hide();
            var print_frame = $('<iframe id="print-modal-content" scrolling="no" border="0" frameborder="0" name="print-frame" />');

            // Raise print preview window from the dead, zooooooombies
            print_modal
                .hide()
                .append(print_controls)
                .append(print_frame)
                .appendTo('body');

            // The frame lives
            for (var i=0; i < window.frames.length; i++) {
                if (window.frames[i].name == "print-frame") {    
                    var print_frame_ref = window.frames[i].document;
                    break;
                }
            }
            print_frame_ref.open();
            print_frame_ref.write('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' +
                '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang=" zh-cn" lang=" zh-cn">' + 
                '<head></head><body></body>' +
                '</html>');
            print_frame_ref.close();
            
            // 拿到内容和应用样式表
            var $iframe_head = $('head link[media*=print], head link[media=all]').clone(),
                $iframe_body = $('body > *:not(#print-modal):not(script)').clone();
            $iframe_head.each(function() {
                $(this).attr('media', 'all');
            });
            if (!$.browser.msie && !($.browser.version < 7) ) {
                $('head', print_frame_ref).append($iframe_head);
                $('body', print_frame_ref).append($iframe_body);
            }
            else {
                $('body > *:not(#print-modal):not(script)').clone().each(function() {
                    $('body', print_frame_ref).append(this.outerHTML);
                });
                $('head link[media*=print], head link[media=all]').each(function() {
                    $('head', print_frame_ref).append($(this).clone().attr('media', 'all')[0].outerHTML);
                });
            }
            $('#print-modal-content').height(1123);
            // 禁用所有的链接
            $('a', print_frame_ref).bind('click.printPreview', function(e) {
                e.preventDefault();
            });
            
            // Introduce print styles
            $('head').append('<style type="text/css">' +
                '@media print {' +
                    '/* -- Print Preview --*/' +
                    '#print-modal-mask,' +
                    '#print-modal {' +
                        'display: none !important;' +
                    '}' +
                '}' +
                '</style>'
            );

            // 加载 mask 变量
            $.printPreview.loadMask();

            // 禁用滚动
            $('body').css({overflowY: 'hidden', height: '100%'});
            $('img', print_frame_ref).load(function() {
                print_frame.height($('body', print_frame.contents())[0].scrollHeight);
            });
            
            // Position modal            
            starting_position = $(window).height() + $(window).scrollTop();
            var css = {
                    top:         starting_position,
                    height:      '100%',
                    overflowY:   'auto',
                    zIndex:      10000,
                    display:     'block'
                }
            print_modal
                .css(css)
                .animate({ top: $(window).scrollTop()}, 400, 'linear', function() {
                    print_controls.fadeIn('slow').focus();
                });
            print_frame.height($('body', print_frame.contents())[0].scrollHeight);
            
            // Bind closure 
            $('a', print_controls).bind('click', function(e) {
                e.preventDefault();
                if ($(this).hasClass('print')) { window.print(); }
                else { $.printPreview.distroyPrintPreview(); }
            });
    	},
    	
    	distroyPrintPreview: function() {
    	    print_controls.fadeOut(100);
    	    print_modal.animate({ top: $(window).scrollTop() - $(window).height(), opacity: 1}, 400, 'linear', function(){
    	        print_modal.remove();
    	        $('body').css({overflowY: 'auto', height: 'auto'});
    	    });
    	    mask.fadeOut('slow', function()  {
    			mask.remove();
    		});				

    		$(document).unbind("keydown.printPreview.mask");
    		mask.unbind("click.printPreview.mask");
    		$(window).unbind("resize.printPreview.mask");
	    },
	    
    	/* -- Mask Functions --*/
	    loadMask: function() {
	        size = $.printPreview.sizeUpMask();
            mask = $('<div id="print-modal-mask" />').appendTo($('body'));
    	    mask.css({			
    			position:           'absolute', 
    			top:                0, 
    			left:               0,
    			width:              size[0],
    			height:             size[1],
    			display:            'none',
    			opacity:            0,					 		
    			zIndex:             9999,
    			backgroundColor:    '#000'//打印预览的阴影背景
    		});
	
    		mask.css({display: 'block'}).fadeTo('400', 0.75);//淡出效果
    		
            $(window).bind("resize..printPreview.mask", function() {
				$.printPreview.updateMaskSize();
			});
			
			mask.bind("click.printPreview.mask", function(e)  {
				$.printPreview.distroyPrintPreview();
			});
			
			$(document).bind("keydown.printPreview.mask", function(e) {
			    if (e.keyCode == 27) {  $.printPreview.distroyPrintPreview(); }
			});
        },
    
        sizeUpMask: function() {
            if ($.browser.msie) {
            	// if there are no scrollbars then use window.height
            	var d = $(document).height(), w = $(window).height();
            	return [
            		window.innerWidth || 						// ie7+
            		document.documentElement.clientWidth || 	// ie6  
            		document.body.clientWidth, 					// ie6 quirks mode
            		d - w < 20 ? w : d
            	];
            } else { return [$(document).width(), $(document).height()]; }
        },
    
        updateMaskSize: function() {
    		var size = $.printPreview.sizeUpMask();
    		mask.css({width: size[0], height: size[1]});
        }
    }
})(jQuery);