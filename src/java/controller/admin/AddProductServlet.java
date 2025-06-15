package controller.admin;

import dao.ProductDAO;
import dao.ProductImageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import model.Product;

public class AddProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private ProductImageDAO productImagesDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();  // Khởi tạo ProductDAO
        productImagesDAO = new ProductImageDAO();  // Khởi tạo ProductImagesDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String productName = request.getParameter("productName");
            String sku = request.getParameter("sku");
            double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));
            double costPrice = Double.parseDouble(request.getParameter("costPrice"));
            String description = request.getParameter("description");
            int categoryID = Integer.parseInt(request.getParameter("category"));

            // Lấy ảnh sản phẩm
            Part filePart = request.getPart("productImage"); // Lấy ảnh từ form
            String imagePath = saveProductImage(filePart); // Lưu ảnh và lấy đường dẫn

            // Tạo đối tượng Product
            Product newProduct = new Product();
            newProduct.setProductName(productName);
            newProduct.setSku(sku);
            newProduct.setSellingPrice(sellingPrice);
            newProduct.setCostPrice(costPrice);
            newProduct.setDescription(description);
            newProduct.setCategoryID(categoryID);

            // Gọi ProductDAO để thêm sản phẩm vào DB
            boolean addSuccess = productDAO.addProduct(newProduct);
            if (addSuccess) {
                // Lấy ProductID sau khi thêm vào cơ sở dữ liệu
                int productID = productDAO.getLastInsertedProductID();

                // Lưu hình ảnh vào bảng ProductImages
                productImagesDAO.addProductImage(productID, imagePath);

                // Chuyển hướng về trang danh sách sản phẩm sau khi thêm thành công
                response.sendRedirect("products.jsp");
            } else {
                // Nếu có lỗi, hiển thị thông báo lỗi
                request.setAttribute("errorMessage", "Failed to add product");
                request.getRequestDispatcher("/add_product.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/add_product.jsp").forward(request, response);
        }
    }

    private String saveProductImage(Part filePart) throws IOException {
        String imagePath = null;
        if (filePart != null) {
            // Lấy tên file
            String fileName = filePart.getSubmittedFileName();
            // Đường dẫn nơi lưu ảnh
            String savePath = "path/to/your/upload/folder/" + fileName;

            // Tạo file mới trong thư mục server
            File file = new File(savePath);
            try (InputStream inputStream = filePart.getInputStream();
                 FileOutputStream fileOutputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    fileOutputStream.write(buffer, 0, bytesRead);
                }
            }
            imagePath = savePath;  // Lưu đường dẫn ảnh
        }
        return imagePath;  // Trả về đường dẫn ảnh
    }
}
