package models;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * Address POJO
 * @author Preety
 *
 */

@Entity
public class User extends Person{

	private String emailId;
	private String phoneNo;
	private int addressId;
	
	
	public int getAddressId() {
		return addressId;
	}
	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}
	
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public User(String userName, String password, String firstName,
			String lastName, String emailId, String phoneNo, int addressId) {
		super(userName, password, firstName, lastName);
		this.emailId = emailId;
		this.phoneNo = phoneNo;
		this.addressId = addressId;
	}
	public User() {
		super();
	}
	
}
