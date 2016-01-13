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
 * Test4 entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TEST4")
public class Test4 extends BaseEntity<Integer> {

	// Fields

	public Demo demo;
	public String test1;
	public String test2;

	// Constructors

	/** default constructor */
	public Test4() {
	}

	/** minimal constructor */
	public Test4(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Test4(Integer id, Demo demo, String test1, String test2) {
		this.id = id;
		this.demo = demo;
		this.test1 = test1;
		this.test2 = test2;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="test4_sequence")
    @SequenceGenerator(name="test4_sequence",sequenceName="TEST4_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MS_ID")
	public Demo getDemo() {
		return this.demo;
	}

	public void setDemo(Demo demo) {
		this.demo = demo;
	}

	@Column(name = "TEST1", length = 20)
	public String getTest1() {
		return this.test1;
	}

	public void setTest1(String test1) {
		this.test1 = test1;
	}

	@Column(name = "TEST2", length = 20)
	public String getTest2() {
		return this.test2;
	}

	public void setTest2(String test2) {
		this.test2 = test2;
	}

}