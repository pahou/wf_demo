package com.gdth.sys.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtJs entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_JS")
public class TXtJs extends BaseEntity<Integer>{

	// Fields

	private String bh;
	private String xm;
	private String lb;
	private String bz;
	private Date lrSj;
	private String yhXm;
	private String yhZh;
	private String bmBh;
	private String bmMc;
	private String bmCcbh;
	private String zt;
	private Date xgSj;
	private String xgyhZh;
	private Date scSj;
	private String scyhZh;

	// Constructors

	/** default constructor */
	public TXtJs() {
	}

	/** minimal constructor */
	public TXtJs(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtJs(Integer id, String bh, String xm, String lb, String bz,
			Date lrSj, String yhXm, String yhZh, String bmBh, String bmMc,
			String bmCcbh, String zt, Date xgSj, String xgyhZh, Date scSj,
			String scyhZh) {
		this.id = id;
		this.bh = bh;
		this.xm = xm;
		this.lb = lb;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhXm = yhXm;
		this.yhZh = yhZh;
		this.bmBh = bmBh;
		this.bmMc = bmMc;
		this.bmCcbh = bmCcbh;
		this.zt = zt;
		this.xgSj = xgSj;
		this.xgyhZh = xgyhZh;
		this.scSj = scSj;
		this.scyhZh = scyhZh;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="js_sequence")
    @SequenceGenerator(name="js_sequence",sequenceName="T_XT_JS_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "BH", length = 20)
	public String getBh() {
		return this.bh;
	}

	public void setBh(String bh) {
		this.bh = bh;
	}

	@Column(name = "XM", length = 100)
	public String getXm() {
		return this.xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	@Column(name = "LB", length = 1)
	public String getLb() {
		return this.lb;
	}

	public void setLb(String lb) {
		this.lb = lb;
	}

	@Column(name = "BZ", length = 200)
	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Column(name = "LR_SJ")
	public Date getLrSj() {
		return this.lrSj;
	}

	public void setLrSj(Date lrSj) {
		this.lrSj = lrSj;
	}

	@Column(name = "YH_XM", length = 50)
	public String getYhXm() {
		return this.yhXm;
	}

	public void setYhXm(String yhXm) {
		this.yhXm = yhXm;
	}

	@Column(name = "YH_ZH", length = 50)
	public String getYhZh() {
		return this.yhZh;
	}

	public void setYhZh(String yhZh) {
		this.yhZh = yhZh;
	}

	@Column(name = "BM_BH", length = 50)
	public String getBmBh() {
		return this.bmBh;
	}

	public void setBmBh(String bmBh) {
		this.bmBh = bmBh;
	}

	@Column(name = "BM_MC", length = 50)
	public String getBmMc() {
		return this.bmMc;
	}

	public void setBmMc(String bmMc) {
		this.bmMc = bmMc;
	}

	@Column(name = "BM_CCBH", length = 50)
	public String getBmCcbh() {
		return this.bmCcbh;
	}

	public void setBmCcbh(String bmCcbh) {
		this.bmCcbh = bmCcbh;
	}

	@Column(name = "ZT", length = 1)
	public String getZt() {
		return this.zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	@Column(name = "XG_SJ")
	public Date getXgSj() {
		return this.xgSj;
	}

	public void setXgSj(Date xgSj) {
		this.xgSj = xgSj;
	}

	@Column(name = "XGYH_ZH", length = 50)
	public String getXgyhZh() {
		return this.xgyhZh;
	}

	public void setXgyhZh(String xgyhZh) {
		this.xgyhZh = xgyhZh;
	}

	@Column(name = "SC_SJ")
	public Date getScSj() {
		return this.scSj;
	}

	public void setScSj(Date scSj) {
		this.scSj = scSj;
	}

	@Column(name = "SCYH_ZH", length = 50)
	public String getScyhZh() {
		return this.scyhZh;
	}

	public void setScyhZh(String scyhZh) {
		this.scyhZh = scyhZh;
	}

}