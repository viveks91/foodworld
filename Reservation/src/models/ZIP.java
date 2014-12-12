package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Entity implementation class for Entity: ZIP
 * @author Vivek
 *
 */

@Entity
public class ZIP implements Serializable{
	
	@Id
	private String zip;

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public ZIP(String zip) {
		super();
		this.zip = zip;
	}

	public ZIP() {
		super();
	}
	
}
