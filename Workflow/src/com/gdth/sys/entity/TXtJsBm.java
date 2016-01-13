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
 * TXtJsBm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_JS_BM")
public class TXtJsBm extends BaseEntity<Integer>{

	// Fields

	private Integer jsId;
	private Integer bmId;

	// Constructors

	/** default constructor */
	public TXtJsBm() {
	}

	/** full constructor */
	public TXtJsBm(Integer id, Integer jsId, Integer bmId) {
		this.id = id;
		this.jsId = jsId;
		this.bmId = bmId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="js_bm_sequence")
    @SequenceGenerator(name="js_bm_sequence",sequenceName="T_XT_JS_BM_SEQUENCE",allocationSize=1)
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

	@Column(name = "BM_ID", nullable = false, scale = 0)
	public Integer getBmId() {
		return this.bmId;
	}

	public void setBmId(Integer bmId) {
		this.bmId = bmId;
	}

}