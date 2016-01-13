package com.gdth.sys.entity;

import java.util.Date;
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
 * GcGdxx entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "GC_GDXX")
public class GcGdxx extends BaseEntity<Integer> {

	// Fields

	private String gdmc;
	private String gddz;
	private String gdlxr;
	private String lxdh;
	private String azds;
	private String yys;
	private String sgtlj;
	private String htqdls;
	private String htjsr;
	private String htqdf;
	private String zt;
	private String bz;
	private Date lrSj;
	private String yhId;
	private Set<GcSbaz> gcSbazs = new HashSet<GcSbaz>(0);

	// Constructors

	/** default constructor */
	public GcGdxx() {
	}

	/** minimal constructor */
	public GcGdxx(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public GcGdxx(Integer id, String gdmc, String gddz, String gdlxr,
			String lxdh, String azds, String yys, String sgtlj, String htqdls,
			String htjsr, String htqdf, String zt, String bz, Date lrSj,
			String yhId, Set<GcSbaz> gcSbazs) {
		this.id = id;
		this.gdmc = gdmc;
		this.gddz = gddz;
		this.gdlxr = gdlxr;
		this.lxdh = lxdh;
		this.azds = azds;
		this.yys = yys;
		this.sgtlj = sgtlj;
		this.htqdls = htqdls;
		this.htjsr = htjsr;
		this.htqdf = htqdf;
		this.zt = zt;
		this.bz = bz;
		this.lrSj = lrSj;
		this.yhId = yhId;
		this.gcSbazs = gcSbazs;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="gcgdxx_sequence")
    @SequenceGenerator(name="gcgdxx_sequence",sequenceName="GC_GDXX_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "GDMC", length = 100)
	public String getGdmc() {
		return this.gdmc;
	}

	public void setGdmc(String gdmc) {
		this.gdmc = gdmc;
	}

	@Column(name = "GDDZ", length = 100)
	public String getGddz() {
		return this.gddz;
	}

	public void setGddz(String gddz) {
		this.gddz = gddz;
	}

	@Column(name = "GDLXR", length = 100)
	public String getGdlxr() {
		return this.gdlxr;
	}

	public void setGdlxr(String gdlxr) {
		this.gdlxr = gdlxr;
	}

	@Column(name = "LXDH", length = 100)
	public String getLxdh() {
		return this.lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	@Column(name = "AZDS", length = 100)
	public String getAzds() {
		return this.azds;
	}

	public void setAzds(String azds) {
		this.azds = azds;
	}

	@Column(name = "YYS", length = 100)
	public String getYys() {
		return this.yys;
	}

	public void setYys(String yys) {
		this.yys = yys;
	}

	@Column(name = "SGTLJ", length = 100)
	public String getSgtlj() {
		return this.sgtlj;
	}

	public void setSgtlj(String sgtlj) {
		this.sgtlj = sgtlj;
	}

	@Column(name = "HTQDLS", length = 50)
	public String getHtqdls() {
		return this.htqdls;
	}

	public void setHtqdls(String htqdls) {
		this.htqdls = htqdls;
	}

	@Column(name = "HTJSR", length = 50)
	public String getHtjsr() {
		return this.htjsr;
	}

	public void setHtjsr(String htjsr) {
		this.htjsr = htjsr;
	}

	@Column(name = "HTQDF", length = 50)
	public String getHtqdf() {
		return this.htqdf;
	}

	public void setHtqdf(String htqdf) {
		this.htqdf = htqdf;
	}

	@Column(name = "ZT", length = 100)
	public String getZt() {
		return this.zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	@Column(name = "BZ", length = 200)
	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Column(name = "LR_SJ")
	public Date getLrSj() {
		return this.lrSj;
	}

	public void setLrSj(Date lrSj) {
		this.lrSj = lrSj;
	}

	@Column(name = "YH_ID", length = 50)
	public String getYhId() {
		return this.yhId;
	}

	public void setYhId(String yhId) {
		this.yhId = yhId;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "gcGdxx")
	public Set<GcSbaz> getGcSbazs() {
		return this.gcSbazs;
	}

	public void setGcSbazs(Set<GcSbaz> gcSbazs) {
		this.gcSbazs = gcSbazs;
	}

}