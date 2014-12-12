package models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity implementation class for Entity: Reservation
 * @author Vivek
 *
 */

@Entity
@NamedQueries({	
	@NamedQuery(
			name="Reservation.findReservationIdByRestaurantId", 
			query="select r.id from Reservation r where r.restaurantId = :rId"),
	@NamedQuery(
			name="Reservation.findReservationsByRestaurantId", 
			query="select r from Reservation r where r.restaurantId = :rId"),
	@NamedQuery(
			name="Reservation.findReservationIdByUserName", 
			query="select r.id from Reservation r where r.userName = :username"),
	@NamedQuery(
			name="Reservation.findReservationsByUserName", 
			query="select r from Reservation r where r.userName = :username"),
	@NamedQuery(
			name="Reservation.deleteReservationsByUserName", 
			query="delete from Reservation r where r.userName = :username"),
	@NamedQuery(
			name="Reservation.findReservationsAndDetailsByUserName", 
			query="select rt.name ,r.people_count,r.time,r.date,r.id,rt.imageURL, rt.id from Reservation r, "
					+ "Restaurant rt where r.userName = :username and r.restaurantId = rt.id"),
	@NamedQuery(
			name="Reservation.deleteReservationsByRestaurantId", 
			query="delete from Reservation r where r.restaurantId = :rId")})

public class Reservation implements Serializable {
	@Id
	private int id;
	private int people_count;

	private String date;
	
	private String time;
	private int restaurantId;
	private String userName;

	
	public Reservation(int people_count, String date, String time,
			int restaurantId, String userName) {
		super();
		this.people_count = people_count;
		this.date = date;
		this.time = time;
		this.restaurantId = restaurantId;
		this.userName = userName;
	}


	public Reservation(int id, int people_count, String date, String time,
			int restaurantId, String userName) {
		super();
		this.id = id;
		this.people_count = people_count;
		this.date = date;
		this.time = time;
		this.restaurantId = restaurantId;
		this.userName = userName;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getPeople_count() {
		return people_count;
	}


	public void setPeople_count(int people_count) {
		this.people_count = people_count;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}


	public int getRestaurantId() {
		return restaurantId;
	}


	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public Reservation() {
		super();
	}
	

}
