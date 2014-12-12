package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import models.Person;

public class PersonDAO {
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Reservation");
	EntityManager em = null;
	
	public PersonDAO()	{
		em = factory.createEntityManager();
	}
	
	public Person create(Person person) {
		em.getTransaction().begin();
		em.persist(person);
		em.getTransaction().commit();
		return person;
	}
	
	public void deleteByUserName(String username) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, username);
		em.remove(person);
		em.getTransaction().commit();
	}
	
	public Person updateFirstNameByUserName(String userName, String newFirstName) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, userName);
		person.setFirstName(newFirstName);
		em.merge(person);
		em.getTransaction().commit();
		return person;
	}
	
	public Person updateLastNameByUserName(String userName, String newLastName) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, userName);
		person.setLastName(newLastName);
		em.merge(person);
		em.getTransaction().commit();
		return person;
	}
	
	public Person updatePasswordByUserName(String userName, String newPassword) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, userName);
		person.setPassword(newPassword);
		em.merge(person);
		em.getTransaction().commit();
		return person;
	}
	
	public Person findByUserName(String userName) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, userName);
		em.getTransaction().commit();
		return person;
	}
	
	public List<Person> findByLastName(String lastName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findPersonByLastName");
		q.setParameter("lastName", lastName);
		List<Person> persons = q.getResultList();
		em.getTransaction().commit();
		return persons;
	}

	
	public List<Person> findByFirstName(String firstName) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findPersonByFirstName");
		q.setParameter("firstName", firstName);
		List<Person> persons = q.getResultList();
		em.getTransaction().commit();
		return persons;
	}


	public static void main(String[] args) {
		PersonDAO dao = new PersonDAO();
		System.out.println(dao.findByUserName("gsdz").getPassword());
	}
}
