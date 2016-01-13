package com.gdth.util;

import net.sf.json.JSONArray;

/**    
 *     
 * 项目名称：plc    
 * 类名称：getBeanJson    
 * 类描述：    
 * 创建人：谢嘉键    
 * 创建时间：2014-10-16 下午6:34:49    
 * 修改人：xjj    
 * 修改时间：2014-10-16 下午6:34:49    
 * 修改备注：    
 * @version     
 *     
 */
public class GetBeanJson {
    public static String getChBeanJson(Object gn){
        String jsonstr = JSONArray.fromObject(gn).toString();
        jsonstr =  jsonstr.replace("[", "");
        jsonstr =  jsonstr.replace("]", "");
        return jsonstr;
    }
    public static String getBeanJson(Object gn){
        String jsonstr = JSONArray.fromObject(gn).toString();
        jsonstr =  jsonstr.replace("[", "");
        jsonstr =  jsonstr.replace("}]", "");
        return jsonstr;
    }
}
