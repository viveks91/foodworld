package managers;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import models.Reservation;
import dao.ReservationDAO;

public class ReservationManager implements Serializable{

	private ReservationDAO rsvtn_dao = new ReservationDAO();

	/**
	 * Creates the given reservation entity
	 * @param reservation
	 * @return id
	 */
	public int createReservation (Reservation reservation) {
		rsvtn_dao.create(reservation);
		return reservation.getId();
	}

	/**
	 * Finds the reservation with the given id
	 * @param id
	 * @return Reservation
	 */
	public Reservation findReservationById (int id) {
		Reservation reservation = rsvtn_dao.findById(id);
		return reservation;
	}

	/**
	 * Finds all the reservations with the given restaurant id
	 * @param rid
	 * @return List<Reservation>
	 */
	public List<Reservation> findReservationByRestaurantId (int rid) {
		List<Reservation> reservation = rsvtn_dao.findByRestaurantId(rid);
		return reservation;
	}

	/**
	 * Finds all the reservations with the given username
	 * @param userName
	 * @return List<Reservation>
	 */
	public List<Reservation> findReservationByUserName (String userName) {
		List<Reservation> reservation = rsvtn_dao.findByUserName(userName);
		return reservation;
	}

	/**
	 * Deletes Reservation with the given id
	 * @param id
	 */
	public void removeReservationById (int id) {
		if(findReservationById(id) != null) rsvtn_dao.deleteById(id);
	}

	/**
	 * Deletes all Reservations with the given restaurant id
	 * @param rid
	 */
	public void removeReservationByRestaurantId (int rid) {
		rsvtn_dao.deleteByRestaurantId(rid);
	}

	/**
	 * Deletes all Reservations with the given username
	 * @param userName
	 */
	public void removeReservationByUserName (String userName) {
		rsvtn_dao.deleteByUserName(userName);;
	}

	/**
	 * Updates the reservation with the given id to given values
	 * @param id
	 * @param people_count
	 * @param time
	 * @param restaurantId
	 * @param userName
	 * @return id
	 */
	public int updateReservationById (int id, int people_count, String time,String date) {
		int updated_id;
		updated_id = rsvtn_dao.updateById(id, people_count, time,date);
		return updated_id;
	}
}
