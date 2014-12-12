package dao;

import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.Category;

public class CategoryDAO implements Serializable {
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public CategoryDAO()	{
		em = factory.createEntityManager();
	}
	
	/**
	 * Creates the category entity
	 * @param type
	 * @return String
	 */
	public String create(Category category) {
		em.getTransaction().begin();
		em.persist(category);
		em.getTransaction().commit();
		return category.getType();
	}
	
	/**
	 * Deletes the category with the given type
	 * @param type
	 */
	public void deleteByType(String type) {
		em.getTransaction().begin();
		Category found_type = em.find(Category.class, type);
		em.remove(found_type);
		em.getTransaction().commit();
	}
	
	/**
	 * Finds the category with the given type
	 * @param type
	 * @return Category
	 */
	public Category findByType(String type) {
		em.getTransaction().begin();
		Category found_type = em.find(Category.class, type);
		em.getTransaction().commit();
		return found_type;
	}
}
