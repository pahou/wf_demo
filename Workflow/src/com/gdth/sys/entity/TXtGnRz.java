package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtGnRz entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_GN_RZ")
public class TXtGnRz extends BaseEntity<Integer>{

	// Fields

	private String gnLj;
	private String bz;
	private String lrSj;
	private String yhXm;
	private String bmCcbh;
	private String yhZh;
	private String bmMc;
	private String bmBh;
	private String gnMc;

	// Constructors

	/** default constructor */
	public TXtGnRz() {
	}

	/** minimal constructor */
	public TXtGnRz(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtGnRz(Integer id, String gnLj, String bz, String lrSj,
			String yhXm, String bmCcbh, String yhZh, String bmMc, String bmBh,
			String gnMc) {
		this.id = id;
		this.gnLj = gnLj;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhXm = yhXm;
		this.bmCcbh = bmCcbh;
		this.yhZh = yhZh;
		this.bmMc = bmMc;
		this.bmBh = bmBh;
		this.gnMc = gnMc;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "GN_LJ", length = 200)
	public String getGnLj() {
		return this.gnLj;
	}

	public void setGnLj(String gnLj) {
		this.gnLj = gnLj;
	}

	@Column(name = "BZ", length = 2000)
	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Column(name = "LR_SJ")
	public String getLrSj() {
		return this.lrSj;
	}

	public void setLrSj(String lrSj) {
		this.lrSj = lrSj;
	}

	@Column(name = "YH_XM", length = 50)
	public String getYhXm() {
		return this.yhXm;
	}

	public void setYhXm(String yhXm) {
		this.yhXm = yhXm;
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

	@Column(name = "GN_MC", length = 100)
	public String getGnMc() {
		return this.gnMc;
	}

	public void setGnMc(String gnMc) {
		this.gnMc = gnMc;
	}

}