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
 * GcSbxx entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "GC_SBXX")
public class GcSbxx extends BaseEntity<Integer> {

	// Fields

	
	public String sbid;
	public String sbmc;
	public String sbxh;
	public String sbcs;
	public String bz;
	public Date lrSj;
	public String yhId;

	// Constructors

	/** default constructor */
	public GcSbxx() {
	}

	/** minimal constructor */
	public GcSbxx(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public GcSbxx(Integer id, String sbid, String sbmc, String sbxh,
			String sbcs, String bz, Date lrSj, String yhId) {
		this.id = id;
		this.sbid = sbid;
		this.sbmc = sbmc;
		this.sbxh = sbxh;
		this.sbcs = sbcs;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhId = yhId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="GcSbxx_sequence")
    @SequenceGenerator(name="GcSbxx_sequence",sequenceName="GcSbxx_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "SBID", length = 100)
	public String getSbid() {
		return this.sbid;
	}

	public void setSbid(String sbid) {
		this.sbid = sbid;
	}

	@Column(name = "SBMC", length = 100)
	public String getSbmc() {
		return this.sbmc;
	}

	public void setSbmc(String sbmc) {
		this.sbmc = sbmc;
	}

	@Column(name = "SBXH", length = 100)
	public String getSbxh() {
		return this.sbxh;
	}

	public void setSbxh(String sbxh) {
		this.sbxh = sbxh;
	}

	@Column(name = "SBCS", length = 100)
	public String getSbcs() {
		return this.sbcs;
	}

	public void setSbcs(String sbcs) {
		this.sbcs = sbcs;
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