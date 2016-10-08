package com.grain.entity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.grain.CommonAttributes;
import com.grain.Principal;

/**
 * 磷化氢熏蒸总表
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "t_depot_phosphinefumigation")
public class DepotPhosphinefumigation implements java.io.Serializable {

	private Long id;
	private Graindepot graindepot;
	private Integer annual;
	private String device;
	private Integer cascale;
	private Character ifcirculation;
	private Float proportion;
	private Float fansys;
	private String brand;
	private Float dosage;
	private Float drugfee;
	private Float breathing;
	private Float subsidy;
	private Float pump;
	private Float otherfee;
	private Float alarmer;
	private Float detecter;
	private Float powerfee;
	private Float elsefee;
	private Integer totaldays;
	private Character generator;
	private Character inbin;
	private Character giver;
	private Character fancrossing;
	private String othergiveway;
	private String circulationway;
	private Float highestppm;
	private Integer targetdays;
	private Float avgtemperature;
	private Float highesttemperature;
	private Float lowesttemperature;
	private Float kindbefca;
	private Float densitybefca;
	private String kindafterca;
	private Float densityafterca;
	private String varconcentration;
	private Integer noninsects;
	private Character ifcage;
	private String cagekind;
	private Integer cagenum;
	private Character hasliveInsectsafter;
	private Float fattyvaluebef;
	private Float fattyvalueafter;
	private String elsecharacter;
	private String suggestion;
	private String reporter;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reportdate;
	private String modifier;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date modifytime;
	private String phone;//add by ghy 20160602


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lkbm", nullable = false)
	public Graindepot getGraindepot() {
		return this.graindepot;
	}

	public void setGraindepot(Graindepot graindepot) {
		this.graindepot = graindepot;
	}

	@Column(name = "Annual", nullable = false)
	public Integer getAnnual() {
		return this.annual;
	}

	public void setAnnual(Integer annual) {
		this.annual = annual;
	}

	@Column(name = "device", length = 100)
	public String getDevice() {
		return this.device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	@Column(name = "CAscale")
	public Integer getCascale() {
		return this.cascale;
	}

	public void setCascale(Integer cascale) {
		this.cascale = cascale;
	}

	@Column(name = "ifcirculation", length = 1)
	public Character getIfcirculation() {
		return this.ifcirculation;
	}

	public void setIfcirculation(Character ifcirculation) {
		this.ifcirculation = ifcirculation;
	}

	@Column(name = "proportion", precision = 12, scale = 0)
	public Float getProportion() {
		return this.proportion;
	}

	public void setProportion(Float proportion) {
		this.proportion = proportion;
	}

	@Column(name = "fansys", precision = 12, scale = 0)
	public Float getFansys() {
		return this.fansys;
	}

	public void setFansys(Float fansys) {
		this.fansys = fansys;
	}

	@Column(name = "brand", length = 100)
	public String getBrand() {
		return this.brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	@Column(name = "Dosage", precision = 12, scale = 0)
	public Float getDosage() {
		return this.dosage;
	}

	public void setDosage(Float dosage) {
		this.dosage = dosage;
	}

	@Column(name = "drugfee", precision = 12, scale = 0)
	public Float getDrugfee() {
		return this.drugfee;
	}

	public void setDrugfee(Float drugfee) {
		this.drugfee = drugfee;
	}

	@Column(name = "breathing", precision = 12, scale = 0)
	public Float getBreathing() {
		return this.breathing;
	}

	public void setBreathing(Float breathing) {
		this.breathing = breathing;
	}

	@Column(name = "subsidy", precision = 12, scale = 0)
	public Float getSubsidy() {
		return this.subsidy;
	}

	public void setSubsidy(Float subsidy) {
		this.subsidy = subsidy;
	}

	@Column(name = "pump", precision = 12, scale = 0)
	public Float getPump() {
		return this.pump;
	}

	public void setPump(Float pump) {
		this.pump = pump;
	}

	@Column(name = "otherfee", precision = 12, scale = 0)
	public Float getOtherfee() {
		return this.otherfee;
	}

	public void setOtherfee(Float otherfee) {
		this.otherfee = otherfee;
	}

	@Column(name = "alarmer", precision = 12, scale = 0)
	public Float getAlarmer() {
		return this.alarmer;
	}

	public void setAlarmer(Float alarmer) {
		this.alarmer = alarmer;
	}

	@Column(name = "detecter", precision = 12, scale = 0)
	public Float getDetecter() {
		return this.detecter;
	}

	public void setDetecter(Float detecter) {
		this.detecter = detecter;
	}

	@Column(name = "powerfee", precision = 12, scale = 0)
	public Float getPowerfee() {
		return this.powerfee;
	}

	public void setPowerfee(Float powerfee) {
		this.powerfee = powerfee;
	}

	@Column(name = "elsefee", precision = 12, scale = 0)
	public Float getElsefee() {
		return this.elsefee;
	}

	public void setElsefee(Float elsefee) {
		this.elsefee = elsefee;
	}

	@Column(name = "totaldays")
	public Integer getTotaldays() {
		return this.totaldays;
	}

	public void setTotaldays(Integer totaldays) {
		this.totaldays = totaldays;
	}

	@Column(name = "Generator", length = 1)
	public Character getGenerator() {
		return this.generator;
	}

	public void setGenerator(Character generator) {
		this.generator = generator;
	}

	@Column(name = "inbin", length = 1)
	public Character getInbin() {
		return this.inbin;
	}

	public void setInbin(Character inbin) {
		this.inbin = inbin;
	}

	@Column(name = "giver", length = 1)
	public Character getGiver() {
		return this.giver;
	}

	public void setGiver(Character giver) {
		this.giver = giver;
	}

	@Column(name = "fancrossing", length = 1)
	public Character getFancrossing() {
		return this.fancrossing;
	}

	public void setFancrossing(Character fancrossing) {
		this.fancrossing = fancrossing;
	}

	@Column(name = "othergiveway", length = 60)
	public String getOthergiveway() {
		return this.othergiveway;
	}

	public void setOthergiveway(String othergiveway) {
		this.othergiveway = othergiveway;
	}

	@Column(name = "circulationway", length = 20)
	public String getCirculationway() {
		return this.circulationway;
	}

	public void setCirculationway(String circulationway) {
		this.circulationway = circulationway;
	}

	@Column(name = "highestppm", precision = 12, scale = 0)
	public Float getHighestppm() {
		return this.highestppm;
	}

	public void setHighestppm(Float highestppm) {
		this.highestppm = highestppm;
	}

	@Column(name = "targetdays")
	public Integer getTargetdays() {
		return this.targetdays;
	}

	public void setTargetdays(Integer targetdays) {
		this.targetdays = targetdays;
	}

	@Column(name = "avgtemperature", precision = 12, scale = 0)
	public Float getAvgtemperature() {
		return this.avgtemperature;
	}

	public void setAvgtemperature(Float avgtemperature) {
		this.avgtemperature = avgtemperature;
	}

	@Column(name = "highesttemperature", precision = 12, scale = 0)
	public Float getHighesttemperature() {
		return this.highesttemperature;
	}

	public void setHighesttemperature(Float highesttemperature) {
		this.highesttemperature = highesttemperature;
	}

	@Column(name = "lowesttemperature", precision = 12, scale = 0)
	public Float getLowesttemperature() {
		return this.lowesttemperature;
	}

	public void setLowesttemperature(Float lowesttemperature) {
		this.lowesttemperature = lowesttemperature;
	}

	@Column(name = "kindbefca", precision = 12, scale = 0)
	public Float getKindbefca() {
		return this.kindbefca;
	}

	public void setKindbefca(Float kindbefca) {
		this.kindbefca = kindbefca;
	}

	@Column(name = "densitybefca", precision = 12, scale = 0)
	public Float getDensitybefca() {
		return this.densitybefca;
	}

	public void setDensitybefca(Float densitybefca) {
		this.densitybefca = densitybefca;
	}

	@Column(name = "kindafterca", length = 60)
	public String getKindafterca() {
		return this.kindafterca;
	}

	public void setKindafterca(String kindafterca) {
		this.kindafterca = kindafterca;
	}

	@Column(name = "densityafterca", precision = 12, scale = 0)
	public Float getDensityafterca() {
		return this.densityafterca;
	}

	public void setDensityafterca(Float densityafterca) {
		this.densityafterca = densityafterca;
	}

	@Column(name = "varconcentration", length = 60)
	public String getVarconcentration() {
		return this.varconcentration;
	}

	public void setVarconcentration(String varconcentration) {
		this.varconcentration = varconcentration;
	}

	@Column(name = "noninsects")
	public Integer getNoninsects() {
		return this.noninsects;
	}

	public void setNoninsects(Integer noninsects) {
		this.noninsects = noninsects;
	}

	@Column(name = "ifcage", length = 1)
	public Character getIfcage() {
		return this.ifcage;
	}

	public void setIfcage(Character ifcage) {
		this.ifcage = ifcage;
	}

	@Column(name = "cagekind", length = 60)
	public String getCagekind() {
		return this.cagekind;
	}

	public void setCagekind(String cagekind) {
		this.cagekind = cagekind;
	}

	@Column(name = "cagenum")
	public Integer getCagenum() {
		return this.cagenum;
	}

	public void setCagenum(Integer cagenum) {
		this.cagenum = cagenum;
	}

	@Column(name = "hasliveInsectsafter", length = 1)
	public Character getHasliveInsectsafter() {
		return this.hasliveInsectsafter;
	}

	public void setHasliveInsectsafter(Character hasliveInsectsafter) {
		this.hasliveInsectsafter = hasliveInsectsafter;
	}

	@Column(name = "fattyvaluebef", precision = 12, scale = 0)
	public Float getFattyvaluebef() {
		return this.fattyvaluebef;
	}

	public void setFattyvaluebef(Float fattyvaluebef) {
		this.fattyvaluebef = fattyvaluebef;
	}

	@Column(name = "fattyvalueafter", precision = 12, scale = 0)
	public Float getFattyvalueafter() {
		return this.fattyvalueafter;
	}

	public void setFattyvalueafter(Float fattyvalueafter) {
		this.fattyvalueafter = fattyvalueafter;
	}

	@Column(name = "elsecharacter", length = 100)
	public String getElsecharacter() {
		return this.elsecharacter;
	}

	public void setElsecharacter(String elsecharacter) {
		this.elsecharacter = elsecharacter;
	}

	@Column(name = "suggestion")
	public String getSuggestion() {
		return this.suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	@Column(name = "reporter", length = 60)
	public String getReporter() {
		return this.reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "reportdate", length = 10)
	public Date getReportdate() {
		return this.reportdate;
	}

	public void setReportdate(Date reportdate) {
		this.reportdate = reportdate;
	}

	@Column(name = "modifier", length = 60)
	public String getModifier() {
		return this.modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modifytime", length = 19)
	public Date getModifytime() {
		return this.modifytime;
	}

	public void setModifytime(Date modifytime) {
		this.modifytime = modifytime;
	}

	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	/**
	 * 持久化前处理
	 */
	@PrePersist
	public void prePersist() {
		SetModify();
	}
	
	/**
	 * 更新前处理
	 */
	@PreUpdate
	public void preUpdate() {
		SetModify();
	}
	
	private void SetModify(){
		RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
		if (requestAttributes != null) {
			HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
			Principal principal = (Principal) request.getSession().getAttribute(CommonAttributes.Principal);
			if (principal!=null){
				this.modifier = principal.getUsername();
				 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				this.modifytime = new Date();
			}
		}
	}

}
