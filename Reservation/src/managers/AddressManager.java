package managers;

import java.io.Serializable;
import java.util.List;

import models.Address;
import models.City;
import models.State;
import models.ZIP;
import dao.AddressDAO;
import dao.CityDAO;
import dao.StateDAO;
import dao.ZIPDAO;

public class AddressManager implements Serializable {
	
	private AddressDAO addr_dao = new AddressDAO();
	CityDAO citydao = null;
	StateDAO statedao = null;
	ZIPDAO zipdao = null;
	
	public AddressManager() {
		citydao = new CityDAO();
		statedao = new StateDAO();
		zipdao = new ZIPDAO();
	}
	
	/**
	 * Creates an address entity
	 * @param Address
	 * @return id
	 */
	public int createAddress (Address address) {
		// Create only if the address does not already exist
		List<Address> addresses= null;
		if((addresses = addr_dao.findByAddress(address)).isEmpty()) {

		City city = new City(address.getCity());
		State state = new State(address.getState());
		ZIP zip = new ZIP(address.getZip());
		
		if(citydao.findByCity(city.getCity()) == null)
			citydao.create(city);
		
		if(statedao.findByState(state.getState()) == null)
			statedao.create(state);
		
		if(zipdao.findByZip(zip.getZip()) == null)
			zipdao.create(zip);
		
		return addr_dao.create(address);
		
		}

		return addresses.get(0).getId();
	}
	
	/**
	 * Returns the Address of the given id
	 * @param id
	 * @return Address
	 */
	public Address findAddressById (int id) {
		Address address = addr_dao.findById(id);
		return address;
	}
	
	/**
	 * Updates the existing address with the given id to the given values
	 * @param id
	 * @param street
	 * @param apt_no
	 * @param city
	 * @param state
	 * @param zip
	 * @return id
	 */
	public int updateAddressById (int id, String street, String apt_no, String city, 
			String state, String zip) {
		int updated_id = id;
		City city1 = new City(city);
		State state1 = new State(state);
		ZIP zip1 = new ZIP(zip);
		
		if(citydao.findByCity(city) == null)
			citydao.create(city1);
		
		if(statedao.findByState(state) == null)
			statedao.create(state1);
		
		if(zipdao.findByZip(zip) == null)
			zipdao.create(zip1);
		
		if(findAddressById(id) != null)
			updated_id = addr_dao.updateById(id, street, apt_no, city, state, zip);
		return updated_id;
	}

}
