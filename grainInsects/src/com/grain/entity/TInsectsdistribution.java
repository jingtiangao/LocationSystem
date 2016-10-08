package com.grain.entity;
// default package
// Generated 2016-5-20 13:50:23 by Hibernate Tools 5.1.0.Alpha1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TInsectsdistribution generated by hbm2java
 */
/**
 * 3.0.1 分布记录表
 * @author Mark
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "t_insectsdistribution")
public class TInsectsdistribution implements java.io.Serializable {

	private Long id;
	private TInsectscollectdistribution TInsectscollectdistribution;
	private String company;
	private Integer num;
	private String collectyear;
	private String collectmonth;

	public TInsectsdistribution() {
	}

	public TInsectsdistribution(String company, String collectyear, String collectmonth) {
		this.company = company;
		this.collectyear = collectyear;
		this.collectmonth = collectmonth;
	}

	public TInsectsdistribution(TInsectscollectdistribution TInsectscollectdistribution, String company, Integer num,
			String collectyear, String collectmonth) {
		this.TInsectscollectdistribution = TInsectscollectdistribution;
		this.company = company;
		this.num = num;
		this.collectyear = collectyear;
		this.collectmonth = collectmonth;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "ID", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "sm_insect")
	public TInsectscollectdistribution getTInsectscollectdistribution() {
		return this.TInsectscollectdistribution;
	}

	public void setTInsectscollectdistribution(TInsectscollectdistribution TInsectscollectdistribution) {
		this.TInsectscollectdistribution = TInsectscollectdistribution;
	}

	@Column(name = "company", nullable = false, length = 100)
	public String getCompany() {
		return this.company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	@Column(name = "num")
	public Integer getNum() {
		return this.num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Column(name = "collectyear", nullable = false, length = 4)
	public String getCollectyear() {
		return this.collectyear;
	}

	public void setCollectyear(String collectyear) {
		this.collectyear = collectyear;
	}

	@Column(name = "collectmonth", nullable = false, length = 2)
	public String getCollectmonth() {
		return this.collectmonth;
	}

	public void setCollectmonth(String collectmonth) {
		this.collectmonth = collectmonth;
	}

}