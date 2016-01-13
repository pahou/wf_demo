package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtYhGn entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_YH_GN")
public class TXtYhGn extends BaseEntity<Integer>{

	// Fields

	private Integer yhId;
	private Integer gnId;

	// Constructors

	/** default constructor */
	public TXtYhGn() {
	}

	/** full constructor */
	public TXtYhGn(Integer id, Integer yhId, Integer gnId) {
		this.id = id;
		this.yhId = yhId;
		this.gnId = gnId;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="yh_gn_sequence")
    @SequenceGenerator(name="yh_gn_sequence",sequenceName="T_XT_YH_GN_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "YH_ID", nullable = false, scale = 0)
	public Integer getYhId() {
		return this.yhId;
	}

	public void setYhId(Integer yhId) {
		this.yhId = yhId;
	}

	@Column(name = "GN_ID", nullable = false, scale = 0)
	public Integer getGnId() {
		return this.gnId;
	}

	public void setGnId(Integer gnId) {
		this.gnId = gnId;
	}

}