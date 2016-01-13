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
 * SampleBm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SAMPLE_BM")
public class SampleBm extends BaseEntity<Integer> {

	// Fields

	public String bh;
	public String fbh;
	public String mc;
	public String yhbh;
	public String bz;
	public String dfjb;
	public String xzqhbh;
	public String jc;
	public Integer fid;
	public String fmc;
	public String ccbh;
	public String swbmBj;
	public Short jssl;
	public String lrSj;
	public String yhZh;
	public String yhXm;
	public String bmBh;
	public String bmMc;
	public String bmCcbh;
	public String zt;
	public String xgSj;
	public String xgyhZh;
	public String scSj;
	public String scyhZh;
	public Set<SampleYh> sampleYhs = new HashSet<SampleYh>(0);

	// Constructors

	/** default constructor */
	public SampleBm() {
	}

	/** minimal constructor */
	public SampleBm(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public SampleBm( String bh, String fbh, String mc,
			String yhbh, String bz, String dfjb, String xzqhbh, String jc,
			Integer fid, String fmc, String ccbh, String swbmBj, Short jssl,
			String lrSj, String yhZh, String yhXm, String bmBh, String bmMc,
			String bmCcbh, String zt, String xgSj, String xgyhZh, String scSj,
			String scyhZh, Set<SampleYh> sampleYhs) {
		super();
		//this.id = id;
		this.bh = bh;
		this.fbh = fbh;
		this.mc = mc;
		this.yhbh = yhbh;
		this.bz = bz;
		this.dfjb = dfjb;
		this.xzqhbh = xzqhbh;
		this.jc = jc;
		this.fid = fid;
		this.fmc = fmc;
		this.ccbh = ccbh;
		this.swbmBj = swbmBj;
		this.jssl = jssl;
		this.lrSj = lrSj;
		this.yhZh = yhZh;
		this.yhXm = yhXm;
		this.bmBh = bmBh;
		this.bmMc = bmMc;
		this.bmCcbh = bmCcbh;
		this.zt = zt;
		this.xgSj = xgSj;
		this.xgyhZh = xgyhZh;
		this.scSj = scSj;
		this.scyhZh = scyhZh;
		sampleYhs = sampleYhs;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="sample_bm_sequence")
    @SequenceGenerator(name="sample_bm_sequence",sequenceName="SAMPLE_BM_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "BH", length = 20)
	public String getBh() {
		return this.bh;
	}

	public void setBh(String bh) {
		this.bh = bh;
	}

	@Column(name = "FBH", length = 20)
	public String getFbh() {
		return this.fbh;
	}

	public void setFbh(String fbh) {
		this.fbh = fbh;
	}

	@Column(name = "MC", length = 100)
	public String getMc() {
		return this.mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	@Column(name = "YHBH", length = 20)
	public String getYhbh() {
		return this.yhbh;
	}

	public void setYhbh(String yhbh) {
		this.yhbh = yhbh;
	}

	@Column(name = "BZ", length = 200)
	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Column(name = "DFJB", length = 20)
	public String getDfjb() {
		return this.dfjb;
	}

	public void setDfjb(String dfjb) {
		this.dfjb = dfjb;
	}

	@Column(name = "XZQHBH", length = 10)
	public String getXzqhbh() {
		return this.xzqhbh;
	}

	public void setXzqhbh(String xzqhbh) {
		this.xzqhbh = xzqhbh;
	}

	@Column(name = "JC", length = 50)
	public String getJc() {
		return this.jc;
	}

	public void setJc(String jc) {
		this.jc = jc;
	}

	@Column(name = "FID", precision = 22, scale = 0)
	public Integer getFid() {
		return this.fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	@Column(name = "FMC", length = 100)
	public String getFmc() {
		return this.fmc;
	}

	public void setFmc(String fmc) {
		this.fmc = fmc;
	}

	@Column(name = "CCBH", length = 50)
	public String getCcbh() {
		return this.ccbh;
	}

	public void setCcbh(String ccbh) {
		this.ccbh = ccbh;
	}

	@Column(name = "SWBM_BJ", length = 1)
	public String getSwbmBj() {
		return this.swbmBj;
	}

	public void setSwbmBj(String swbmBj) {
		this.swbmBj = swbmBj;
	}

	@Column(name = "JSSL", precision = 3, scale = 0)
	public Short getJssl() {
		return this.jssl;
	}

	public void setJssl(Short jssl) {
		this.jssl = jssl;
	}

	@Column(name = "LR_SJ")
	public String getLrSj() {
		return this.lrSj;
	}

	public void setLrSj(String lrSj) {
		this.lrSj = lrSj;
	}

	@Column(name = "YH_ZH", length = 50)
	public String getYhZh() {
		return this.yhZh;
	}

	public void setYhZh(String yhZh) {
		this.yhZh = yhZh;
	}

	@Column(name = "YH_XM", length = 50)
	public String getYhXm() {
		return this.yhXm;
	}

	public void setYhXm(String yhXm) {
		this.yhXm = yhXm;
	}

	@Column(name = "BM_BH", length = 50)
	public String getBmBh() {
		return this.bmBh;
	}

	public void setBmBh(String bmBh) {
		this.bmBh = bmBh;
	}

	@Column(name = "BM_MC", length = 50)
	public String getBmMc() {
		return this.bmMc;
	}

	public void setBmMc(String bmMc) {
		this.bmMc = bmMc;
	}

	@Column(name = "BM_CCBH", length = 50)
	public String getBmCcbh() {
		return this.bmCcbh;
	}

	public void setBmCcbh(String bmCcbh) {
		this.bmCcbh = bmCcbh;
	}

	@Column(name = "ZT", length = 1)
	public String getZt() {
		return this.zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	@Column(name = "XG_SJ")
	public String getXgSj() {
		return this.xgSj;
	}

	public void setXgSj(String xgSj) {
		this.xgSj = xgSj;
	}

	@Column(name = "XGYH_ZH", length = 50)
	public String getXgyhZh() {
		return this.xgyhZh;
	}

	public void setXgyhZh(String xgyhZh) {
		this.xgyhZh = xgyhZh;
	}

	@Column(name = "SC_SJ")
	public String getScSj() {
		return this.scSj;
	}

	public void setScSj(String scSj) {
		this.scSj = scSj;
	}

	@Column(name = "SCYH_ZH", length = 50)
	public String getScyhZh() {
		return this.scyhZh;
	}

	public void setScyhZh(String scyhZh) {
		this.scyhZh = scyhZh;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sampleBm")
	public Set<SampleYh> getSampleYhs() {
		return this.sampleYhs;
	}

	public void setSampleYhs(Set<SampleYh> sampleYhs) {
		this.sampleYhs = sampleYhs;
	}

}