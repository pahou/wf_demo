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
 * TXtJsYh entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_JS_YH")
public class TXtJsYh extends BaseEntity<Integer>{

	// Fields

	private Integer jsId;
	private Integer yhId;

	// Constructors

	/** default constructor */
	public TXtJsYh() {
	}

	/** minimal constructor */
	public TXtJsYh(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtJsYh(Integer id, Integer jsId, Integer yhId) {
		this.id = id;
		this.jsId = jsId;
		this.yhId = yhId;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="js_yh_sequence")
    @SequenceGenerator(name="js_yh_sequence",sequenceName="T_XT_JS_YH_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "JS_ID", scale = 0)
	public Integer getJsId() {
		return this.jsId;
	}

	public void setJsId(Integer jsId) {
		this.jsId = jsId;
	}

	@Column(name = "YH_ID", scale = 0)
	public Integer getYhId() {
		return this.yhId;
	}

	public void setYhId(Integer yhId) {
		this.yhId = yhId;
	}

}