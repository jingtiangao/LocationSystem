package com.grain.entity;
// default package
// Generated 2016-5-20 13:50:23 by Hibernate Tools 5.1.0.Alpha1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TMiteidentify generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "t_miteidentify")
public class TMiteidentify implements java.io.Serializable {

	private String sm;
	private String kind;
	private String name;
	private Double longtitude;
	private Double latitude;
	private Double altitude;
	private String bintype;
	private String host;
	private String habitlocation;
	private String stage;
	private String collectdate;
	private String collector;
	private String slideproducer;
	private String identifier;
	private String reviewer;
	private String retianplace;

	@Id
	@Column(name = "sm", nullable = false, length = 30)
	public String getSm() {
		return this.sm;
	}

	public void setSm(String sm) {
		this.sm = sm;
	}

	@Column(name = "kind", length = 30)
	public String getKind() {
		return this.kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	@Column(name = "name", length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "longtitude", precision = 22, scale = 0)
	public Double getLongtitude() {
		return this.longtitude;
	}

	public void setLongtitude(Double longtitude) {
		this.longtitude = longtitude;
	}

	@Column(name = "latitude", precision = 22, scale = 0)
	public Double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	@Column(name = "altitude", precision = 22, scale = 0)
	public Double getAltitude() {
		return this.altitude;
	}

	public void setAltitude(Double altitude) {
		this.altitude = altitude;
	}

	@Column(name = "bintype", length = 30)
	public String getBintype() {
		return this.bintype;
	}

	public void setBintype(String bintype) {
		this.bintype = bintype;
	}

	@Column(name = "host", length = 30)
	public String getHost() {
		return this.host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	@Column(name = "habitlocation", length = 30)
	public String getHabitlocation() {
		return this.habitlocation;
	}

	public void setHabitlocation(String habitlocation) {
		this.habitlocation = habitlocation;
	}

	@Column(name = "stage", length = 30)
	public String getStage() {
		return this.stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	@Column(name = "collectdate", length = 30)
	public String getCollectdate() {
		return this.collectdate;
	}

	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}

	@Column(name = "collector", length = 30)
	public String getCollector() {
		return this.collector;
	}

	public void setCollector(String collector) {
		this.collector = collector;
	}

	@Column(name = "Slideproducer", length = 30)
	public String getSlideproducer() {
		return this.slideproducer;
	}

	public void setSlideproducer(String slideproducer) {
		this.slideproducer = slideproducer;
	}

	@Column(name = "identifier", length = 30)
	public String getIdentifier() {
		return this.identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	@Column(name = "reviewer", length = 30)
	public String getReviewer() {
		return this.reviewer;
	}

	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}

	@Column(name = "retianplace", length = 30)
	public String getRetianplace() {
		return this.retianplace;
	}

	public void setRetianplace(String retianplace) {
		this.retianplace = retianplace;
	}

}
