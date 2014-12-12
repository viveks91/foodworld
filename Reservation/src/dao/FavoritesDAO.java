/**
 * 
 */
package dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Favorites;


/**
 * @author preetymishra
 *
 */
public class FavoritesDAO {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public FavoritesDAO()	{
		em = factory.createEntityManager();
	}
	public Favorites create(Favorites favorites) {
		em.getTransaction().begin();
		em.persist(favorites);
		em.getTransaction().commit();
		return favorites;
	}
	
	public void deleteByUserNameAndFavorites(String userName, int restaurantId) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Favorites.deleteByUserNameAndFavorites");
		q.setParameter("userName", userName);
		q.setParameter("restaurantId", restaurantId);
		q.executeUpdate();
		em.getTransaction().commit();
	}
	
	public List<Object[]> findByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("FavoritesRestaurants.findByUserName");
		q.setParameter("userName", userName);
		List<Object[]> favorites = q.getResultList();
		em.getTransaction().commit();
		return favorites;
	}
	
	public boolean isFav(String userName, int rId) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("FavoritesRestaurants.checkByUserName");
		q.setParameter("userName", userName);
		q.setParameter("rId", rId);
		List<Favorites> favorites = q.getResultList();
		em.getTransaction().commit();
		if (favorites.isEmpty()) return false;
		else return true;
	}
}
