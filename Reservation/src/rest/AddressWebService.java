package rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import models.Address;
import managers.AddressManager;

@Path("/address")
public class AddressWebService {
	
	AddressManager addrmgr = new AddressManager();
	
	@POST
	@Path("/create")
	@Consumes("application/json")
	@Produces("application/json")
	public Address createAddress(Address newAddress) {

		int id = addrmgr.createAddress(newAddress);
		newAddress.setId(id);
		return newAddress;
	}
	
	@PUT
	@Path("/update")
	@Consumes("application/json")
	public void updateAddress(Address newAddress) {
		addrmgr.updateAddressById(newAddress.getId(),newAddress.getStreet(),newAddress.getapt_No(),newAddress.getCity(), newAddress.getState(), newAddress.getZip());
	}

}
