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
 * TXtGn entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_GN")
public class TXtGn extends BaseEntity<Integer>{

	// Fields

	public Integer bh;
	public String mc;
	public String jc;
	public Integer sjgnId;
	public String lb;
	public String tbLj;
	public String gnLj;
	public String anFf;
	public Date lrSj;
	public String yhXm;
	public String ms;
	public String bmCcbh;
	public String yhZh;
	public String bmMc;
	public String bmBh;
	public String zyTbLj;
	public String zt;
	public Date xgSj;
	public String xgyhZh;
	public Date scSj;
	public String scyhZh;

	// Constructors

	/** default constructor */
	public TXtGn() {
	}

	/** minimal constructor */
	public TXtGn(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtGn(Integer id, Integer bh, String mc, String jc,
			Integer sjgnId, String lb, String tbLj, String gnLj,
			String anFf, Date lrSj, String yhXm, String ms, String bmCcbh,
			String yhZh, String bmMc, String bmBh, String zyTbLj, String zt,
			Date xgSj, String xgyhZh, Date scSj, String scyhZh) {
		this.id = id;
		this.bh = bh;
		this.mc = mc;
		this.jc = jc;
		this.sjgnId = sjgnId;
		this.lb = lb;
		this.tbLj = tbLj;
		this.gnLj = gnLj;
		this.anFf = anFf;
		this.lrSj = lrSj;
		this.yhXm = yhXm;
		this.ms = ms;
		this.bmCcbh = bmCcbh;
		this.yhZh = yhZh;
		this.bmMc = bmMc;
		this.bmBh = bmBh;
		this.zyTbLj = zyTbLj;
		this.zt = zt;
		this.xgSj = xgSj;
		this.xgyhZh = xgyhZh;
		this.scSj = scSj;
		this.scyhZh = scyhZh;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="gn_sequence")
    @SequenceGenerator(name="gn_sequence",sequenceName="T_XT_GN_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "BH", scale = 0)
	public Integer getBh() {
		return this.bh;
	}

	public void setBh(Integer bh) {
		this.bh = bh;
	}

	@Column(name = "MC", length = 100)
	public String getMc() {
		return this.mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	@Column(name = "JC", length = 50)
	public String getJc() {
		return this.jc;
	}

	public void setJc(String jc) {
		this.jc = jc;
	}

	@Column(name = "SJGN_ID", scale = 0)
	public Integer getSjgnId() {
		return this.sjgnId;
	}

	public void setSjgnId(Integer sjgnId) {
		this.sjgnId = sjgnId;
	}

	@Column(name = "LB", length = 1)
	public String getLb() {
		return this.lb;
	}

	public void setLb(String lb) {
		this.lb = lb;
	}

	@Column(name = "TB_LJ", length = 200)
	public String getTbLj() {
		return this.tbLj;
	}

	public void setTbLj(String tbLj) {
		this.tbLj = tbLj;
	}

	@Column(name = "GN_LJ", length = 200)
	public String getGnLj() {
		return this.gnLj;
	}

	public void setGnLj(String gnLj) {
		this.gnLj = gnLj;
	}

	@Column(name = "AN_FF", length = 200)
	public String getAnFf() {
		return this.anFf;
	}

	public void setAnFf(String anFf) {
		this.anFf = anFf;
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

	@Column(name = "MS", length = 500)
	public String getMs() {
		return this.ms;
	}

	public void setMs(String ms) {
		this.ms = ms;
	}

	@Column(name = "BM_CCBH", length = 100)
	public String getBmCcbh() {
		return this.bmCcbh;
	}

	public void setBmCcbh(String bmCcbh) {
		this.bmCcbh = bmCcbh;
	}

	@Column(name = "YH_ZH", length = 50)
	public String getYhZh() {
		return this.yhZh;
	}

	public void setYhZh(String yhZh) {
		this.yhZh = yhZh;
	}

	@Column(name = "BM_MC", length = 50)
	public String getBmMc() {
		return this.bmMc;
	}

	public void setBmMc(String bmMc) {
		this.bmMc = bmMc;
	}

	@Column(name = "BM_BH", length = 50)
	public String getBmBh() {
		return this.bmBh;
	}

	public void setBmBh(String bmBh) {
		this.bmBh = bmBh;
	}

	@Column(name = "ZY_TB_LJ", length = 200)
	public String getZyTbLj() {
		return this.zyTbLj;
	}

	public void setZyTbLj(String zyTbLj) {
		this.zyTbLj = zyTbLj;
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