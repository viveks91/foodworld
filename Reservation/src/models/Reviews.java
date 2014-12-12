package models;


import java.util.Date;




import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity

@NamedQueries({
	@NamedQuery(
		name="Reviews.deleteReviewByUserName",
		query="delete from Reviews r where r.userName = :userName"
	),
	@NamedQuery(
			name="Reviews.findAllReviewsByUserName",
	        query="select r from Reviews r where r.userName = :userName"
		),
	@NamedQuery(
			name="Reviews.findAllReviewsByRestaurantId",
	        query="select r from Reviews r where r.restaurantId = :restaurantId"
		),
	@NamedQuery(
			name="Reviews.findAllReviewsWithRestaurantName",
			query="select r.name, rev.comments, rev.ratings,r.imageURL,r.id from Reviews rev, Restaurant r where rev.userName = :userName and rev.restaurantId = r.id"
		),
	@NamedQuery(
			name="Reviews.findFriendsReviewsWithRestaurantName",
			query="select f.following, rev.comments, rev.date, r.name, r.id, r.imageURL from Following f, Reviews rev, Restaurant r "
					+ "where f.userName = :username and rev.userName = f.following and r.id= rev.restaurantId "
					+ "order by rev.date DESC"
		),
	@NamedQuery(
				name="Reviews.findAllReviewsWithRestaurantId",
				query="select p.firstName, rev.comments, rev.ratings from Restaurant r, Reviews rev, Person p where rev.restaurantId=r.id and rev.userName=p.userName and r.id = :rId"
		),
	@NamedQuery(
				name="Reviews.findFollowingUserReviews",
				query="select r.name,rev.comments,p.userName,p.firstName,r.id,r.imageURL from Following f, Person p, Reviews rev, Restaurant r"
						+ " where f.userName = :userName and f.following=p.userName and rev.userName = f.following and rev.restaurantId=r.id"
		)
})

public class Reviews {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	
	private String userName;
	private String ratings;
	private String comments;
	
	@Temporal(TemporalType.DATE)
	private Date date;
	private int restaurantId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRatings() {
		return ratings;
	}
	public void setRatings(String ratings) {
		this.ratings = ratings;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	public Reviews(int id, String userName, String ratings, String comments,
			Date date, int restaurantId) {
		super();
		this.id = id;
		this.userName = userName;
		this.ratings = ratings;
		this.comments = comments;
		this.date = date;
		this.restaurantId = restaurantId;
	}
	public Reviews(String userName, String ratings, String comments, Date date,
			int restaurantId) {
		super();
		this.userName = userName;
		this.ratings = ratings;
		this.comments = comments;
		this.date = date;
		this.restaurantId = restaurantId;
	}
	public Reviews() {
		super();
	}
	
	
}
