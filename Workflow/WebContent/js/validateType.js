		 $.extend($.fn.validatebox.defaults.rules, {
			 
					number: {//验证输入是否为数字
			          validator: function (value, param) {
			            return /^[0-9]+.?[0-9]*$/.test(value);
			          },
			          message: '请输入数字'
			        },
			        
			        tel: {//验证电话号码
			            validator: function (value, param) {
			            	return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
			            },
			            message: '格式不正确,请使用下面格式:020-88888888'
			          },
			          
			          mobile : {// 验证手机号码 
			              validator : function(value) { 
			                  return /^(13|15|18|17)\d{9}$/i.test(value); 
			              }, 
			              message:'格式不正确,请以13,15,18,17开头'
			              },
			              
			          integer:{//验证输入是否为整数
			              validator:function(value,param){
			                return /^[+]?[1-9]\d*$/.test(value);
			              },
			              message: '请输入最小为1的整数'
			            },
			            
			            maxLength:{//验证输入内容最大长度
			                validator:function(value,param){
			                  return value.length<=200;
			                },
			                message:'最多200个字,请减少字数'
			              },
			              
			              inputrules: {//验证名称
			                  validator: function (value, param) {
			                    return /^[\u0391-\uFFE5\w]+$/.test(value);
			                  },
			                  message: '只允许汉字、英文字母、数字及下划线。'
			                },
			                
			                safepass: {//验证密码
			                    validator: function (value, param) {
			                        return safePassword(value);
			                    },
			                    message: '密码由字母和数字组成,至少6位'
			                },
			                
			              equalTo: {//验证输入内容是否一致,注意validType为"equalTo['#第一个输入框id']"
			                  validator: function (value, param) {
			                      return value == $(param[0]).val();
			                  },
			                  message: '两次输入的字符不一至'
			              },
			              
			              idcard: {//验证身份证号码
			                  validator: function (value, param) {
			                      return idCard(value);
			                  },
			                  message:'请输入正确的身份证号码'
			              },
			              
			              chs: {//验证输入是否为汉字
			                  validator: function (value, param) {
			                      return /^[\u0391-\uFFE5]+$/.test(value);
			                  },
			                  message: '请输入汉字'
			              },
			              
			              zip: {//邮政编码验证
			                  validator: function (value, param) {
			                      return /^[1-9]\d{5}$/.test(value);
			                  },
			                  message: '邮政编码不正确'
			              },
			              
			              qq: {//QQ号码验证
			                  validator: function (value, param) {
			                      return /^[1-9]\d{4,10}$/.test(value);
			                  },
			                  message: 'QQ号码不正确'
			              },
			              
			            age : {// 验证年龄
			                  validator : function(value) { 
			                      return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value); 
			                  }, 
			                  message : '年龄必须是0到120之间的整数' 
			              }, 
			              
			              english : {// 验证英语 
			                  validator : function(value) { 
			                      return /^[A-Za-z]+$/i.test(value); 
			                  }, 
			                  message : '请输入英文' 
			              }, 
			              
			              unnormal : {// 验证是否包含空格和非法字符 
			                  validator:function(value){
			                     return /^[a-zA-Z0-9\u4E00-\u9FA5]+$/.test(value);
			                    }, 
			                   message : '输入值不能为空和包含其他非法字符' 
			               }, 
			               
			               faxno : {// 验证传真 
			                   validator : function(value) { 
			                       return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value); 
			                   }, 
			                   message : '传真号码不正确' 
			               },
			               
			               ip : {// 验证IP地址 
			                   validator : function(value) { 
			                       return /^(?:(?:\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.){3}(?:\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/i.test(value); 
			                   }, 
			                   message : 'IP地址格式不正确' 
			               }, 
			               
			               date : { //验证日期
			                   validator : function(value) { 
			                    //格式yyyy-MM-dd或yyyy-M-d
			                       return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value); 
			                   },
			                   message : '请输入合适的日期格式,格式为yyyy-MM-dd或yyyy-M-d'
			               },
			               
			               same:{ //验证内容是否匹配
			                   validator:function(value,param){
			                      return $(param[0]).val() == value;
			                  },
			                  message:'字段不匹配'  
			              } ,
			              
			              name : {// 验证姓名，可以是中文或英文 
			                  validator : function(value) { 
			                      return /^[A-Za-z]+|[\u0391-\uFFE5]+$/i.test(value);
			                  }, 
			                  message : '请输入姓名,中文或英文' 
			          },
			          
			          msn:{ //验证msn
			              validator : function(value){ 
			              return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value); 
			          }, 
			          message : '请输入有效的msn账号(例：abc@hotnail(msn/live).com)' 
			          },
			          
			          currency : {// 验证货币 
			              validator : function(value) { 
			                  return /^\d+(\.\d+)?$/i.test(value); 
			              }, 
			              message : '货币格式不正确' 
			          }, 
					});
			        
		 				var safePassword = function (value) {//密码格式
			            	    return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/.test(value));
			            	}

		 				var idCard = function (value) {//身份证格式
			            	    if (value.length == 18 && 18 != value.length) return false;
			            	    var number = value.toLowerCase();
			            	    var d, sum = 0, v = '10x98765432', w = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2], a = '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
			            	    var re = number.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/);
			            	    if (re == null || a.indexOf(re[1]) < 0) return false;
			            	    if (re[2].length == 9) {
			            	        number = number.substr(0, 6) + '19' + number.substr(6);
			            	        d = ['19' + re[4], re[5], re[6]].join('-');
			            	    } else d = [re[9], re[10], re[11]].join('-');
			            	    if (!isDateTime.call(d, 'yyyy-MM-dd')) return false;
			            	    for (var i = 0; i < 17; i++) sum += number.charAt(i) * w[i];
			            	    return (re[2].length == 9 || number.charAt(17) == v.charAt(sum % 11));
			            	}

