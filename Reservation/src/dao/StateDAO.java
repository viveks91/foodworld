package dao;

import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.State;

public class StateDAO implements Serializable {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public StateDAO()	{
		em = factory.createEntityManager();
	}
	
	/**
	 * Creates the state entity
	 * @param state
	 * @return String
	 */
	public String create(State state) {
		em.getTransaction().begin();
		em.persist(state);
		em.getTransaction().commit();
		return state.getState();
	}

	/**
	 * Finds the given state
	 * @param state
	 * @return state
	 */
	public State findByState(String state) {
		em.getTransaction().begin();
		State found_state = em.find(State.class, state);
		em.getTransaction().commit();
		return found_state;
	}

}
