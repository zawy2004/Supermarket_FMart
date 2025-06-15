package model;

import java.util.Date;
import util.ValidationUtil;

public class User {
    private int userID;
    private String username;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phoneNumber;
    private String address;
    private Date dateOfBirth;
    private String gender;
    private int roleID;
    private boolean isActive;
    private Date createdDate;
    private Date lastLoginDate;
    private String profileImageUrl;

    // Constructors
    public User() {}

    public User(int userID, String username, String email, String passwordHash, String fullName, String phoneNumber,
                String address, Date dateOfBirth, String gender, int roleID, boolean isActive,
                Date createdDate, Date lastLoginDate, String profileImageUrl) {
        setUserID(userID);
        setUsername(username);
        setEmail(email);
        setPasswordHash(passwordHash);
        setFullName(fullName);
        setPhoneNumber(phoneNumber);
        setAddress(address);
        setDateOfBirth(dateOfBirth);
        setGender(gender);
        setRoleID(roleID);
        setIsActive(isActive);
        setCreatedDate(createdDate);
        setLastLoginDate(lastLoginDate);
        setProfileImageUrl(profileImageUrl);
    }

    // Getters and Setters with validation
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        if (username != null && !ValidationUtil.isValidUsername(username)) {
            throw new IllegalArgumentException("Username không hợp lệ (tối đa 10 ký tự, chỉ chữ/số/_).");
        }
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (email != null && !ValidationUtil.isValidEmail(email)) {
            throw new IllegalArgumentException("Email không hợp lệ.");
        }
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        if (passwordHash == null) {
            throw new IllegalArgumentException("Password hash không được để trống.");
        }
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        if (fullName != null && !ValidationUtil.isValidFullName(fullName)) {
            throw new IllegalArgumentException("Họ tên không hợp lệ (chỉ chứa chữ cái và khoảng trắng).");
        }
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        if (phoneNumber != null && !ValidationUtil.isValidPhoneNumber(phoneNumber)) {
            throw new IllegalArgumentException("Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và 10 chữ số).");
        }
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        if (address != null && !ValidationUtil.isValidAddress(address)) {
            throw new IllegalArgumentException("Địa chỉ không hợp lệ (chỉ chứa chữ, số, khoảng trắng).");
        }
        this.address = address;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        if (dateOfBirth != null) {
            java.util.Date today = new java.util.Date();
            if (dateOfBirth.after(today)) {
                throw new IllegalArgumentException("Ngày sinh không được trong tương lai.");
            }
        }
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        if (gender != null && !gender.trim().isEmpty() && !gender.equals("Male") && !gender.equals("Female") && !gender.equals("Other")) {
            throw new IllegalArgumentException("Giới tính không hợp lệ (chỉ Male, Female, hoặc Other).");
        }
        this.gender = gender;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(Date lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getProfileImageUrl() {
        return profileImageUrl;
    }

    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }
}