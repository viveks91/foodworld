package managers;

import java.io.Serializable;

import models.Category;
import dao.CategoryDAO;

public class CategoryManager implements Serializable {
	
	private CategoryDAO catgry_dao = new CategoryDAO();
	
	/**
	 * Creates the given category entity
	 * @param category
	 * @return Category
	 */
	public String createCategory (Category category) {
		if(this.findCategoryByType(category.getType()) == null)
			catgry_dao.create(category);
		return category.getType();
	}
	
	/**
	 * Finds the category with the given type
	 * @param type
	 * @return Category
	 */
	public Category findCategoryByType (String type) {
		Category category = catgry_dao.findByType(type);
		return category;
	}
	
	/**
	 * Deletes the given category
	 * @param type
	 */
	public void removeCategoryByType (String type) {
		if(findCategoryByType(type) == null) return;
		catgry_dao.deleteByType(type);
	}

}
