/**
 * jQuery EasyUI 1.3.2
 * 
 *翻译;qq 1364386878
 */
(function ($) {
    //执行提交操作，该选项的参数是一个对象
    function _submit(target, options) {
        options = options || {};
        var param = {};
        if (options.onSubmit) {
            if (options.onSubmit.call(target, param) == false) {
                return;
            }
        }
        var form = $(target);
        if (options.url) {
            form.attr("action", options.url);
        }
        var iframeid = "easyui_frame_" + (new Date().getTime());
        var frame = $("<iframe id=" + iframeid + " name=" + iframeid + "></iframe>").attr("src",
            window.ActiveXObject ? "javascript:false" : "about:blank").css(
            { position: "absolute", top: -1000, left: -1000 });
        var t = form.attr("target"),
            a = form.attr("action");
        form.attr("target", iframeid);
        var _8 = $();
        try {
            frame.appendTo("body");
            frame.bind("load", cb);
            for (var n in param) {
                var f = $("<input type=\"hidden\" name=\"" + n + "\">").val(param[n]).appendTo(form);
                _8 = _8.add(f);
            }
            form[0].submit();
        }
        finally {
            form.attr("action", a);
            t ? form.attr("target", t) : form.removeAttr("target");
            _8.remove();
        }
        var checkCount = 10;
        function cb() {
            frame.unbind();
            var body = $("#" + iframeid).contents().find("body");
            var data = body.html();
            if (data == "") {
                if (--checkCount) {
                    setTimeout(cb, 100);
                    return;
                }
                return;
            }
            var ta = body.find(">textarea");
            if (ta.length) {
                data = ta.val();
            } else {
                var pre = body.find(">pre");
                if (pre.length) {
                    data = pre.html();
                }
            }
            if (options.success) {
                options.success(data);
            }
            setTimeout(function () {
                frame.unbind();
                frame.remove();
            }, 100);
        };
    };
    function _load123(target, data) {
            if (!$.data(target, "form")) {
                $.data(target, "form", {
                    options: $.extend({},
                        $.fn.thform.defaults)
                });
            }
            var options = $.data(target, "form").options;
            var root = options.root;
            if (typeof data == "string") {
                var param = {};
                if (options.onBeforeLoad.call(target, param) == false) {
                    return;
                }
                $.ajax({
                    url: data,
                    data: param,
                    dataType: "json",
                    success: function (data) {
                        _load2(data);
                    },
                    error: function () {
                        options.onLoadError.apply(target, arguments);
                    }
                });
            } else {
                _load2(data);
            }
            function _load2(data) {
            	var form = $(target);
            	var rootdata = data[root];
            	form.find("input[name], textarea").each(function(i,ele){
            		var name = ele.name;
            		var keyarr = name.split(".");
            		var val;
            		if(keyarr.length==1){
            			val = rootdata[name];
            		}else if(keyarr.length>1){
            			var tempdata = rootdata;
            			for(var i=0;i<keyarr.length;i++){
            				tempdata = tempdata[keyarr[i]];
            			}
            			val = tempdata;
            		}
                  var rr = setChecked(name, val);
                  if (!rr.length) {
                      var f = form.find("input[numberboxName=\"" + name + "\"]");
                      if (f.length) {
                          f.numberbox("setValue", val);
                      } else {
                          $("input[name=\"" + name + "\"]", form).val(val);
                          $("textarea[name=\"" + name + "\"]", form).val(val);
                          $("select[name=\"" + name + "\"]", form).val(val);
                      }
                  }
                  setValue(name, val);
            	});
//            	for(var key in rootdata){
//            		var keyarr = key.split(".");
//            		var val;
//            		if(keyarr.length==1){
//            			val = rootdata[key];
//            		}else if(keyarr.length>1){
//            			var tempdata = rootdata;
//            			for(var i=0;i<keyarr.length;i++){
//            				tempdata = tempdata[keyarr[i]];
//            			}
//            			val = tempdata;
//            		}
//       			 	var rr = setChecked(key, val);
//                    if (!rr.length) {
//                        var f = form.find("input[numberboxName=\"" + key + "\"]");
//                        if (f.length) {
//                            f.numberbox("setValue", val);
//                        } else {
//                            $("input[name=\"" + key + "\"]", form).val(val);
//                            $("textarea[name=\"" + key + "\"]", form).val(val);
//                            $("select[name=\"" + key + "\"]", form).val(val);
//                        }
//                    }
//                    setValue(name, val);
//            	}
//                var form = $(target);
//                for (var name in data) {
//                    var val = data[name];
//                    var rr = setChecked(name, val);
//                    if (!rr.length) {
//                        var f = form.find("input[numberboxName=\"" + name + "\"]");
//                        if (f.length) {
//                            f.numberbox("setValue", val);
//                        } else {
//                            $("input[name=\"" + name + "\"]", form).val(val);
//                            $("textarea[name=\"" + name + "\"]", form).val(val);
//                            $("select[name=\"" + name + "\"]", form).val(val);
//                        }
//                    }
//                    setValue(name, val);
//                }
            	//alert(JSON.stringify(data));
            	var options = $.data(target, "form").options;
            	options.beforeupdatedata = data;
                options.onLoadSuccess.call(target, data);
                _validate(target);
             //   jsondata = data;
            };
            //设置选中
            function setChecked(name, val) {
                var form = $(target);
                var rr = $("input[name=\"" + name + "\"][type=radio], input[name=\"" + name + "\"][type=checkbox]", form);
                $.fn.prop ? rr.prop("checked", false) : rr.attr("checked", false);
                rr.each(function () {
                    var f = $(this);
                    if (f.val() == String(val)) {
                        $.fn.prop ? f.prop("checked", true) : f.attr("checked", true);
                    }
                });
                return rr;
            };
            //设置值
            function setValue(name, val) {
                var form = $(target);
                var types = ["combobox", "combotree", "combogrid", "datetimebox", "datebox", "combo"];
                var c = form.find("[comboName=\"" + name + "\"]");
                if (c.length) {
                    for (var i = 0; i < types.length; i++) {
                        var type = types[i];
                        if (c.hasClass(type + "-f")) {
                            if (c[type]("options").multiple) {
                                c[type]("setValues", val);
                            } else {
                                c[type]("setValue", val);
                            }
                            return;
                        }
                    }
                }
            };
        };
        function _getRoot(target){
        	  var root = $.data(target, "form").options.root;
        	  return root;
        };
    //读取记录填充到表单中。数据参数可以是一个字符串或一个对象类型，如果是字符串则作为远程URL，否则作为本地记录
    function _load(target, data) {
        if (!$.data(target, "form")) {
            $.data(target, "form", {
                options: $.extend({},
                    $.fn.thform.defaults)
            });
        }
        var options = $.data(target, "form").options;
        if (typeof data == "string") {
            var param = {};
            if (options.onBeforeLoad.call(target, param) == false) {
                return;
            }
            $.ajax({
                url: data,
                data: param,
                dataType: "json",
                success: function (data) {
                    _load2(data);
                },
                error: function () {
                    options.onLoadError.apply(target, arguments);
                }
            });
        } else {
            _load2(data);
        }
        function _load2(data) {
        	
            var form = $(target);
            for (var name in data) {
                var val = data[name];
                var rr = setChecked(name, val);
                if (!rr.length) {
                    var f = form.find("input[numberboxName=\"" + name + "\"]");
                    if (f.length) {
                        f.numberbox("setValue", val);
                    } else {
                        $("input[name=\"" + name + "\"]", form).val(val);
                        $("textarea[name=\"" + name + "\"]", form).val(val);
                        $("select[name=\"" + name + "\"]", form).val(val);
                    }
                }
                setValue(name, val);
            }
            options.onLoadSuccess.call(target, data);
            _validate(target);
        };
        //设置选中
        function setChecked(name, val) {
            var form = $(target);
            var rr = $("input[name=\"" + name + "\"][type=radio], input[name=\"" + name + "\"][type=checkbox]", form);
            $.fn.prop ? rr.prop("checked", false) : rr.attr("checked", false);
            rr.each(function () {
                var f = $(this);
                if (f.val() == String(val)) {
                    $.fn.prop ? f.prop("checked", true) : f.attr("checked", true);
                }
            });
            return rr;
        };
        //设置值
        function setValue(name, val) {
            var form = $(target);
            var types = ["combobox", "combotree", "combogrid", "datetimebox", "datebox", "combo"];
            var c = form.find("[comboName=\"" + name + "\"]");
            if (c.length) {
                for (var i = 0; i < types.length; i++) {
                    var type = types[i];
                    if (c.hasClass(type + "-f")) {
                        if (c[type]("options").multiple) {
                            c[type]("setValues", val);
                        } else {
                            c[type]("setValue", val);
                        }
                        return;
                    }
                }
            }
        };
    };
    //清除表单数据
    function _clear(target) {
        $("input,select,textarea", target).each(function () {
            var t = this.type,
                tag = this.tagName.toLowerCase();
            if (t == "text" || t == "hidden" || t == "password" || tag == "textarea") {
                this.value = "";
            } else {
                if (t == "file") {
                    var file = $(this);
                    file.after(file.clone().val(""));
                    file.remove();
                } else {
                    if (t == "checkbox" || t == "radio") {
                        this.checked = false;
                    } else {
                        if (tag == "select") {
                            this.selectedIndex = -1;
                        }
                    }
                }
            }
        });
        if ($.fn.combo) {
       
            $(".combo-f", target).combo("clear");
        }
        if ($.fn.combobox) {
            $(".combobox-f", target).combobox("clear");
        }
        if ($.fn.combotree) {
            $(".combotree-f", target).combotree("clear");
        }
        if ($.fn.combogrid) {
            $(".combogrid-f", target).combogrid("clear");
        }
        _validate(target);
    };
    //重置表单数据
    function _reset(target) {
        target.reset();
        var t = $(target);

       
        if ($.fn.combo) {
            t.find(".combo-f").combo("reset");
        }
        if ($.fn.combobox) {
            t.find(".combobox-f").combobox("reset");
        }
        if ($.fn.combotree) {
            t.find(".combotree-f").combotree("reset");
        }
        if ($.fn.combogrid) {
            t.find(".combogrid-f").combogrid("reset");
        }
        if ($.fn.spinner) {
            t.find(".spinner-f").spinner("reset");
        }
        if ($.fn.timespinner) {
            t.find(".timespinner-f").timespinner("reset");
        }
        if ($.fn.numberbox) {
            t.find(".numberbox-f").numberbox("reset");
        }
        if ($.fn.numberspinner) {
            t.find(".numberspinner-f").numberspinner("reset");
        }
        _validate(target);
    };
    //设置表单
    function setForm(target) {
        var options = $.data(target, "form").options;
        var form = $(target);
        form.unbind(".form").bind("submit.form", function () {
            setTimeout(function () {
                _submit(target, options);
            }, 0);
            return false;
        });
    };
    //做表单字段验证，当所有字段都有效的时候返回true。该方法使用validatebox(验证框)插件
    function _validate(target) {
        if ($.fn.validatebox) {
            var t = $(target);
            t.find(".validatebox-text:not(:disabled)").validatebox("validate");
            var valid = t.find(".validatebox-invalid");
            valid.filter(":not(:disabled):first").focus();
            return valid.length == 0;
        }
        return true;
    };
    function _getUpdateBeforeData(target){
    	 var options = $.data(target, "form").options;
         var beforeupdatedata = options.beforeupdatedata;
    	return beforeupdatedata;
    };
    //实例化form
    $.fn.thform = function (options, param) {
        if (typeof options == "string") {
            return $.fn.thform.methods[options](this, param);
        }
        options = options || {};
        return this.each(function () {
            if (!$.data(this, "form")) {
                $.data(this, "form", {
                    options: $.extend({},
                        $.fn.thform.defaults, options)
                });
            }
            setForm(this);
        });
    };
    //方法
    $.fn.thform.methods = {
        //执行提交操作，该选项的参数是一个对象
        submit: function (jq, param) {
            return jq.each(function () {
                _submit(this, $.extend({}, $.fn.thform.defaults, param || {}));
            });
        },
        //读取记录填充到表单中。数据参数可以是一个字符串或一个对象类型，如果是字符串则作为远程URL，否则作为本地记录
        load: function (jq, data) {
            return jq.each(function () {
                _load(this, data);
            });
        },
        getRoot: function (jq) {
            return  _getRoot(jq[0]);
            
        },
        load2: function (jq, data) {
            return jq.each(function () {
                _load123(this, data);
            });
        },
        //清除表单数据
        clear: function (jq) {
            return jq.each(function () {
                _clear(this);
            });
        },
        //重置表单数据
        reset: function (jq) {
            return jq.each(function () {
                _reset(this);
            });
        },
        //表单字段验证，当所有字段都有效的时候返回true。该方法使用validatebox(验证框)插件
        validate: function (jq) {
            return _validate(jq[0]);
        },
        getUpdateBeforeData: function (jq) {
            return _getUpdateBeforeData(jq[0]);
        }
    };

    //form默认属性+事件
    $.fn.thform.defaults = {
    	beforeupdatedata : null,
    	root: null,
        url: null,//提交表单动作的URL地址
        //在提交之前触发，返回false可以终止提交
        onSubmit: function (param) {
            return $(this).form("validate");
        },
        //在表单提交成功以后触发
        success: function (data) {
        },
        //在请求加载数据之前触发。返回false可以停止该动作
        onBeforeLoad: function (_30) {
        },
        //在表单数据加载完成后触发
        onLoadSuccess: function (_31) {
        },
        //在表单数据加载出现错误的时候触发
        onLoadError: function () {
        }
    };
})(jQuery);

