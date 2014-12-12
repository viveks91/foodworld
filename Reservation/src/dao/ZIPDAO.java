package dao;

import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.ZIP;

public class ZIPDAO implements Serializable {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public ZIPDAO()	{
		em = factory.createEntityManager();
	}
	
	/**
	 * Creates the zip entity
	 * @param zip
	 * @return String
	 */
	public String create(ZIP zip) {
		em.getTransaction().begin();
		em.persist(zip);
		em.getTransaction().commit();
		return zip.getZip();
	}

	/**
	 * Finds the given zip
	 * @param zip
	 * @return zip
	 */
	public ZIP findByZip(String zip) {
		em.getTransaction().begin();
		ZIP found_zip = em.find(ZIP.class, zip);
		em.getTransaction().commit();
		return found_zip;
	}

}