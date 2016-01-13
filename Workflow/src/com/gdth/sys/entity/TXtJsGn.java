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
 * TXtJsGn entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_JS_GN")
public class TXtJsGn extends BaseEntity<Integer>{

	// Fields

	private Integer jsId;
	private Integer gnId;

	// Constructors

	/** default constructor */
	public TXtJsGn() {
	}

	/** full constructor */
	public TXtJsGn(Integer id, Integer jsId, Integer gnId) {
		this.id = id;
		this.jsId = jsId;
		this.gnId = gnId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="jsgn_sequence")
    @SequenceGenerator(name="jsgn_sequence",sequenceName="T_XT_JS_GN_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "JS_ID", nullable = false, scale = 0)
	public Integer getJsId() {
		return this.jsId;
	}

	public void setJsId(Integer jsId) {
		this.jsId = jsId;
	}

	@Column(name = "GN_ID", nullable = false, scale = 0)
	public Integer getGnId() {
		return this.gnId;
	}

	public void setGnId(Integer gnId) {
		this.gnId = gnId;
	}

}