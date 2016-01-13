package com.gdth.sys.entity;

import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * TableFollow entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TABLE_FOLLOW")
public class TableFollow extends BaseEntity<Integer> {

	// Fields

	//public Integer id;
	public TableMain tableMain;
	public String product;
	public Integer price;
	public Integer orderid;

	// Constructors

	/** default constructor */
	public TableFollow() {
	}

	/** minimal constructor */
	public TableFollow(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public TableFollow(Integer id, TableMain tableMain, String product,
			Integer price, Integer orderid) {
		this.id = id;
		this.tableMain = tableMain;
		this.product = product;
		this.price = price;
		this.orderid = orderid;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MAIN_ID")
	public TableMain getTableMain() {
		return this.tableMain;
	}

	public void setTableMain(TableMain tableMain) {
		this.tableMain = tableMain;
	}

	@Column(name = "PRODUCT", length = 20)
	public String getProduct() {
		return this.product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	@Column(name = "PRICE", scale = 0)
	public Integer getPrice() {
		return this.price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	@Column(name = "ORDERID", scale = 0)
	public Integer getOrderid() {
		return this.orderid;
	}

	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}

}