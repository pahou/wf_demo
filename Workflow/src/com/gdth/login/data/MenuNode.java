/**    
 * 项目名称：数据综合展现二期   
 * 版本信息：Version-1.0.1  
 * 文件名：MenuNode.java
 * 日期：2014-10-16 下午6:07:54
 * Copyright 广东天宏通讯科技有限公司 2014     
 * 版权所有   
 * 作者 ： 谢嘉键
 *    
 */
package com.gdth.login.data;

import com.gdth.sys.entity.TXtGn;


/**    
 *     
 * 项目名称：syjk    
 * 类名称：MenuNode    
 * 类描述：    
 * 创建人：谢嘉键    
 * 创建时间：2014-10-16 下午6:07:54    
 * 修改人：xjj    
 * 修改时间：2014-10-16 下午6:07:54    
 * 修改备注：    
 * @version     
 *     
 */
public class MenuNode {
    
    private int menuid;
    private String menuname;
    private String icon;
    
    
    public MenuNode(){
       
    }
    
    public MenuNode(TXtGn gn){
        this.menuid = gn.getId();
        // url(>skin>common/icons.gif) -260px -60px
        String iconStr = gn.getTbLj();
        if(iconStr!=null){
            iconStr = iconStr.substring(iconStr.lastIndexOf(")")+1).trim();
        }
        this.icon = iconStr;
        this.menuname = gn.getMc();
    }
    
    public int getMenuid() {
        return menuid;
    }
    public void setMenuid(int menuid) {
        this.menuid = menuid;
    }
    public String getMenuname() {
        return menuname;
    }
    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }
    public String getIcon() {
        return icon;
    }
    public void setIcon(String icon) {
        this.icon = icon;
    }
    
    
}
