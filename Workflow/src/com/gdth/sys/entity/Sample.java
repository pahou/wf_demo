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
 * Sample entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SAMPLE")
public class Sample extends BaseEntity<Integer> {

	// Fields

	private SampleBm3 sampleBm3;
	private SampleYh sampleYh;
	private SampleBm2 sampleBm2;
	private SampleBm sampleBm;

	// Constructors

	/** default constructor */
	public Sample() {
	}

	/** minimal constructor */
	public Sample(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Sample(Integer id, SampleBm3 sampleBm3, SampleYh sampleYh,
			SampleBm2 sampleBm2, SampleBm sampleBm) {
		this.id = id;
		this.sampleBm3 = sampleBm3;
		this.sampleYh = sampleYh;
		this.sampleBm2 = sampleBm2;
		this.sampleBm = sampleBm;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="sample_sequence")
    @SequenceGenerator(name="sample_sequence",sequenceName="SAMPLE_SEQUENCE",allocationSize=1)
	@Column(name = "ID", unique = true, nullable = false, precision = 22, scale = 0)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BM_ID3")
	public SampleBm3 getSampleBm3() {
		return this.sampleBm3;
	}

	public void setSampleBm3(SampleBm3 sampleBm3) {
		this.sampleBm3 = sampleBm3;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "YH_ID")
	public SampleYh getSampleYh() {
		return this.sampleYh;
	}

	public void setSampleYh(SampleYh sampleYh) {
		this.sampleYh = sampleYh;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BM_ID2")
	public SampleBm2 getSampleBm2() {
		return this.sampleBm2;
	}

	public void setSampleBm2(SampleBm2 sampleBm2) {
		this.sampleBm2 = sampleBm2;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "BM_ID1")
	public SampleBm getSampleBm() {
		return this.sampleBm;
	}

	public void setSampleBm(SampleBm sampleBm) {
		this.sampleBm = sampleBm;
	}

}