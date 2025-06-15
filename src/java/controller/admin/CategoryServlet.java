
package controller.admin;

import dao.CategoryDAO;
import model.Category;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class CategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            List<Category> list = CategoryDAO.getAllCategories();
            request.setAttribute("categories", list);
            request.getRequestDispatcher("Admin/category_list.jsp").forward(request, response);
        } else if (action.equals("add")) {
            request.getRequestDispatcher("Admin/add_category.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = CategoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("Admin/edit_category.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.deleteCategory(id);
            response.sendRedirect("CategoryServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");
        int parentId = Integer.parseInt(request.getParameter("parentCategoryID"));
        String imageUrl = request.getParameter("imageUrl");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        int displayOrder = Integer.parseInt(request.getParameter("displayOrder"));

        if ("add".equals(action)) {
            Category newCat = new Category(0, name, description, parentId, imageUrl, isActive, new Date(), displayOrder);
            CategoryDAO.addCategory(newCat);
            response.sendRedirect("CategoryServlet");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("categoryID"));
            Category cat = new Category(id, name, description, parentId, imageUrl, isActive, new Date(), displayOrder);
            CategoryDAO.updateCategory(cat);
            response.sendRedirect("CategoryServlet");
        }
    }
}
