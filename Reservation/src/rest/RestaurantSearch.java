/**
 * 
 */
package rest;

import java.io.Serializable;


/**
 * @author Harshad
 *
 */
public class RestaurantSearch implements Serializable {
	private String name;
	private String phoneNo;
	private String website;
	private String openingTime;
	private String closingTime;
	private int capacity;
	private String address;
	private String placeId;
	private String priceLevel;
	private String ratings;
	private String imageURL;
	private int restaurantId;
	
	public int getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getPlaceId() {
		return placeId;
	}
	public void setPlaceId(String placeId) {
		this.placeId = placeId;
	}
	public String getPriceLevel() {
		return priceLevel;
	}
	public void setPriceLevel(String priceLevel) {
		this.priceLevel = priceLevel;
	}
	public String getRatings() {
		return ratings;
	}
	public void setRatings(String ratings) {
		this.ratings = ratings;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public RestaurantSearch(String name, String phoneNo, String website,
			String openingTime, String closingTime, int capacity,
			String address, String placeId, String priceLevel, String ratings,
			String imageURL) {
		super();
		this.name = name;
		this.phoneNo = phoneNo;
		this.website = website;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		this.capacity = capacity;
		this.address = address;
		this.placeId = placeId;
		this.priceLevel = priceLevel;
		this.ratings = ratings;
		this.imageURL = imageURL;
	}
	public RestaurantSearch() {
		super();
	}
	
}
