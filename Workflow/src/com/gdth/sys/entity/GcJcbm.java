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
 * GcJcbm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "GC_JCBM")
public class GcJcbm extends BaseEntity<Integer> {

	// Fields

	public String mc;
	public String lb;
	public String bz;
	public Date lrSj;
	public String yhId;

	// Constructors

	/** default constructor */
	public GcJcbm() {
	}

	/** minimal constructor */
	public GcJcbm(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public GcJcbm(Integer id, String mc, String lb, String bz, Date lrSj,
			String yhId) {
		this.id = id;
		this.mc = mc;
		this.lb = lb;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhId = yhId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="gcjcbm_sequence")
    @SequenceGenerator(name="gcjcbm_sequence",sequenceName="GC_JCBM_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "MC", length = 100)
	public String getMc() {
		return this.mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	@Column(name = "LB", length = 100)
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

	@Column(name = "YH_ID", length = 50)
	public String getYhId() {
		return this.yhId;
	}

	public void setYhId(String yhId) {
		this.yhId = yhId;
	}

}