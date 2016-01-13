package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtGxfw entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_GXFW")
public class TXtGxfw extends BaseEntity<Integer>{

	// Fields

	private Integer yhId;
	private String bmBh;

	// Constructors

	/** default constructor */
	public TXtGxfw() {
	}

	/** minimal constructor */
	public TXtGxfw(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtGxfw(Integer id, Integer yhId, String bmBh) {
		this.id = id;
		this.yhId = yhId;
		this.bmBh = bmBh;
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

	@Column(name = "YH_ID", scale = 0)
	public Integer getYhId() {
		return this.yhId;
	}

	public void setYhId(Integer yhId) {
		this.yhId = yhId;
	}

	@Column(name = "BM_BH", length = 50)
	public String getBmBh() {
		return this.bmBh;
	}

	public void setBmBh(String bmBh) {
		this.bmBh = bmBh;
	}

}