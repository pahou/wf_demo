/**    
 * 项目名称：数据综合展现二期   
 * 版本信息：Version-1.0.1  
 * 文件名：LoginException.java
 * 日期：2014-9-1 下午5:46:46
 * Copyright 广东天宏通讯科技有限公司 2014     
 * 版权所有   
 * 作者 ： 胡铿
 *    
 */

package com.gdth.login.exception;

public class LoginException extends RuntimeException{
	private static final long serialVersionUID = 1L;
	public String msg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public LoginException(String msg) {
		super(msg);
		this.msg = msg;
	}
	
	
}
