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
 * GcWhjl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "GC_WHJL")
public class GcWhjl extends BaseEntity<Integer> {

	// Fields


	public Integer gdxxId;
	public String gzQk;
	public Date bzSj;
	public String whjb;
	public String whr;
	public Date whSj;
	public String gzYy;
	public String jjFf;
	public String zt;
	public String bz;
	public Date lrSj;
	public String yhId;

	// Constructors

	/** default constructor */
	public GcWhjl() {
	}

	/** minimal constructor */
	public GcWhjl(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public GcWhjl(Integer id, Integer gdxxId, String gzQk, Date bzSj,
			String whjb, String whr, Date whSj, String gzYy, String jjFf,
			String zt, String bz, Date lrSj, String yhId) {
		this.id = id;
		this.gdxxId = gdxxId;
		this.gzQk = gzQk;
		this.bzSj = bzSj;
		this.whjb = whjb;
		this.whr = whr;
		this.whSj = whSj;
		this.gzYy = gzYy;
		this.jjFf = jjFf;
		this.zt = zt;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhId = yhId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="GcWhjl_sequence")
    @SequenceGenerator(name="GcWhjl_sequence",sequenceName="GcWhjl_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "GDXX_ID", scale = 0)
	public Integer getGdxxId() {
		return this.gdxxId;
	}

	public void setGdxxId(Integer gdxxId) {
		this.gdxxId = gdxxId;
	}

	@Column(name = "GZ_QK", length = 100)
	public String getGzQk() {
		return this.gzQk;
	}

	public void setGzQk(String gzQk) {
		this.gzQk = gzQk;
	}

	@Column(name = "BZ_SJ")
	public Date getBzSj() {
		return this.bzSj;
	}

	public void setBzSj(Date bzSj) {
		this.bzSj = bzSj;
	}

	@Column(name = "WHJB")
	public String getWhjb() {
		return this.whjb;
	}

	public void setWhjb(String whjb) {
		this.whjb = whjb;
	}

	@Column(name = "WHR", length = 100)
	public String getWhr() {
		return this.whr;
	}

	public void setWhr(String whr) {
		this.whr = whr;
	}

	@Column(name = "WH_SJ")
	public Date getWhSj() {
		return this.whSj;
	}

	public void setWhSj(Date whSj) {
		this.whSj = whSj;
	}

	@Column(name = "GZ_YY", length = 100)
	public String getGzYy() {
		return this.gzYy;
	}

	public void setGzYy(String gzYy) {
		this.gzYy = gzYy;
	}

	@Column(name = "JJ_FF", length = 100)
	public String getJjFf() {
		return this.jjFf;
	}

	public void setJjFf(String jjFf) {
		this.jjFf = jjFf;
	}

	@Column(name = "ZT", length = 100)
	public String getZt() {
		return this.zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
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

	@Column(name = "YH_ID", length = 50)
	public String getYhId() {
		return this.yhId;
	}

	public void setYhId(String yhId) {
		this.yhId = yhId;
	}

}