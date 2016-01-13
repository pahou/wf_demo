package com.gdth.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * Test3 entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TEST3")
public class Test3 extends BaseEntity<Integer> {

	// Fields

	public DemoMaster demoMaster;
	public String data1;
	public String data2;

	// Constructors

	/** default constructor */
	public Test3() {
	}

	/** minimal constructor */
	public Test3(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Test3(Integer id, DemoMaster demoMaster, String data1,
			String data2) {
		this.id = id;
		this.demoMaster = demoMaster;
		this.data1 = data1;
		this.data2 = data2;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="test3_sequence")
    @SequenceGenerator(name="test3_sequence",sequenceName="TEST3_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MS_ID")
	public DemoMaster getDemoMaster() {
		return this.demoMaster;
	}

	public void setDemoMaster(DemoMaster demoMaster) {
		this.demoMaster = demoMaster;
	}

	@Column(name = "DATA1", length = 20)
	public String getData1() {
		return this.data1;
	}

	public void setData1(String data1) {
		this.data1 = data1;
	}

	@Column(name = "DATA2", length = 20)
	public String getData2() {
		return this.data2;
	}

	public void setData2(String data2) {
		this.data2 = data2;
	}

}