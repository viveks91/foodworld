package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Entity implementation class for Entity: State
 * @author Vivek
 *
 */

@Entity
public class State implements Serializable {
	
	@Id
	private String state;

	public State(String state) {
		super();
		this.state = state;
	}

	public State() {
		super();
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}
