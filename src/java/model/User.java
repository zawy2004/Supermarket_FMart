package model;

import java.util.Date;

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
    private String studentID;
    private String department;

    // Constructors, Getters, and Setters...

    public User() {}

    public User(int userID, String username, String email, String passwordHash, String fullName, String phoneNumber,
                String address, Date dateOfBirth, String gender, int roleID, boolean isActive,
                Date createdDate, Date lastLoginDate, String profileImageUrl, String studentID, String department) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.roleID = roleID;
        this.isActive = isActive;
        this.createdDate = createdDate;
        this.lastLoginDate = lastLoginDate;
        this.profileImageUrl = profileImageUrl;
        this.studentID = studentID;
        this.department = department;
    }

    // Getters and Setters here
}
