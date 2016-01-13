package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.gdth.base.entity.BaseEntity;

/**
 * TXtCy entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XT_CY",  uniqueConstraints = @UniqueConstraint(columnNames = "TB_NAME"))
public class TXtCy extends BaseEntity<Integer>{

	// Fields

	private String procName;
	private String tbName;
	private Integer result;
	private String compareTime;
	private Integer database200;
	private Integer database249;

	// Constructors

	/** default constructor */
	public TXtCy() {
	}

	/** minimal constructor */
	public TXtCy(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TXtCy(Integer id, String procName, String tbName,
			Integer result, String compareTime, Integer database200,
			Integer database249) {
		this.id = id;
		this.procName = procName;
		this.tbName = tbName;
		this.result = result;
		this.compareTime = compareTime;
		this.database200 = database200;
		this.database249 = database249;
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

	@Column(name = "PROC_NAME", length = 50)
	public String getProcName() {
		return this.procName;
	}

	public void setProcName(String procName) {
		this.procName = procName;
	}

	@Column(name = "TB_NAME", unique = true, length = 50)
	public String getTbName() {
		return this.tbName;
	}

	public void setTbName(String tbName) {
		this.tbName = tbName;
	}

	@Column(name = "RESULT", scale = 0)
	public Integer getResult() {
		return this.result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	@Column(name = "COMPARE_TIME")
	public String getCompareTime() {
		return this.compareTime;
	}

	public void setCompareTime(String compareTime) {
		this.compareTime = compareTime;
	}

	@Column(name = "DATABASE200", scale = 0)
	public Integer getDatabase200() {
		return this.database200;
	}

	public void setDatabase200(Integer database200) {
		this.database200 = database200;
	}

	@Column(name = "DATABASE249", scale = 0)
	public Integer getDatabase249() {
		return this.database249;
	}

	public void setDatabase249(Integer database249) {
		this.database249 = database249;
	}

}