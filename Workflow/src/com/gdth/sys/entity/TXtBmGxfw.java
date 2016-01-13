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
 * TXtBmGxfw entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_BM_GXFW")
public class TXtBmGxfw extends BaseEntity<Integer>{

	// Fields

	private Integer glbmId;
	private Integer bmId;
	private String bmCcbh;

	// Constructors

	/** default constructor */
	public TXtBmGxfw() {
	}


	public TXtBmGxfw(Integer glbmId, Integer bmId, String bmCcbh) {
		super();
		this.glbmId = glbmId;
		this.bmId = bmId;
		this.bmCcbh = bmCcbh;
	}


	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="bm_gxfw_sequence")
    @SequenceGenerator(name="bm_gxfw_sequence",sequenceName="T_XT_BM_GXFW_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "GLBM_ID", nullable = false, scale = 0)
	public Integer getGlbmId() {
		return this.glbmId;
	}

	public void setGlbmId(Integer glbmId) {
		this.glbmId = glbmId;
	}

	@Column(name = "BM_ID", nullable = false, scale = 0)
	public Integer getBmId() {
		return this.bmId;
	}

	public void setBmId(Integer bmId) {
		this.bmId = bmId;
	}

	@Column(name = "BM_CCBH", nullable = false, length = 50)
	public String getBmCcbh() {
		return bmCcbh;
	}

	
	public void setBmCcbh(String bmCcbh) {
		this.bmCcbh = bmCcbh;
	}

	

}