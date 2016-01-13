package com.gdth.sys.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtYh entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_YH",  uniqueConstraints = @UniqueConstraint(columnNames = "ZH"))
public class TXtYh extends BaseEntity<Integer>{

	// Fields

	/**
	 * 
	 */
	public static final long serialVersionUID = -7927758374511574162L;
	// public Integer id;
	public TXtBm bm;
	public String zh;
	public String xm;
	public String lc;
	public String mm;
	public String xb;
	public Date csrq;
	public String lxdh;
	public String dzyj;
	public String ghfw;
	public String zw;
	public String bz;
	public String zwDm;
	public String yhZh;
	public String yhXm;
	public String bmBh;
	public String bmMc;
	public String bmCcbh;
	public Date lrSj;
	public String zt;
	public Date xgSj;
	public String xgyhZh;
	public Date scSj;
	public String scyhZh;
	private TXtZn zn;
	
	/** default constructor */
	public TXtYh() {
	}

	/** minimal constructor */
	public TXtYh(Integer id) {
		this.id = id;
	}

	public TXtYh(TXtBm bm, String zh, String xm, String lc, String mm,
			String xb, Date csrq, String lxdh, String dzyj, String ghfw,
			String zw, String bz, String zwDm, String yhZh, String yhXm,
			String bmBh, String bmMc, String bmCcbh, Date lrSj, String zt,
			Date xgSj, String xgyhZh, Date scSj, String scyhZh, TXtZn zn) {
		super();
		this.bm = bm;
		this.zh = zh;
		this.xm = xm;
		this.lc = lc;
		this.mm = mm;
		this.xb = xb;
		this.csrq = csrq;
		this.lxdh = lxdh;
		this.dzyj = dzyj;
		this.ghfw = ghfw;
		this.zw = zw;
		this.bz = bz;
		this.zwDm = zwDm;
		this.yhZh = yhZh;
		this.yhXm = yhXm;
		this.bmBh = bmBh;
		this.bmMc = bmMc;
		this.bmCcbh = bmCcbh;
		this.lrSj = lrSj;
		this.zt = zt;
		this.xgSj = xgSj;
		this.xgyhZh = xgyhZh;
		this.scSj = scSj;
		this.scyhZh = scyhZh;
		this.zn = zn;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "yh_sequence")
	@SequenceGenerator(name = "yh_sequence", sequenceName = "T_XT_YH_SEQUENCE", allocationSize = 1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BMID")
	public TXtBm getBm() {
		return this.bm;
	}

	public void setBm(TXtBm bm) {
		this.bm = bm;
	}
	

	@Column(name = "ZH", unique = true, length = 20)
	public String getZh() {
		return this.zh;
	}

	public void setZh(String zh) {
		this.zh = zh;
	}

	@Column(name = "XM", length = 50)
	public String getXm() {
		return this.xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	@Column(name = "LC", length = 50)
	public String getLc() {
		return this.lc;
	}

	public void setLc(String lc) {
		this.lc = lc;
	}

	@Column(name = "MM", length = 50)
	public String getMm() {
		return this.mm;
	}

	public void setMm(String mm) {
		this.mm = mm;
	}

	@Column(name = "XB")
	public String getXb() {
		return this.xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}

	@Column(name = "CSRQ")
	public Date getCsrq() {
		return this.csrq;
	}

	public void setCsrq(Date csrq) {
		this.csrq = csrq;
	}

	@Column(name = "LXDH", length = 20)
	public String getLxdh() {
		return this.lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	@Column(name = "DZYJ", length = 50)
	public String getDzyj() {
		return this.dzyj;
	}

	public void setDzyj(String dzyj) {
		this.dzyj = dzyj;
	}

	@Column(name = "GHFW", length = 10)
	public String getGhfw() {
		return this.ghfw;
	}

	public void setGhfw(String ghfw) {
		this.ghfw = ghfw;
	}

	@Column(name = "ZW", length = 20)
	public String getZw() {
		return this.zw;
	}

	public void setZw(String zw) {
		this.zw = zw;
	}

	@Column(name = "BZ", length = 10)
	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Column(name = "ZW_DM", length = 20)
	public String getZwDm() {
		return this.zwDm;
	}

	public void setZwDm(String zwDm) {
		this.zwDm = zwDm;
	}

	@Column(name = "YH_ZH", length = 50)
	public String getYhZh() {
		return this.yhZh;
	}

	public void setYhZh(String yhZh) {
		this.yhZh = yhZh;
	}

	@Column(name = "YH_XM", length = 50)
	public String getYhXm() {
		return this.yhXm;
	}

	public void setYhXm(String yhXm) {
		this.yhXm = yhXm;
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

	@Column(name = "LR_SJ")
	public Date getLrSj() {
		return this.lrSj;
	}

	public void setLrSj(Date lrSj) {
		this.lrSj = lrSj;
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
	
	@ManyToOne()
	@JoinColumn(name = "ZN_ID")
	public TXtZn getZn() {
		return zn;
	}

	public void setZn(TXtZn zn) {
		this.zn = zn;
	}
	
	
}