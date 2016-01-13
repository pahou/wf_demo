package com.gdth.sys.entity;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TableMain entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TABLE_MAIN")
public class TableMain extends BaseEntity<Integer> {

	// Fields

	//public Integer id;
	public String name;
	public Byte age;
	public String sex;
	public String address;
	public Set<TableFollow> tableFollows = new HashSet<TableFollow>(0);

	// Constructors

	/** default constructor */
	public TableMain() {
	}

	/** minimal constructor */
	public TableMain(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TableMain(Integer id, String name, Byte age, String sex,
			String address, Set<TableFollow> tableFollows) {
		this.id = id;
		this.name = name;
		this.age = age;
		this.sex = sex;
		this.address = address;
		this.tableFollows = tableFollows;
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

	@Column(name = "NAME", length = 20)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "AGE", precision = 2, scale = 0)
	public Byte getAge() {
		return this.age;
	}

	public void setAge(Byte age) {
		this.age = age;
	}

	@Column(name = "SEX", length = 2)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "ADDRESS", length = 20)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tableMain")
	public Set<TableFollow> getTableFollows() {
		return this.tableFollows;
	}

	public void setTableFollows(Set<TableFollow> tableFollows) {
		this.tableFollows = tableFollows;
	}

}