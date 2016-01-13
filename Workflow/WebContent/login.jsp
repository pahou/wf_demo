<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>清远市地税流程统一管理平台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<link rel="stylesheet" type="text/css" href="js/easyui1.3.4/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="js/easyui1.3.4/themes/icon.css">
	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
	<script type="text/javascript" src="js/easyui1.3.4/jquery.easyui.min.js"></script>	
</head>
<body>
   <div class="header">
      <div class="logo"><img src="images/blogo.png"/></div>
   </div>
  <!--幻灯片开始-->
    <div class="fullSlider">
                  <ul class="fullBanner" id="fullSlider">
                        <li> <a href="#">
                              <div  class="bg bgon"><img src="images/sa.jpg" width="100%" height="600" /></div>
                              </a> </li>
                        <li> <a href="#">
                              <div  class="bg bgon"><img src="images/sb.jpg" width="100%"  height="600" /></div>
                              </a> </li>
                  </ul>
				 <!--登录框开始-->
				 <form action="${pageContext.request.contextPath}/tlogin.do" method="post"> 
				  <div class="loginMain">
                         
                          <div class="name">清远市地方税务局流程统一管理平台</div>
                          
	                      <div class="con">
                              <div class="li-lable">用户名</div>
		                      <div class="li-input">
		                        <input name="username" type="text" onkeypress="submitWhenEnter()" value="" placeholder="用户名、手机、邮箱" />
		                      </div>
                          </div>
	                      <div class="con">
                               <div class="li-lable">密&nbsp&nbsp码</div>
		                       <div class="li-input">
		                          <input name="password" type="password" value="" placeholder="请输入您的密码" />
		                       </div>
                          </div>
	                      <div class="con">
		                       <input class="btn" name="commit" type="submit" value="登录"/>
	                      </div>
	  
               </div>
               </form>
			   <!--登录框结束--> 
			   
			   
    </div>
			
<!--幻灯片结束-->

   <div class="footer">
       <p>版权所有 &copy 广东天宏通讯科技有限公司</p>
   </div>
   


<!-- 
	<form action="${pageContext.request.contextPath}/tlogin.do" method="post">
		username：<input type="text" name="username" /> <br /> 
		password：<input type="password" name="password" /> <br /> 
		<input type="submit" value="login" />
		<input type="reset" value="reset" />
	</form>
	 -->
	
<script type="text/javascript">
var error = '<%=request.getAttribute("error")%>';
if (error!="null" && error.length>0) $.messager.alert('登录提示',error,'warning');

</script>	
</body>
</html>
