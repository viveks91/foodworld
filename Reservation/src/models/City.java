package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Entity implementation class for Entity: City
 * @author Vivek
 *
 */

@Entity
public class City implements Serializable {
	
	@Id
	private String city;

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public City(String city) {
		super();
		this.city = city;
	}

	public City() {
		super();
	}
	
}
