package com.gdth.sys.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * DemoMaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "DEMO_MASTER")
public class DemoMaster extends BaseEntity<Integer> {

	// Fields

	public String data1;
	public String data2;
	public String data3;
	public Set<Test3> test3s = new HashSet<Test3>(0);

	// Constructors

	/** default constructor */
	public DemoMaster() {
	}

	/** minimal constructor */
	public DemoMaster(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public DemoMaster(Integer id, String data1, String data2, String data3,
			Set<Test3> test3s) {
		this.id = id;
		this.data1 = data1;
		this.data2 = data2;
		this.data3 = data3;
		this.test3s = test3s;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="demo_sequence")
    @SequenceGenerator(name="demo_sequence",sequenceName="DEMO_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	@Column(name = "DATA3", length = 20)
	public String getData3() {
		return this.data3;
	}

	public void setData3(String data3) {
		this.data3 = data3;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "demoMaster")
	public Set<Test3> getTest3s() {
		return this.test3s;
	}

	public void setTest3s(Set<Test3> test3s) {
		this.test3s = test3s;
	}

}