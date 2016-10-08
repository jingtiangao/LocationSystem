package com.grain.entity;
// default package
// Generated 2016-5-20 13:50:23 by Hibernate Tools 5.1.0.Alpha1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TInsectsIdentify generated by hbm2java
 */
/**
 * 3.1 昆虫鉴定表
 * @author Mark
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "t_insects_identify")
public class TInsectsIdentify implements java.io.Serializable {

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
	private String identifier;
	private String reviewer;
	private String retainplace;

	@Id
	@Column(name = "sm", unique = true, nullable = false, length = 30)
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

	@Column(name = "Habitlocation", length = 30)
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

	@Column(name = "identifier", length = 30)
	public String getIdentifier() {
		return this.identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	@Column(name = "Reviewer", length = 30)
	public String getReviewer() {
		return this.reviewer;
	}

	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}

	@Column(name = "retainplace", length = 30)
	public String getRetainplace() {
		return this.retainplace;
	}

	public void setRetainplace(String retainplace) {
		this.retainplace = retainplace;
	}

}