package dao;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Reservation;

public class ReservationDAO implements Serializable {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public ReservationDAO()	{
		em = factory.createEntityManager();
	}
	
	/**
	 * Creates the reservation entity
	 * @param reservation
	 * @return id
	 */
	public Reservation create(Reservation reservation) {
		em.getTransaction().begin();
		em.persist(reservation);
		em.getTransaction().commit();
		return reservation;
	}
	
	/**
	 * Deletes the reservation with the given id
	 * @param id
	 */
	public void deleteById(int id) {
		em.getTransaction().begin();
		Reservation reservation = em.find(Reservation.class, id);
		em.remove(reservation);
		em.getTransaction().commit();
	}
	
	/**
	 * deletes the reservations with the given restaurant id
	 * @param rid
	 */
	public void deleteByRestaurantId(int rid) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reservation.findReservationIdByRestaurantId");
		q.setParameter("rId", rid);
		q.executeUpdate();
		em.getTransaction().commit();
	}
	
	/**
	 * Finds all the reservations with the given restaurant id
	 * @param rid
	 * @return List<Reservation>
	 */
	public List<Reservation> findByRestaurantId(int rid) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reservation.findReservationsByRestaurantId");
		q.setParameter("rId", rid);
		List<Reservation> found_reservations = q.getResultList();
		em.getTransaction().commit();
		return found_reservations;
	}
	
	/**
	 * deletes the reservations with the given username
	 * @param userName
	 */
	public void deleteByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reservation.deleteReservationsByUserName");
		q.setParameter("username", userName);
		q.executeUpdate();
		em.getTransaction().commit();
	}
	
	/**
	 * Finds all the reservations with the given username
	 * @param userName
	 * @return List<Reservation>
	 */
	public List<Reservation> findByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reservation.findReservationsByUserName");
		q.setParameter("username", userName);
		List<Reservation> found_reservations = q.getResultList();
		em.getTransaction().commit();
		return found_reservations;
	}
	
	public List<Object[]> findDetailsByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reservation.findReservationsAndDetailsByUserName");
		q.setParameter("username", userName);
		List<Object[]> reservations = q.getResultList();
		em.getTransaction().commit();
		return reservations;
	}
	/**
	 * Updates the reservation with the given id to given values
	 * @param id
	 * @param people_count
	 * @param time
	 * @return id
	 */
	public int updateById(int id, int people_count, String time,String date) {
		em.getTransaction().begin();
		Reservation reservation = em.find(Reservation.class, id);
		reservation.setPeople_count(people_count);
		reservation.setDate(date);
		reservation.setTime(time);
		em.merge(reservation);
		em.getTransaction().commit();
		return reservation.getId();
	}
	
	/**
	 * Finds the reservation with the given id
	 * @param id
	 * @return Reservation
	 */
	public Reservation findById(int id) {
		em.getTransaction().begin();
		Reservation reservation = em.find(Reservation.class, id);
		em.getTransaction().commit();
		return reservation;
	}
	
	public static void main(String[] args) {
		Reservation reservation = new Reservation(4,"2014-12-12","12:00",5,"vivek");
		ReservationDAO reservDao = new ReservationDAO();
		reservDao.create(reservation);
	}
}
