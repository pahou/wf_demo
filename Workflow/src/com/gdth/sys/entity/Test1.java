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
 * Test1 entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TEST1")
public class Test1 extends BaseEntity<Integer>{

	// Fields

	public TXtYh TXtYh;
	public String data;

	// Constructors

	/** default constructor */
	public Test1() {
	}

	/** minimal constructor */
	public Test1(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Test1(Integer id, TXtYh TXtYh, String data) {
		this.id = id;
		this.TXtYh = TXtYh;
		this.data = data;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="test1_sequence")
    @SequenceGenerator(name="test1_sequence",sequenceName="TEST1_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "YH_ID")
	public TXtYh getTXtYh() {
		return this.TXtYh;
	}

	public void setTXtYh(TXtYh TXtYh) {
		this.TXtYh = TXtYh;
	}

	@Column(name = "DATA", length = 20)
	public String getData() {
		return this.data;
	}

	public void setData(String data) {
		this.data = data;
	}

}