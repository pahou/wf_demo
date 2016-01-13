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
 * Demo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "DEMO")
public class Demo extends BaseEntity<Integer> {

	// Fields

	public String abc1;
	public String abc2;
	public String abc3;
	public Set<Test4> test4s = new HashSet<Test4>(0);

	// Constructors

	/** default constructor */
	public Demo() {
	}

	/** minimal constructor */
	public Demo(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Demo(Integer id, String abc1, String abc2, String abc3,
			Set<Test4> test4s) {
		this.id = id;
		this.abc1 = abc1;
		this.abc2 = abc2;
		this.abc3 = abc3;
		this.test4s = test4s;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="demo2_sequence")
    @SequenceGenerator(name="demo2_sequence",sequenceName="DEMO2_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "ABC1", length = 20)
	public String getAbc1() {
		return this.abc1;
	}

	public void setAbc1(String abc1) {
		this.abc1 = abc1;
	}

	@Column(name = "ABC2", length = 20)
	public String getAbc2() {
		return this.abc2;
	}

	public void setAbc2(String abc2) {
		this.abc2 = abc2;
	}

	@Column(name = "ABC3", length = 20)
	public String getAbc3() {
		return this.abc3;
	}

	public void setAbc3(String abc3) {
		this.abc3 = abc3;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "demo")
	public Set<Test4> getTest4s() {
		return this.test4s;
	}

	public void setTest4s(Set<Test4> test4s) {
		this.test4s = test4s;
	}

}