package com.gdth.sys.entity;

import java.math.BigDecimal;
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

import com.gdth.base.entity.BaseEntity;

/**
 * GcSbaz entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "GC_SBAZ")
public class GcSbaz extends BaseEntity<Integer> {

	// Fields

	public GcGdxx gcGdxx;
	public Date azSj;
	public String sbxxId;
	public String sbip;
	public Date ccSj;
	public String ccYy;
	public String zt;
	public String bz;
	public Date lrSj;
	public String yhId;

	// Constructors

	/** default constructor */
	public GcSbaz() {
	}

	/** minimal constructor */
	public GcSbaz(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public GcSbaz(Integer id, GcGdxx gcGdxx, Date azSj, String sbxxId,
			String sbip, Date ccSj, String ccYy, String zt, String bz,
			Date lrSj, String yhId) {
		this.id = id;
		this.gcGdxx = gcGdxx;
		this.azSj = azSj;
		this.sbxxId = sbxxId;
		this.sbip = sbip;
		this.ccSj = ccSj;
		this.ccYy = ccYy;
		this.zt = zt;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhId = yhId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="gcsbaz_sequence")
    @SequenceGenerator(name="gcsbaz_sequence",sequenceName="GC_SBAZ_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "GDXX_ID")
	public GcGdxx getGcGdxx() {
		return this.gcGdxx;
	}

	public void setGcGdxx(GcGdxx gcGdxx) {
		this.gcGdxx = gcGdxx;
	}

	@Column(name = "AZ_SJ")
	public Date getAzSj() {
		return this.azSj;
	}

	public void setAzSj(Date azSj) {
		this.azSj = azSj;
	}

	@Column(name = "SBXX_ID", length = 100)
	public String getSbxxId() {
		return this.sbxxId;
	}

	public void setSbxxId(String sbxxId) {
		this.sbxxId = sbxxId;
	}

	@Column(name = "SBIP", length = 100)
	public String getSbip() {
		return this.sbip;
	}

	public void setSbip(String sbip) {
		this.sbip = sbip;
	}

	@Column(name = "CC_SJ")
	public Date getCcSj() {
		return this.ccSj;
	}

	public void setCcSj(Date ccSj) {
		this.ccSj = ccSj;
	}

	@Column(name = "CC_YY", length = 100)
	public String getCcYy() {
		return this.ccYy;
	}

	public void setCcYy(String ccYy) {
		this.ccYy = ccYy;
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