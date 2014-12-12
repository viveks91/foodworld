package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;


/**
 * Entity implementation class for Entity: Category
 * @author Vivek
 *
 */
@Entity
public class Category implements Serializable {
	
	@Id
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Category(String type) {
		super();
		this.type = type;
	}

	public Category() {
		super();
	}
	

}
