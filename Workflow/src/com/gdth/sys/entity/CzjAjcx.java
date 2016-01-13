package com.gdth.sys.entity;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.gdth.base.entity.BaseEntity;

/**
 * CzjAjcx entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "CZJ_AJCX")
public class CzjAjcx extends BaseEntity<Integer> {

	// Fields

	//private Integer id;
	private String caseNumber;
	private String name;
	private String identityCard;
	private String localtion;
	private String happenTime;
	private String title;
	private String principal;
	private String detail;

	// Constructors

	/** default constructor */
	public CzjAjcx() {
	}

	/** minimal constructor */
	public CzjAjcx(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public CzjAjcx(Integer id, String caseNumber, String name,
			String identityCard, String localtion, String happenTime,
			String title, String principal, String detail) {
		this.id = id;
		this.caseNumber = caseNumber;
		this.name = name;
		this.identityCard = identityCard;
		this.localtion = localtion;
		this.happenTime = happenTime;
		this.title = title;
		this.principal = principal;
		this.detail = detail;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 19)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "CASE_NUMBER", length = 20)
	public String getCaseNumber() {
		return this.caseNumber;
	}

	public void setCaseNumber(String caseNumber) {
		this.caseNumber = caseNumber;
	}

	@Column(name = "NAME", length = 20)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "IDENTITY_CARD", length = 18)
	public String getIdentityCard() {
		return this.identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	@Column(name = "LOCALTION", length = 20)
	public String getLocaltion() {
		return this.localtion;
	}

	public void setLocaltion(String localtion) {
		this.localtion = localtion;
	}

	@Column(name = "HAPPEN_TIME")
	public String getHappenTime() {
		return this.happenTime;
	}

	public void setHappenTime(String happenTime) {
		this.happenTime = happenTime;
	}

	@Column(name = "TITLE", length = 200)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "PRINCIPAL", length = 20)
	public String getPrincipal() {
		return this.principal;
	}

	public void setPrincipal(String principal) {
		this.principal = principal;
	}

	@Column(name = "DETAIL", length = 1000)
	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}