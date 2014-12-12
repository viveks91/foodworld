package models;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.InheritanceType;

/**
 * 
 * @author Preety
 *
 */
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
@NamedQueries({
	@NamedQuery(
		name="Person.findPersonByLastName",
		query="select p from Person p where p.lastName= :lastName"
	),
	@NamedQuery(
		name="Person.findPersonByFirstName",
        query="select p from Person p where p.firstName= :firstName"
	)
})

public class Person implements Serializable{
	
	@Id
	private String userName;
	
	private String password;
	private String firstName;
	private String lastName;
	
	public String toString()
	{
		return userName + " " + firstName + " " + lastName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Person(String userName, String password, String firstName,
			String lastName) {
		super();
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
	}
	public Person() {
		super();
	}
	
	

}
