package dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Person;
import models.Reviews;

public class ReviewsDAO {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public ReviewsDAO()	{
		em = factory.createEntityManager();
	}
	
	public Reviews createReviews(Reviews reviews) {
		em.getTransaction().begin();
		em.persist(reviews);
		em.getTransaction().commit();
		return reviews;
	}
	
	public void deleteByReviewId(int id) {
		em.getTransaction().begin();
		Reviews reviews = em.find(Reviews.class, id);
		em.remove(reviews);
		em.getTransaction().commit();
	}
	
	public List<Reviews> deleteByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.deleteReviewByUserName");
		q.setParameter("userName", userName);
		List<Reviews> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public Reviews findByReviewId(int id) {
		em.getTransaction().begin();
		Reviews reviews = em.find(Reviews.class, id);
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Reviews> findByUserName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findAllReviewsByUserName");
		q.setParameter("userName", userName);
		List<Reviews> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Object[]> findAllReviewsWithRestaurantName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findAllReviewsWithRestaurantName");
		q.setParameter("userName", userName);
		List<Object[]> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Object[]> findFriendsReviewsWithRestaurantName(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findFriendsReviewsWithRestaurantName");
		q.setParameter("username", userName);
		List<Object[]> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Reviews> findByRestaurantId(int restaurantId) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findAllReviewsByRestaurantId");
		q.setParameter("restaurantId", restaurantId);
		List<Reviews> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Object[]> findWithRestaurantId(int restaurantId) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findAllReviewsWithRestaurantId");
		q.setParameter("rId", restaurantId);
		List<Object[]> reviews = q.getResultList();
		em.getTransaction().commit();
		return reviews;
	}
	
	public List<Object[]> fetchNewsFeed(String userName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Reviews.findFollowingUserReviews");
		q.setParameter("userName", userName);
		List<Object[]> newsfeed = q.getResultList();
		em.getTransaction().commit();
		return newsfeed;
	}

}
