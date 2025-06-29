package service;

import dao.CategoryDAO;
import model.Category;
import java.util.List;
import java.util.ArrayList;

public class CategoryService {

    private CategoryDAO categoryDAO = new CategoryDAO();

    /**
     * Lấy tất cả categories
     */
    public List<Category> getAllCategories() {
        return CategoryDAO.getAllCategories();
    }

    /**
     * Lấy chỉ các categories active
     */
    public List<Category> getActiveCategories() {
        List<Category> allCategories = CategoryDAO.getAllCategories();
        List<Category> activeCategories = new ArrayList<>();

        for (Category category : allCategories) {
            if (category.getIsActive()) {
                activeCategories.add(category);
            }
        }

        return activeCategories;
    }

    /**
     * Lấy category theo ID
     */
    public Category getCategoryById(int categoryId) {
        if (categoryId <= 0) {
            return null;
        }
        return CategoryDAO.getCategoryById(categoryId);
    }

    /**
     * Lấy category active theo ID
     */
    public Category getActiveCategoryById(int categoryId) {
        Category category = getCategoryById(categoryId);
        if (category != null && category.getIsActive()) {
            return category;
        }
        return null;
    }

    /**
     * Thêm category mới
     */
    public boolean addCategory(Category category) {
        try {
            CategoryDAO.addCategory(category);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật category
     */
    public boolean updateCategory(Category category) {
        try {
            CategoryDAO.updateCategory(category);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa category
     */
    public boolean deleteCategory(int categoryId) {
        try {
            CategoryDAO.deleteCategory(categoryId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy categories con theo parent ID
     */
    public List<Category> getCategoriesByParent(int parentId) {
        List<Category> allCategories = getAllCategories();
        List<Category> childCategories = new ArrayList<>();

        for (Category category : allCategories) {
            if (category.getParentCategoryID() == parentId && category.getIsActive()) {
                childCategories.add(category);
            }
        }

        return childCategories;
    }

    /**
     * Lấy categories cha (không có parent)
     */
    public List<Category> getRootCategories() {
        List<Category> allCategories = getActiveCategories();
        List<Category> rootCategories = new ArrayList<>();

        for (Category category : allCategories) {
            if (category.getParentCategoryID() == 0) {
                rootCategories.add(category);
            }
        }

        return rootCategories;
    }

    /**
     * Kiểm tra category có tồn tại và active không
     */
    public boolean isCategoryActiveAndExists(int categoryId) {
        Category category = getCategoryById(categoryId);
        return category != null && category.getIsActive();
    }
}
