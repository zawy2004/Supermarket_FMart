package controller.admin;

import dao.CategoryDAO;
import model.Category;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            List<Category> list = CategoryDAO.getAllCategories();
            request.setAttribute("categories", list);
            request.getRequestDispatcher("Admin/category_list.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            // Lấy id từ URL và lấy thông tin category để đổ lên form
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = CategoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("Admin/edit_category.jsp").forward(request, response);
        }else if ("add".equals(action)) {
        request.getRequestDispatcher("Admin/add_category.jsp").forward(request, response);
    }   else if ("delete".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.deleteCategory(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("CategoryServlet");
        return;
    }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");
        int parentId = 0;
        try {
            parentId = Integer.parseInt(request.getParameter("parentCategoryID"));
        } catch (Exception e) {
            parentId = 0;
        }
        String imageUrl = request.getParameter("imageUrl");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        int displayOrder = 0;
        try {
            displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
        } catch (Exception e) {
            displayOrder = 0;
        }

        if ("add".equals(action)) {
            // Không cho chọn chính nó làm parent, add thì không thể xảy ra
            Category newCat = new Category(0, name, description, parentId, imageUrl, isActive, new java.util.Date(), displayOrder);
            CategoryDAO.addCategory(newCat);
            response.sendRedirect("CategoryServlet");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("categoryID"));
            // Không cho parent là chính nó
            if (id == parentId) {
                parentId = 0;
            }
            Category cat = new Category(id, name, description, parentId, imageUrl, isActive, new Date(), displayOrder);
            CategoryDAO.updateCategory(cat);
            response.sendRedirect("CategoryServlet");
        }
    }

}
