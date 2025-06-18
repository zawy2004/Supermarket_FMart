package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class PasswordUtil {

    /**
     * Mã hóa mật khẩu bằng thuật toán SHA-256 với salt
     *
     * @param password mật khẩu dạng text
     * @return chuỗi mã hóa SHA-256 (hex) kèm salt
     */
    public static String hashPassword(String password) {
        if (password == null || password.trim().isEmpty() || password.length() < 6) {
            throw new IllegalArgumentException("Mật khẩu phải có ít nhất 6 ký tự và không được bỏ trống.");
        }

        try {
            // Tạo salt ngẫu nhiên (16 byte)
            byte[] salt = new byte[16];
            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);

            // Kết hợp password với salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedBytes = md.digest(password.getBytes());

            // Ghép salt và hash thành một chuỗi (salt + hash)
            StringBuilder sb = new StringBuilder();
            for (byte b : salt) {
                sb.append(String.format("%02x", b));
            }
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Không thể mã hóa mật khẩu: " + e.getMessage(), e);
        }
    }

    /**
     * Kiểm tra xem mật khẩu người dùng nhập có khớp với bản đã mã hóa không
     *
     * @param plainText mật khẩu vừa nhập
     * @param hashed    mật khẩu đã lưu (mã hóa với salt)
     * @return true nếu khớp, false nếu không
     */
    public static boolean verifyPassword(String plainText, String hashed) {
        if (plainText == null || plainText.trim().isEmpty() || hashed == null || hashed.length() < 32) {
            return false;
        }

        try {
            // Tách salt từ hashed (16 byte đầu là salt, phần còn lại là hash)
            String saltHex = hashed.substring(0, 32); // 16 byte * 2 (hex)
            String hashHex = hashed.substring(32);

            byte[] salt = new byte[16];
            for (int i = 0; i < 16; i++) {
                salt[i] = (byte) Integer.parseInt(saltHex.substring(i * 2, i * 2 + 2), 16);
            }

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedInputBytes = md.digest(plainText.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedInputBytes) {
                sb.append(String.format("%02x", b));
            }
            String hashedInput = sb.toString();

            return hashedInput.equals(hashHex);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Không thể xác minh mật khẩu: " + e.getMessage(), e);
        }
    }
}