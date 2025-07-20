/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author gia huy
 */
public class OrderReport {

    private int year;
    private int month;
    private int day;
    private int hour;
    private int totalOrders;
    private double totalSales;

    // Constructor cho báo cáo theo giờ
    public OrderReport(int hour, int totalOrders, double totalSales) {
        this.hour = hour;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
    }

    // Constructor cho báo cáo theo ngày
    public OrderReport(int year, int month, int day, int totalOrders, double totalSales) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
    }

    // Constructor cho báo cáo theo tháng
    public OrderReport(int year, int month, int totalOrders, double totalSales) {
        this.year = year;
        this.month = month;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }
}

