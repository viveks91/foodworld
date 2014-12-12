package models;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;


public class FavoritesPK implements Serializable{

		private String userName;
		private int restaurantId;
		
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		
		public int getRestaurantId() {
			return restaurantId;
		}
		public void setRestaurantId(int restaurantId) {
			this.restaurantId = restaurantId;
		}
		public FavoritesPK() {
		}
		
	    @Override
	    public boolean equals(Object obj) {
	        if(obj instanceof FavoritesPK){
	            FavoritesPK favoritesPK = (FavoritesPK) obj;
	 
	            if(!favoritesPK.getUserName().equals(userName)){
	                return false;
	            }
	 
	            if(favoritesPK.getRestaurantId() != (restaurantId)){
	                return false;
	            }
	 
	            return true;
	        }
	 
	        return false;
	    }
	 
	    @Override
	    public int hashCode() {
	        return userName.hashCode() + restaurantId;
	    }
}
