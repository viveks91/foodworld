package models;

import java.io.Serializable;
//import java.sql.Date;
//import java.sql.Time;
import java.util.Date;












import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity implementation class for Entity: Restaurant
 * @author Vivek
 *
 */

@Entity
@NamedQuery(
		name="Restaurant.findByAll", 
		query="select r from Restaurant r where r.name = :name and "
				+ "r.website =:website and r.phoneNo =:phoneNo and r.addressId =:addrId")
public class Restaurant implements Serializable {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	private String phoneNo;
	private String website;
	private String openingTime;
	private String closingTime;
	private int capacity;
	private String type;
	private int addressId;
	private String imageURL;
	private int priceLevel;
	private String rating;

	
	public Restaurant(int id, String name, String phoneNo, String website,
			String openingTime, String closingTime, int capacity, String type,
			int addressId, String imageURL, int priceLevel, String rating) {
		super();
		this.id = id;
		this.name = name;
		this.phoneNo = phoneNo;
		this.website = website;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		this.capacity = capacity;
		this.type = type;
		this.addressId = addressId;
		this.imageURL = imageURL;
		this.priceLevel = priceLevel;
		this.rating = rating;
	}


	public Restaurant(String name, String phoneNo, String website,
			String openingTime, String closingTime, int capacity, String type,
			int addressId, String imageURL, int priceLevel, String rating) {
		super();
		this.name = name;
		this.phoneNo = phoneNo;
		this.website = website;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		this.capacity = capacity;
		this.type = type;
		this.addressId = addressId;
		this.imageURL = imageURL;
		this.priceLevel = priceLevel;
		this.rating = rating;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getWebsite() {
		return website;
	}


	public void setWebsite(String website) {
		this.website = website;
	}


	public String getOpeningTime() {
		return openingTime;
	}


	public void setOpeningTime(String openingTime) {
		this.openingTime = openingTime;
	}


	public String getClosingTime() {
		return closingTime;
	}


	public void setClosingTime(String closingTime) {
		this.closingTime = closingTime;
	}


	public int getCapacity() {
		return capacity;
	}


	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public int getAddressId() {
		return addressId;
	}


	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}


	public String getImageURL() {
		return imageURL;
	}


	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}


	public int getPriceLevel() {
		return priceLevel;
	}


	public void setPriceLevel(int priceLevel) {
		this.priceLevel = priceLevel;
	}


	public String getRating() {
		return rating;
	}


	public void setRating(String rating) {
		this.rating = rating;
	}


	public Restaurant() {
		super();
	}

}
