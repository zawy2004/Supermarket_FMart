package util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Regex để kiểm tra email hợp lệ
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
    );

    // Regex để kiểm tra mật khẩu có ít nhất 6 ký tự gồm chữ và số
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
        "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    );

    // Regex kiểm tra số điện thoại Việt Nam bắt đầu bằng 0 và có 10 chữ số
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^0\\d{9}$"
    );

    // Regex kiểm tra username tối đa 10 ký tự (chữ, số, hoặc _)
    private static final Pattern USERNAME_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_]{1,10}$"
    );

    // Regex kiểm tra address (chữ cái, số, khoảng trắng)
    private static final Pattern ADDRESS_PATTERN = Pattern.compile(
        "^[A-Za-zÀ-Ỹà-ỹ0-9\\s]+$"
    );

    // Regex kiểm tra fullName (chỉ chứa chữ cái và khoảng trắng)
    private static final Pattern FULLNAME_PATTERN = Pattern.compile(
        "^[A-Za-zÀ-Ỹà-ỹ\\s]+$"
    );

    // Kiểm tra định dạng email
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    // Kiểm tra độ mạnh mật khẩu
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    // Kiểm tra định dạng số điện thoại
    public static boolean isValidPhoneNumber(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }

    // Kiểm tra không để trống
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    // Kiểm tra định dạng username (tối đa 10 ký tự và không bỏ trống)
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches() && isNotEmpty(username);
    }

    // Kiểm tra định dạng address (chữ cái, số, khoảng trắng)
    public static boolean isValidAddress(String address) {
        return address != null && ADDRESS_PATTERN.matcher(address).matches() && isNotEmpty(address);
    }

    // Kiểm tra định dạng fullName (chỉ chứa chữ cái và khoảng trắng)
    public static boolean isValidFullName(String fullName) {
        return fullName != null && FULLNAME_PATTERN.matcher(fullName).matches() && isNotEmpty(fullName);
    }
}