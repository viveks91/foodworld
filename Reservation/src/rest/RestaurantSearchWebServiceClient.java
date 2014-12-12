package rest;
/**
 * @author Harshad
 *
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.xml.ws.WebServiceContext;

import managers.AddressManager;
import models.Address;
import models.Favorites;
import models.Restaurant;
import models.Reviews;
import models.User;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.FavoritesDAO;
import dao.RestaurantDAO;
import dao.ReviewsDAO;

// /rest/search
@Path("/search")
public class RestaurantSearchWebServiceClient implements Serializable {

	@Resource
	private WebServiceContext context;

	public WebServiceContext getContext() {
		return context;
	}

	public void setContext(WebServiceContext context) {
		this.context = context;
	}

	private String urlAPIPlaces = "https://maps.googleapis.com/maps/api/place/textsearch/json?query={NAME}+restaurants+in+{LOCATION}&key={KEY}";
	private String urlAPIPlaceDetails ="https://maps.googleapis.com/maps/api/place/details/json?placeid={PLACE}&key={KEY}";
	private String urlAPIPhoto="https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference={PHOTO_REF}&key={KEY}";

	@GET
	@Path("/{searchParameters}")
	public void getParameters(@PathParam("searchParameters") String searchParameters, @Context HttpServletRequest req){
		String[] parts = searchParameters.split(",");
		req.getSession().setAttribute("searchResults", null);

		String restaurantName = parts[0];
		String location;
		if (parts.length == 1) location = "+";
		else location = parts[1];

		List<RestaurantSearch> searchResult = null;
		searchResult = getRestaurantByNameAndLocation(restaurantName, location);
		if (searchResult!=null)
		 req.getSession().setAttribute("searchResults", searchResult);
	}

	public List<RestaurantSearch> getRestaurantByNameAndLocation(String name, String location) {
		name = name.replace(" ", "+");
		location = location.replace(" ", "+");

		String urlStr = urlAPIPlaces.replace("{NAME}+restaurants+in+{LOCATION}", name
				+ "+restaurants+in+" + location);
		List<RestaurantSearch> searchResults= new ArrayList<RestaurantSearch>();
		try {
			URL url = new URL(urlStr);
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			InputStream stream = connection.getInputStream();
			InputStreamReader reader = new InputStreamReader(stream);
			BufferedReader buffer = new BufferedReader(reader);

			String json = "";
			String line = "";

			while ((line = buffer.readLine()) != null) {
				json += line;
			}
			JSONParser parser = new JSONParser();
			try {
				JSONObject root = (JSONObject) parser.parse(json);
				JSONArray results = (JSONArray) root.get("results");
				if(!results.isEmpty()){
					int size=results.size();
					for (int i=0;i<size;i++)
					{
						RestaurantSearch restaurant = new RestaurantSearch();
						JSONObject restaurantObj = (JSONObject) results.get(i);
						if(restaurantObj!=null){
							String placeId = restaurantObj.get("place_id").toString();
							String restaurantName=restaurantObj.get("name").toString();
							String address=restaurantObj.get("formatted_address").toString();
							String priceLevel;
							try{
								priceLevel=restaurantObj.get("price_level").toString();
							}catch(NullPointerException ne){
								priceLevel="Not Available";
							}
							String rating;
							try{
								rating = restaurantObj.get("rating").toString();
							}catch(NullPointerException ne){
								rating = "Not Available";
							}

							String imageURL;
							try{
								JSONArray photos = (JSONArray) restaurantObj.get("photos");
								JSONObject photoObj = (JSONObject) photos.get(0);
								String photo_reference = photoObj.get("photo_reference").toString();
								imageURL = urlAPIPhoto.replace("{PHOTO_REF}", photo_reference);
							}catch(Exception e){
								imageURL="http://img2.wikia.nocookie.net/__cb20130511180903/legendmarielu/images/b/b4/No_image_available.jpg";
							}
							restaurant.setPlaceId(placeId);
							restaurant.setName(restaurantName);
							restaurant.setAddress(address);
							restaurant.setPriceLevel(priceLevel);
							restaurant.setRatings(rating);
							restaurant.setImageURL(imageURL);
							searchResults.add(restaurant);
						}
					}
					return searchResults;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}catch (IndexOutOfBoundsException io) {
				io.printStackTrace();
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@GET
	@Path("/details/{placeId}")
	public void getPlaceDetails(@PathParam("placeId") String placeId, @Context HttpServletRequest req) {
		String placeDetailURL = urlAPIPlaceDetails.replace("{PLACE}", placeId);
		int day = 0;
		RestaurantSearch restaurant = new RestaurantSearch();
		try {
			URL url = new URL(placeDetailURL);
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			InputStream stream = connection.getInputStream();
			InputStreamReader reader = new InputStreamReader(stream);
			BufferedReader buffer = new BufferedReader(reader);
			String json = "";
			String line = "";
			int capacity = 50;
			while ((line = buffer.readLine()) != null) {
				json += line;
			}
			JSONParser parser = new JSONParser();
			try {
				JSONObject root = (JSONObject) parser.parse(json);
				JSONObject restaurantResult = (JSONObject) root.get("result");

				if(restaurantResult!=null)
				{
					String address = restaurantResult.get("formatted_address").toString();
					String phoneNo;
					try{
						phoneNo = (String) restaurantResult.get("formatted_phone_number");
					}catch(NullPointerException ne){
						phoneNo = "Not Available";
					}
					String restaurantURL;
					try{
						restaurantURL = (String) restaurantResult.get("website");
					}catch(NullPointerException ne){
						restaurantURL = "Not Available";
					}
					String name = restaurantResult.get("name").toString();

					String closeRestaurantTime;
					String openRestaurantTime;

					try{
						JSONObject timings = (JSONObject) restaurantResult.get("opening_hours");
						JSONArray periods = (JSONArray) timings.get("periods");
						JSONObject dayTimings = (JSONObject) periods.get(day);
						JSONObject closeTime = (JSONObject) dayTimings.get("close");
						JSONObject openTime = (JSONObject) dayTimings.get("open");

						closeRestaurantTime = closeTime.get("time").toString();
						StringBuilder sb = new StringBuilder(closeRestaurantTime);
						closeRestaurantTime = sb.insert(2, ":").toString();
						openRestaurantTime = openTime.get("time").toString();
						sb = new StringBuilder(openRestaurantTime);
						openRestaurantTime = sb.insert(2, ":").toString();
					}catch(NullPointerException ne){
						closeRestaurantTime = "Not Available";
						openRestaurantTime = "Not Available";
					}

					String priceLevel;
					try{
						priceLevel=restaurantResult.get("price_level").toString();
					}catch(NullPointerException ne){
						priceLevel="Not Available";
					}
					String rating;
					try{
						rating = restaurantResult.get("rating").toString();
					}catch(NullPointerException ne){
						rating = "Not Available";
					}
					String imageURL;

					try{
						JSONArray photos = (JSONArray) restaurantResult.get("photos");
						JSONObject photoObj = (JSONObject) photos.get(0);
						String photo_reference = photoObj.get("photo_reference").toString();
						imageURL = urlAPIPhoto.replace("{PHOTO_REF}", photo_reference);
					}catch(Exception e){
						imageURL="Not Available";
					}
						restaurant.setPlaceId(placeId);
						restaurant.setName(name);
						restaurant.setWebsite(restaurantURL);
						restaurant.setAddress(address);
						restaurant.setPhoneNo(phoneNo);
						restaurant.setCapacity(capacity);
						restaurant.setOpeningTime(openRestaurantTime);
						restaurant.setClosingTime(closeRestaurantTime);
						restaurant.setRatings(rating);
						restaurant.setPriceLevel(priceLevel);
						restaurant.setImageURL(imageURL);
						restaurant.setRestaurantId(-1);

						req.getSession().setAttribute("selectedRestaurant", restaurant);
						req.getSession().setAttribute("path", 1);
				}
			} catch (ParseException pe) {
				pe.printStackTrace();
			}
			catch (NullPointerException ne) {
				System.out.println("NE Ignore");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@POST
	@Path("/addtofav")
	public void addToFavorites(@Context HttpServletRequest req) {

		RestaurantSearch selected = (RestaurantSearch)req.getSession().getAttribute("selectedRestaurant");
		User user = (User)req.getSession().getAttribute("user");
		Favorites favorite = new Favorites(user.getUserName(), selected.getRestaurantId());
		FavoritesDAO favDao = new FavoritesDAO();
		favDao.create(favorite);
	}

	@POST
	@Path("/fav/{value}")
	public void makeRestaurantSearchObj(@PathParam("value") int selectedRestaurantId,@Context HttpServletRequest req){
		Restaurant restaurant = new Restaurant();
		RestaurantDAO restaurantDao = new RestaurantDAO();
		restaurant = restaurantDao.findById(selectedRestaurantId);
		RestaurantSearch restaurantSearchObj = new RestaurantSearch();
		restaurantSearchObj.setName(restaurant.getName());
		restaurantSearchObj.setWebsite(restaurant.getWebsite());
		restaurantSearchObj.setCapacity(restaurant.getCapacity());
		restaurantSearchObj.setClosingTime(restaurant.getClosingTime());
		restaurantSearchObj.setOpeningTime(restaurant.getOpeningTime());
		restaurantSearchObj.setImageURL(restaurant.getImageURL());
		restaurantSearchObj.setPhoneNo(restaurant.getPhoneNo());
		restaurantSearchObj.setPriceLevel((String.valueOf(restaurant.getPriceLevel())));
		restaurantSearchObj.setRatings((String.valueOf(restaurant.getRating())));
		restaurantSearchObj.setRestaurantId(selectedRestaurantId);

		AddressManager addrMgr = new AddressManager();
		Address address = addrMgr.findAddressById(selectedRestaurantId);
		String restaurantAddress=address.getapt_No()+" "+address.getStreet()+", "+address.getCity()+", "+address.getState()+" "+address.getZip();
		restaurantSearchObj.setAddress(restaurantAddress);
		req.getSession().setAttribute("selectedRestaurant", restaurantSearchObj);
		req.getSession().setAttribute("path", 0);
	}

	@POST
	@Path("/addreview/{comments}/{rating}")
	public void addReview(@PathParam("comments") String comments,@PathParam("rating") String rating, @Context HttpServletRequest req) {

		User user = (User)req.getSession().getAttribute("user");
		RestaurantSearch selected = (RestaurantSearch)req.getSession().getAttribute("selectedRestaurant");
		ReviewsDAO revDao = new ReviewsDAO();
		Date date = new Date();
		Reviews newReview = new Reviews(user.getUserName(),rating,comments,date,selected.getRestaurantId());
		revDao.createReviews(newReview);

	}

}
