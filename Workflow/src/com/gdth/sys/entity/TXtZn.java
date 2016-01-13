package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtYh entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_ZN")
public class TXtZn extends BaseEntity<Integer> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4169713751492560420L;
	// Fields

	/**
	 * 
	 */
    private String bh;
    private String mc;
    private String bz;
    private String zt;
    private String lrSj;
    private String yhXm;
    private String yhZh;
    private String bmBh;
    private String bmMc;
    private String bmCcbh;
    private String xgSj;
    private String xgyhZh;
    private String scSj;
    private String scyhZh;

	
	public TXtZn() {
		super();
	}
	
	public TXtZn(String bh, String mc, String bz, String zt, String lrSj,
			String yhXm, String yhZh, String bmBh, String bmMc, String bmCcbh,
			String xgSj, String xgyhZh, String scSj, String scyhZh) {
		super();
		this.bh = bh;
		this.mc = mc;
		this.bz = bz;
		this.zt = zt;
		this.lrSj = lrSj;
		this.yhXm = yhXm;
		this.yhZh = yhZh;
		this.bmBh = bmBh;
		this.bmMc = bmMc;
		this.bmCcbh = bmCcbh;
		this.xgSj = xgSj;
		this.xgyhZh = xgyhZh;
		this.scSj = scSj;
		this.scyhZh = scyhZh;
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="zn_sequence")
    @SequenceGenerator(name="zn_sequence",sequenceName="T_XT_ZN_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId(){
		return id;
	}
	
	public void setId(Integer id){
		this.id = id;
	}

	 @Column(name="BH", length=20)

	    public String getBh() {
	        return this.bh;
	    }
	    
	    public void setBh(String bh) {
	        this.bh = bh;
	    }

	    @Column(name="MC", length=100)

	    public String getMc() {
	        return this.mc;
	    }
	    
	    public void setMc(String mc) {
	        this.mc = mc;
	    }

	    @Column(name="BZ", length=200)

	    public String getBz() {
	        return this.bz;
	    }
	    
	    public void setBz(String bz) {
	        this.bz = bz;
	    }

	    @Column(name="ZT", length=1)

	    public String getZt() {
	        return this.zt;
	    }
	    
	    public void setZt(String zt) {
	        this.zt = zt;
	    }

	    @Column(name="LR_SJ")

	    public String getLrSj() {
	        return this.lrSj;
	    }
	    
	    public void setLrSj(String lrSj) {
	        this.lrSj = lrSj;
	    }

	    @Column(name="YH_XM", length=50)

	    public String getYhXm() {
	        return this.yhXm;
	    }
	    
	    public void setYhXm(String yhXm) {
	        this.yhXm = yhXm;
	    }

	    @Column(name="YH_ZH", length=50)

	    public String getYhZh() {
	        return this.yhZh;
	    }
	    
	    public void setYhZh(String yhZh) {
	        this.yhZh = yhZh;
	    }

	    @Column(name="BM_BH", length=50)

	    public String getBmBh() {
	        return this.bmBh;
	    }
	    
	    public void setBmBh(String bmBh) {
	        this.bmBh = bmBh;
	    }

	    @Column(name="BM_MC", length=50)

	    public String getBmMc() {
	        return this.bmMc;
	    }
	    
	    public void setBmMc(String bmMc) {
	        this.bmMc = bmMc;
	    }

	    @Column(name="BM_CCBH", length=50)

	    public String getBmCcbh() {
	        return this.bmCcbh;
	    }
	    
	    public void setBmCcbh(String bmCcbh) {
	        this.bmCcbh = bmCcbh;
	    }

	    @Column(name="XG_SJ")

	    public String getXgSj() {
	        return this.xgSj;
	    }
	    
	    public void setXgSj(String xgSj) {
	        this.xgSj = xgSj;
	    }

	    @Column(name="XGYH_ZH", length=50)

	    public String getXgyhZh() {
	        return this.xgyhZh;
	    }
	    
	    public void setXgyhZh(String xgyhZh) {
	        this.xgyhZh = xgyhZh;
	    }

	    @Column(name="SC_SJ")

	    public String getScSj() {
	        return this.scSj;
	    }
	    
	    public void setScSj(String scSj) {
	        this.scSj = scSj;
	    }

	    @Column(name="SCYH_ZH", length=50)

	    public String getScyhZh() {
	        return this.scyhZh;
	    }
	    
	    public void setScyhZh(String scyhZh) {
	        this.scyhZh = scyhZh;
	    }
	
}