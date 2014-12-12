package dao;

import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.City;

public class CityDAO implements Serializable {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public CityDAO()	{
		em = factory.createEntityManager();
	}
	
	/**
	 * Creates the city entity
	 * @param city
	 * @return String
	 */
	public String create(City city) {
		em.getTransaction().begin();
		em.persist(city);
		em.getTransaction().commit();
		return city.getCity();
	}

	/**
	 * Finds the given city
	 * @param city
	 * @return city
	 */
	public City findByCity(String city) {
		em.getTransaction().begin();
		City found_city = em.find(City.class, city);
		em.getTransaction().commit();
		return found_city;
	}

}
