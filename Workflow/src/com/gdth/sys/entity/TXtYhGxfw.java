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
 * TXtYhGxfw entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_YH_GXFW")
public class TXtYhGxfw extends BaseEntity<Integer>{

	// Fields

	private Integer yhId;
	private Integer bmId;
	private String bmCcbh;

	// Constructors

	/** default constructor */
	public TXtYhGxfw() {
	}

	/** full constructor */
	public TXtYhGxfw(Integer id, Integer yhId, Integer bmId,
			String bmCcbh) {
		this.id = id;
		this.yhId = yhId;
		this.bmId = bmId;
		this.bmCcbh = bmCcbh;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="yh_gxfw_sequence")
    @SequenceGenerator(name="yh_gxfw_sequence",sequenceName="T_XT_YH_GXFW_SEQUENCE",allocationSize=1)
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

	@Column(name = "BM_ID", nullable = false, scale = 0)
	public Integer getBmId() {
		return this.bmId;
	}

	public void setBmId(Integer bmId) {
		this.bmId = bmId;
	}

	@Column(name = "BM_CCBH", nullable = false, length = 50)
	public String getBmCcbh() {
		return this.bmCcbh;
	}

	public void setBmCcbh(String bmCcbh) {
		this.bmCcbh = bmCcbh;
	}

}