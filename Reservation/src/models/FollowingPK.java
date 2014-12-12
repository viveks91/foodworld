package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;


public class FollowingPK implements Serializable{

		private String userName;
		private String following;
		
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
		public FollowingPK() {
		}
		
	    @Override
	    public boolean equals(Object obj) {
	        if(obj instanceof FollowingPK){
	            FollowingPK followingPK = (FollowingPK) obj;
	 
	            if(!followingPK.getUserName().equals(userName)){
	                return false;
	            }
	 
	            if(!followingPK.getFollowing().equals(following)){
	                return false;
	            }
	 
	            return true;
	        }
	 
	        return false;
	    }
	 
	    @Override
	    public int hashCode() {
	        return userName.hashCode() + following.hashCode();
	    }
}
