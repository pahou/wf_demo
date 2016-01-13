package com.gdth.login.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.gdth.base.action.BaseAction;
import com.gdth.login.data.MenuChNode;
import com.gdth.login.data.MenuNode;
import com.gdth.sys.entity.TXtBmGxfw;
import com.gdth.sys.entity.TXtGn;
import com.gdth.sys.entity.TXtYh;
import com.gdth.sys.entity.TXtYhGxfw;
import com.gdth.sys.service.TXtYhService;
import com.gdth.util.Constants;
import com.gdth.util.GetBeanJson;



@Controller
public class LoginAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private TXtYhService tXtYhService;
	
	
	@Resource
	public void settXtYhService(TXtYhService tXtYhService) {
		this.tXtYhService = tXtYhService;
	}

	private String username;
	private String password;

	public String login() {

		System.out.println("\n提交的请求参数如下：");
		System.out.println("empname：" + username);
		System.out.println("password：" + password + "\n");
		if (username == null)
			return LOGIN;

		HttpServletRequest request = ServletActionContext.getRequest();// 在Struts2的Action中获取Servlet的原生API
		List<TXtYh> userList = tXtYhService.queryByHQL("from TXtYh where zh='"
				+ username + "' and zt = '1'");
		TXtYh tXtYh = new TXtYh();
		if (userList != null && userList.size() > 0) {
			tXtYh = userList.get(0);
			if (!tXtYh.getMm().equals(password)) {
				request.setAttribute("error", "用户名或密码错误，请重新输入！");
				return LOGIN;
			}
			String yhId = String.valueOf(tXtYh.getId());
			String yhZh = String.valueOf(tXtYh.getZh());
//			List<TXtGn> listMenu = logingGetGn(userList.get(0).getId().toString());
			List<Map<String, Object>> listMenuMap = logingGetGnMap(String.valueOf(tXtYh.getId()),tXtYh.getZh());
//			achieveSeesion().put(Constants.MENU_KEY, listMenu); //session不直接保存TxtGn对象  换成List<Map<String, Object>>
			achieveSeesion().put(Constants.MENU_MAP_KEY, listMenuMap);
			achieveSeesion().put(Constants.USER_KEY, tXtYh);
			JSONObject userjson = new JSONObject();
			userjson.accumulate("zh", tXtYh.getZh());
			userjson.accumulate("xm", tXtYh.getXm());
			userjson.accumulate("id", tXtYh.getId());
			JSONObject bmjson = new JSONObject();
			bmjson.accumulate("bh", tXtYh.getBm().getBh());
			bmjson.accumulate("ccbh", tXtYh.getBm().getCcbh());
			bmjson.accumulate("mc", tXtYh.getBm().getMc());
			achieveSeesion().put(Constants.USER_JSON_KEY, userjson);
			achieveSeesion().put(Constants.BM_JSON_KEY, bmjson);
			String sysPath = request.getContextPath();
			achieveSeesion().put(Constants.JSON_MENU_MAP_KEY, getMenuJsonString(yhId,yhZh,sysPath));
			
			//查询管辖范围
			List<TXtYhGxfw> yhgxfw = tXtYhService.getDetailByHQL("from TXtYhGxfw where yhId = "+tXtYh.getId());
			List<TXtBmGxfw> bmgxfw = tXtYhService.getDetailByHQL("from TXtBmGxfw where bmId = "+tXtYh.getBm().getId());
			List<String> gxfw = new ArrayList<String>();
			for(TXtYhGxfw tXtYhGxfw : yhgxfw){
				gxfw.add(tXtYhGxfw.getBmCcbh());
			}
			for(TXtBmGxfw tXtBmGxfw : bmgxfw){
				gxfw.add(tXtBmGxfw.getBmCcbh());
			}
			if(gxfw.size()>0){
				achieveSeesion().put(Constants.CCBH_KEY, gxfw);
				achieveSeesion().put(Constants.GXFW_KEY, gxfw);
			}else{
				List<String> ccbh = new ArrayList<String>();
				ccbh.add(tXtYh.getBm().getCcbh());
				achieveSeesion().put(Constants.CCBH_KEY, ccbh);
			}
			return "success";
		} else {
			System.out.println("\n根据主键ID查询记录：没查到，查询失败，记录不存在！\n");
			request.setAttribute("error", "用户名或密码错误，请重新输入！");
			return "login";
		}
	}
	
	
	private  String getMenuJsonString(String yhid,String yhZh,String sysPath){
        List<TXtGn> gnlist = logingGetGn(yhid,yhZh);
        String menus = "\"menus\": [";
        int num = 0;
        for(TXtGn gn:gnlist){
            if("0".equals(gn.getLb())){
                Integer gnid = gn.getId();
                MenuNode mn = new MenuNode(gn);
                String menuStr = GetBeanJson.getBeanJson(mn);
                System.out.println("=======第一层数据========"+menuStr);
                int numch = 0;
                String chS = "";
                for(TXtGn chgn:gnlist){
//                    System.out.println("父节点id:"+gnid.toString());
//                    System.out.println("子节点中父节点id:"+chgn.getSjgnId());
//                    System.out.println("子节点LB:"+chgn.getLb());
                    Integer chPId = chgn.getSjgnId();
                    if(("1".equals(chgn.getLb()))&&(chPId==gnid||chPId.equals(gnid))){
                       MenuChNode mnch = new MenuChNode(chgn,sysPath);
                        String chStr = GetBeanJson.getChBeanJson(mnch);
                        if(numch>0){
                            chS += ","+chStr; 
                        }else{
                            chS += chStr;
                        }
                        numch++;
                    }
                }
                if(chS!=null){
                    chS = ",\"menus\":["+chS+"]"; 
                }
                menuStr += chS+"}";
                if(num>0){
                    menus += ","+menuStr; 
                }else{
                    menus += menuStr;
                }
                num++;
            }
            
        }
        menus += "]";
        return menus;
    }
	
	private List<Map<String,Object>> logingGetGnMap(String yhid,String yhZh){

		String sql = "select distinct syhgn.id, syhgn.bh, syhgn.mc, syhgn.jc, syhgn.sjgnid, syhgn.lb, syhgn.gnlj, syhgn.anff, syhgn.lrsj, syhgn.tblj, syhgn.zytblj, syhgn.ms from ( ";
		   sql = sql + 	"select  jsyh.yh_Id as yhid,gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj "; 
		   sql = sql + 	"from T_Xt_Js_Yh jsyh,T_Xt_Gn gn where  gn.zt=1 ";
		   sql = sql + 	"union ";
		   sql = sql + 	"select yh.Id as yhid,gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";		  
		   sql = sql + 	"from T_Xt_Yh yh,T_Xt_Gn gn where  gn.zt=1 ";
		   sql = sql + 	"union ";
		   sql = sql + 	"select yh.id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
		   sql = sql + 	"from T_Xt_Yh yh,  T_Xt_Gn gn where  gn.zt=1 ";
		   sql = sql + 	") syhgn where 1=1 order by syhgn.bh ";
	
		   if(!"admin".equals(yhZh)){
			sql="select distinct syhgn.id, syhgn.bh, syhgn.mc, syhgn.jc, syhgn.sjgnid, syhgn.lb, syhgn.gnlj, syhgn.anff, syhgn.lrsj, syhgn.tblj, syhgn.zytblj, syhgn.ms from ( ";
			sql = sql + 	"select jsyh.yh_Id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
			sql = sql + 	"from T_Xt_Js_Yh jsyh,T_Xt_Js_Gn jsgn,T_Xt_Gn gn where jsyh.js_Id=jsgn.js_Id and jsgn.gn_Id=gn.id and gn.zt=1 ";
			sql = sql + 	"union ";
			sql = sql + 	"select yh.Id as yhid,gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";		  
			sql = sql + 	"from T_Xt_Yh yh,T_Xt_Js_Bm jsbm,T_Xt_Js_Gn jsgn,T_Xt_Gn gn where (yh.bmid=jsbm.bm_id and jsbm.js_id=jsgn.js_id and jsgn.gn_Id=gn.id and gn.zt=1) "
					+" or ( yh.zh = 'admin' and  gn.zt=1)";   // 不过滤admin
			sql = sql + 	"union ";
			sql = sql +		"select yh.id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
			sql = sql +		"from T_Xt_Yh yh, T_Xt_Yh_Gn yhgn, T_Xt_Gn gn where yh.id=yhgn.Yh_Id and yhgn.Gn_Id=gn.id and gn.zt=1 ";
			sql = sql +		") syhgn where syhgn.yhid="+yhid
					+ " order by syhgn.bh ";	
		   }	  				  
				  
		
		List<Object[]> list = tXtYhService.queryPropertyBySql(sql);
		List<Map<String,Object>> listMenu = new ArrayList<Map<String,Object>>();
		for(int i=0;i<list.size();i++){
			Object[] obj = (Object[]) list.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", ((BigDecimal) obj[0]).intValue());
			map.put("bh", ((BigDecimal) obj[1]).intValue());
			map.put("mc", String.valueOf(obj[2]));
			map.put("jc", String.valueOf(obj[3]));
			map.put("sjgnId", obj[4] == null?0:((BigDecimal) obj[4]).intValue());
			map.put("lb", String.valueOf(obj[5]));
			map.put("gnLj", String.valueOf(obj[6]));
			map.put("anFf", String.valueOf(obj[7]));
			map.put("lrSj", (Date)obj[8]);
			map.put("tbLj", String.valueOf(obj[9]));
			map.put("zyTbLj", String.valueOf(obj[10]));
			map.put("ms", String.valueOf(obj[11]));
			listMenu.add(map);
		}
		
		return listMenu;
	}
	
	private List<TXtGn> logingGetGn(String yhid,String yhZh){
		
		String sql = "select distinct syhgn.id, syhgn.bh, syhgn.mc, syhgn.jc, syhgn.sjgnid, syhgn.lb, syhgn.gnlj, syhgn.anff, syhgn.lrsj, syhgn.tblj, syhgn.zytblj, syhgn.ms from ( ";
			   sql = sql + 	"select  jsyh.yh_Id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj "; 
			   sql = sql + 	"from T_Xt_Js_Yh jsyh,T_Xt_Gn gn where  gn.zt=1 ";
			   sql = sql + 	"union ";
			   sql = sql + 	"select yh.Id as yhid,gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";		  
			   sql = sql + 	"from T_Xt_Yh yh,T_Xt_Gn gn where  gn.zt=1 ";
			   sql = sql + 	"union ";
			   sql = sql + 	"select yh.id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
			   sql = sql + 	"from T_Xt_Yh yh,  T_Xt_Gn gn where  gn.zt=1 ";
			   sql = sql + 	") syhgn where 1=1 order by syhgn.bh ";
		
		if(!"admin".equals(yhZh)){
			sql="select distinct syhgn.id, syhgn.bh, syhgn.mc, syhgn.jc, syhgn.sjgnid, syhgn.lb, syhgn.gnlj, syhgn.anff, syhgn.lrsj, syhgn.tblj, syhgn.zytblj, syhgn.ms from ( ";
			sql = sql + 	"select jsyh.yh_Id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
			sql = sql + 	"from T_Xt_Js_Yh jsyh,T_Xt_Js_Gn jsgn,T_Xt_Gn gn where jsyh.js_Id=jsgn.js_Id and jsgn.gn_Id=gn.id and gn.zt=1 ";
			sql = sql + 	"union ";
			sql = sql + 	"select yh.Id as yhid,gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";		  
			sql = sql + 	"from T_Xt_Yh yh,T_Xt_Js_Bm jsbm,T_Xt_Js_Gn jsgn,T_Xt_Gn gn where yh.bmid=jsbm.bm_id and jsbm.js_id=jsgn.js_id and jsgn.gn_Id=gn.id and gn.zt=1 ";
			sql = sql + 	"union ";
			sql = sql +		"select yh.id as yhid, gn.id, gn.bh, gn.mc, gn.jc, gn.sjgn_Id as sjgnid, gn.lb, gn.gn_Lj as gnlj, gn.an_Ff as anff, gn.lr_Sj as lrsj, gn.tb_Lj as tblj,gn.ms as ms, gn.zy_tb_lj as zytblj ";
			sql = sql +		"from T_Xt_Yh yh, T_Xt_Yh_Gn yhgn, T_Xt_Gn gn where yh.id=yhgn.Yh_Id and yhgn.Gn_Id=gn.id and gn.zt=1 ";
			sql = sql +		") syhgn where syhgn.yhid="+yhid+" order by syhgn.bh ";				
		}
		
		List list = tXtYhService.queryPropertyBySql(sql);
		List<TXtGn> listMenu = new ArrayList<TXtGn>();
		for(int i=0;i<list.size();i++){
			Object[] obj = (Object[]) list.get(i);
			//Map xtgnMap = (Map) list.get(i);
			TXtGn userMenu = new TXtGn();
			userMenu.setId(((BigDecimal) obj[0]).intValue());
			userMenu.setBh(((BigDecimal) obj[1]).intValue());
			userMenu.setMc(String.valueOf(obj[2]));
			userMenu.setJc(String.valueOf(obj[3]));
			userMenu.setSjgnId(obj[4] == null?0:((BigDecimal) obj[4]).intValue());
			userMenu.setLb(String.valueOf(obj[5]));
			userMenu.setGnLj(String.valueOf(obj[6]));
			userMenu.setAnFf(String.valueOf(obj[7]));
			userMenu.setLrSj( (Date)obj[8]);
			userMenu.setTbLj(String.valueOf(obj[9]));
			userMenu.setMs(String.valueOf(obj[11]));
			userMenu.setZyTbLj(String.valueOf(obj[10]));
			
			listMenu.add(userMenu);
		}
		
		return listMenu;
	}
	
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}