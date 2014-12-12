package models;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;





@Entity
@Table(name="Following")
@IdClass(value=FollowingPK.class)

@NamedQueries({
	@NamedQuery(
		name="Following.deleteByUserNameAndFollowing",
		query="delete from Following f where f.userName = :userName and f.following = :following"
	),
	@NamedQuery(
			name="Following.findByUserName",
			query="select f from Following f where f.userName = :userName"
		),
	@NamedQuery(
				name="Following.findBy2UserName",
				query="select f from Following f where f.userName = :userName1 and f.following = :userName2"
			),
})
	
public class Following implements Serializable{

	@Id
	private String userName;
	@Id
	private String following;
	
	public String toString()
	{
		return userName + " " + following;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getFollowing() {
		return following;
	}
	public void setFollowing(String following) {
		this.following = following;
	}
	public Following(String userName, String following) {
		super();
		this.userName = userName;
		this.following = following;
	}
	public Following() {
		super();
	}
	
	
}
