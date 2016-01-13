package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtBbGxfw entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_BB_GXFW")
public class TXtBbGxfw extends BaseEntity<Integer>{

	// Fields

	private Integer yhId;
	private Integer bbId;

	// Constructors

	/** default constructor */
	public TXtBbGxfw() {
	}

	/** minimal constructor */
	public TXtBbGxfw(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtBbGxfw(Integer id, Integer yhId, Integer bbId) {
		this.id = id;
		this.yhId = yhId;
		this.bbId = bbId;
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

	@Column(name = "BB_ID", scale = 0)
	public Integer getBbId() {
		return this.bbId;
	}

	public void setBbId(Integer bbId) {
		this.bbId = bbId;
	}

}