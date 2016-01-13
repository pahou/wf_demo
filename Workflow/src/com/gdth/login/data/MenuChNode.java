package com.gdth.login.data;

import com.gdth.sys.entity.TXtGn;


/**    
 * 版本信息：Version-1.0.1  
 * 文件名：MenuNode.java
 * 日期：2014-10-16 下午6:07:54
 * Copyright 广东天宏通讯科技有限公司 2014     
 * 版权所有   
 * 作者 ： 谢嘉键
 *    
 */

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
public class MenuChNode {
    
    private int menuid;
    private String menuname;
    private String icon;
    private String url;
    private String child;
    
    
    public MenuChNode(){
       
    }
    
    public MenuChNode(TXtGn gn,String sysPath){
        this.menuid = gn.getId();
        String iconStr = gn.getTbLj();
        if(iconStr!=null){
            iconStr = iconStr.substring(iconStr.lastIndexOf(")")+1).trim();
        }
        this.icon = iconStr;
        this.menuname = gn.getMc();
        //this.url  = sysPath+"/"+gn.getGnLj();
        this.url  = gn.getGnLj();
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
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getChild() {
        return child;
    }
    public void setChild(String child) {
        this.child = child;
    }
    
}
