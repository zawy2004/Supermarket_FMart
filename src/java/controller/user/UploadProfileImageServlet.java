package controller.user;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/profile/uploadImage")
@MultipartConfig
public class UploadProfileImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        Part filePart = request.getPart("avatarFile");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // đường dẫn uploads trong webapp
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String savedFilePath = uploadPath + File.separator + fileName;
            filePart.write(savedFilePath);
            
            // update DB
            String relativePath = "uploads/" + fileName;
            user.setProfileImageUrl(relativePath);
            new UserDAO().updateProfileImage(user.getUserId(), relativePath);
            
            // cập nhật session luôn
            session.setAttribute("user", user);
            
            System.out.println("Upload thành công: " + savedFilePath);
        } else {
            System.out.println("Không có file được chọn");
        }
        
        response.sendRedirect(request.getContextPath() + "/profile?action=overview");
    }
}
