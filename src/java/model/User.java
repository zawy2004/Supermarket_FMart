package model;

import java.sql.Date;

public class User {
    private int userId;
    private String email;
    private String passwordHash;
    private String loginType;
    private String fullName;
    private String phoneNumber;
    private String address;
    private Date dateOfBirth;
    private String gender;
    private int roleId; // Thuộc tính roleId
    private boolean isActive;
    private java.sql.Timestamp createdDate;
    private java.sql.Timestamp lastLoginDate;
    private String profileImageUrl;
    private String studentId;
    private String department;

    // Getters and setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getLoginType() { return loginType; }
    public void setLoginType(String loginType) { this.loginType = loginType; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public int getRoleId() { return roleId; } // Getter cho roleId
    public void setRoleId(int roleId) { this.roleId = roleId; } // Setter cho roleId
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public java.sql.Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(java.sql.Timestamp createdDate) { this.createdDate = createdDate; }
    public java.sql.Timestamp getLastLoginDate() { return lastLoginDate; }
    public void setLastLoginDate(java.sql.Timestamp lastLoginDate) { this.lastLoginDate = lastLoginDate; }
    public String getProfileImageUrl() { return profileImageUrl; }
    public void setProfileImageUrl(String profileImageUrl) { this.profileImageUrl = profileImageUrl; }
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public void setRoleID(int i) {
        
    }
}