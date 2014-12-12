package rest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.xml.ws.WebServiceContext;

import managers.AddressManager;
import managers.ReservationManager;
import managers.RestaurantManager;
import models.Address;
import models.Person;
import models.Reservation;
import models.Restaurant;
import models.User;
import models.Following;
import dao.FollowingDAO;
import dao.PersonDAO;
import dao.ReservationDAO;
import dao.RestaurantDAO;
import dao.UserDAO;

class Login {
	public String userName;
	public String password;
}
// /rest/user
@Path("/user")
public class UserWebService {
	
	UserDAO usrDao = new UserDAO();
	PersonDAO psnDao = new PersonDAO();
	FollowingDAO follDao = new FollowingDAO();
	ReservationManager reservationMgr = new ReservationManager();
	ReservationDAO reservationDao = new ReservationDAO();
	
	@Resource
	private WebServiceContext context;
	
	public WebServiceContext getContext() {
		return context;
	}

	public void setContext(WebServiceContext context) {
		this.context = context;
	}

	//rest/user/login
	@POST
	@Consumes("application/json")
	@Path("/login")
	public String loginFunc (Login login, @Context HttpServletRequest req) {
		String userName = login.userName;
		String password = login.password;
		Person prsn = psnDao.findByUserName(userName);
		if (prsn == null)  {
			return "fail";
		}
		else if (prsn.getPassword().equals(password)){
			req.getSession().setAttribute("user", prsn);
			return "pass";
		}
		else {
			return "fail";
		}
	}
	
	@POST
	@Path("/follow/{username}")
	public void followUser(@PathParam("username") String toFollow, @Context HttpServletRequest req) {
		
		User user1 = (User)req.getSession().getAttribute("user");
		String userName = user1.getUserName();
		Following following = new Following(userName, toFollow);
		follDao.create(following);
	}
	
	@POST
	@Path("/unfollow/{username}")
	public void unfollowUser(@PathParam("username") String toFollow, @Context HttpServletRequest req) {
		
		User user1 = (User)req.getSession().getAttribute("user");
		String userName = user1.getUserName();
		follDao.deleteByUserNameAndFollowing(userName, toFollow);
	}
	
	@POST
	@Path("/logout")
	public void logoutSession(@Context HttpServletRequest req) {
		req.getSession().invalidate();
	}
	
	@POST
	@Path("/view/{username}")
	public String getUser(@PathParam("username") String userName, @Context HttpServletRequest req) {
		User user1 = usrDao.findByUserName(userName);
		if (user1 == null) return "no";
		else {
			req.getSession().setAttribute("viewuser", user1);
		}
		return "done";
	}
	
	
	@DELETE
	@Path("/delete")
	public void deleteUserForId(@Context HttpServletRequest req) {
		Person person = (Person)req.getSession().getAttribute("user");
		req.getSession().invalidate();
		psnDao.deleteByUserName(person.getUserName());
	}
	
	@POST
	@Path("/create")
	@Consumes("application/json")
	public String createUser (User newUser, @Context HttpServletRequest req) {
		if (usrDao.findByUserName(newUser.getUserName())== null) {
			User usr = usrDao.createUser(newUser);
			req.getSession().setAttribute("user", usr);
			return "user created";
		}
			return "exists";
	}
	
	@POST
	@Path("/createAdmin")
	@Consumes("application/json")
	public String createPerson(Person newAdmin, @Context HttpServletRequest req) {
		if (psnDao.findByUserName(newAdmin.getUserName())== null) {
			Person person = psnDao.create(newAdmin);
			req.getSession().setAttribute("user", person);
			return "admin created";
		}
		return "exists";
	}
	
	@PUT
	@Path("/update")
	@Consumes("application/json")
	public void updateUser(User newUser, @Context HttpServletRequest req) {
		psnDao.updateFirstNameByUserName(newUser.getUserName(),newUser.getFirstName());
		psnDao.updateLastNameByUserName(newUser.getUserName(), newUser.getLastName());
		User updated = usrDao.updateByUserName(newUser.getUserName(), newUser.getPhoneNo(), newUser.getEmailId(), newUser.getAddressId());
		req.getSession().invalidate();
		req.getSession().setAttribute("user", updated);
	}
	
	@POST
	@Path("/reserve")
	@Consumes("application/json")
	public String createReservationAndRestaurant(Reservation reservation,
			@Context HttpServletRequest req) {

		Address address1 = new Address();
		AddressManager addrmgr = new AddressManager();
		Restaurant restaurant = new Restaurant();
		RestaurantManager restaurantMgr = new RestaurantManager();
		reservationDao = new ReservationDAO();

		RestaurantSearch selected = (RestaurantSearch)req.getSession()
				.getAttribute("selectedRestaurant");
		
		int path =  (Integer)req.getSession()
				.getAttribute("path");
		
		if (path==1) {

		String address = selected.getAddress();
		String addressParts[] = address.split(",");
		String streetPart = addressParts[0];
		String apt_no = streetPart.substring(0, streetPart.indexOf(' '));
		String street = streetPart.substring(streetPart.indexOf(' ')+1);
		String city = addressParts[1];
		String stateString = addressParts[2];
		String stateString1[] = stateString.split(" ");
		String state = stateString1[1];
		String zip = stateString1[2];
		address1.setapt_No(apt_no);
		address1.setStreet(street);
		address1.setCity(city);
		address1.setState(state);
		address1.setZip(zip);

		int addId = addrmgr.createAddress(address1);
		restaurant.setAddressId(addId);

		restaurant.setCapacity(50);
		restaurant.setClosingTime(selected.getClosingTime());
		restaurant.setOpeningTime(selected.getOpeningTime());
		restaurant.setName(selected.getName());
		restaurant.setPhoneNo(selected.getPhoneNo());
		restaurant.setType("Restaurant");
		restaurant.setWebsite(selected.getWebsite());
		restaurant.setPriceLevel(Integer.valueOf(selected.getPriceLevel()));
		restaurant.setImageURL(selected.getImageURL());
		restaurant.setRating(selected.getRatings());
		
		int restaurantId = restaurantMgr.createRestaurant(restaurant);
		reservation.setRestaurantId(restaurantId);
		reservationDao.create(reservation);
		
		} else {
			
			reservation.setRestaurantId(selected.getRestaurantId());
			reservationDao.create(reservation);
		
		}

		return "Reservation booked";

	}
	
	@DELETE
	@Path("/reservation/{id}")
	public void getmyReservations(@PathParam("id") int id, @Context HttpServletRequest req) {
	reservationMgr.removeReservationById(id);
	}
	
	@PUT
	@Path("/forupdateReservation/{id}")
	public void forupdateReservations(@PathParam("id") int id, @Context HttpServletRequest req) {
	Reservation reserv= reservationMgr.findReservationById(id);
	req.getSession().setAttribute("reservationDetails", reserv);
	}

	@PUT
	@Path("/updatereservation")
	public void updateReservations(Reservation reservation, @Context HttpServletRequest req) {
	reservationMgr.updateReservationById(reservation.getId(), reservation.getPeople_count(), reservation.getTime(), reservation.getDate());

	}


}
