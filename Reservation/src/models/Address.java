package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;

/**
 * Entity implementation class for Entity: Address
 * @author Vivek
 *
 */
@Entity
@NamedQuery(
		name="Address.findByAll", 
		query="select a from Address a where a.street = :street and "
		+ "a.apt_No = :apt_No and a.city = :city and a.state =:state and a.zip =:zip")
public class Address implements Serializable {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String street;
	private String apt_No;
	private String city;
	private String state;
	private String zip;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getapt_No() {
		return apt_No;
	}
	public void setapt_No(String apt_No) {
		this.apt_No = apt_No;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public Address(Integer id, String street, String apt_No, String city,
			String state, String zip) {
		super();
		this.id = id;
		this.street = street;
		this.apt_No = apt_No;
		this.city = city;
		this.state = state;
		this.zip = zip;
	}
	public Address(String street, String apt_No, String city, String state,
			String zip) {
		super();
		this.street = street;
		this.apt_No = apt_No;
		this.city = city;
		this.state = state;
		this.zip = zip;
	}
	public Address() {
		super();
	}
	public Address(String street, String city, String state, String zip) {
		super();
		this.street = street;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.apt_No = null;
	}
	

}
