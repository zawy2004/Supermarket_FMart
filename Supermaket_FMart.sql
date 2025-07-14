-- Xóa database nếu đã tồn tại
IF DB_ID('Fmart') IS NOT NULL
BEGIN
    ALTER DATABASE Fmart SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Fmart;
END
GO

-- Tạo lại database Fmart
CREATE DATABASE Fmart;
GO

USE Fmart;
GO

-- ================================================================
-- FMART SUPERMARKET MANAGEMENT SYSTEM DATABASE SCHEMA
-- FPT University - Group D05-RT06
-- ================================================================

-- 1. ROLES TABLE - Quản lý các vai trò người dùng
CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(20) UNIQUE NOT NULL -- Ví dụ: 'User', 'Staff', 'Admin'
);

-- 2. USERS TABLE - Quản lý tài khoản người dùng
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NULL, -- Hỗ trợ OAuth, không bắt buộc
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NULL, -- Hỗ trợ OAuth, cho phép NULL
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    DateOfBirth DATE,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    RoleID INT DEFAULT 1, -- Khóa ngoại đến Roles, mặc định User
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME,
    ProfileImageUrl NVARCHAR(255),
    StudentID NVARCHAR(20), -- Mã sinh viên (nếu có)
    Department NVARCHAR(100), -- Khoa/Phòng ban
    AuthProvider NVARCHAR(20) DEFAULT 'Local', -- Hỗ trợ OAuth
    ExternalID NVARCHAR(100) NULL, -- ID từ Facebook/Google
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- 3. CATEGORIES TABLE - Danh mục sản phẩm
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    ParentCategoryID INT NULL, -- Hỗ trợ danh mục con
    ImageUrl NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    DisplayOrder INT DEFAULT 0,
    FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);

-- 4. SUPPLIERS TABLE - Nhà cung cấp
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    Email NVARCHAR(100),
    Address NVARCHAR(255),
    TaxCode NVARCHAR(20),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    Notes NVARCHAR(500)
);

-- 5. PRODUCTS TABLE - Sản phẩm
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    SKU NVARCHAR(50) UNIQUE NOT NULL, -- Mã sản phẩm
    CategoryID INT NOT NULL,
    SupplierID INT,
    Description NVARCHAR(1000),
    Unit NVARCHAR(20) NOT NULL, -- Đơn vị tính (cái, kg, lít, etc.)
    CostPrice DECIMAL(10,2) NOT NULL, -- Giá nhập
    SellingPrice DECIMAL(10,2) NOT NULL, -- Giá bán
    MinStockLevel INT DEFAULT 0, -- Mức tồn kho tối thiểu
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME DEFAULT GETDATE(),
    Weight DECIMAL(8,2), -- Trọng lượng (gram)
    Dimensions NVARCHAR(50), -- Kích thước
    ExpiryDays INT, -- Số ngày hết hạn từ ngày sản xuất
    Brand NVARCHAR(100), -- Thương hiệu
    Origin NVARCHAR(100), -- Xuất xứ
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- 6. PRODUCT IMAGES TABLE - Hình ảnh sản phẩm
CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ImageUrl NVARCHAR(255) NOT NULL,
    AltText NVARCHAR(255),
    IsMainImage BIT DEFAULT 0,
    DisplayOrder INT DEFAULT 0,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- 7. WAREHOUSES TABLE - Bảng Kho
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY IDENTITY,
    WarehouseName NVARCHAR(100),
    Location NVARCHAR(200)
);

-- 8. INVENTORY TABLE - Quản lý tồn kho
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    WarehouseID INT,
    CurrentStock INT NOT NULL DEFAULT 0,
    ReservedStock INT DEFAULT 0, -- Hàng đã được đặt nhưng chưa bán
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(100), -- Vị trí cụ thể trong kho
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- 9. STOCK MOVEMENTS TABLE - Lịch sử xuất nhập kho
CREATE TABLE StockMovements (
    MovementID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    MovementType NVARCHAR(20) NOT NULL CHECK (MovementType IN ('IN', 'OUT', 'ADJUSTMENT')),
    Quantity INT NOT NULL,
    Reason NVARCHAR(100), -- Lý do xuất/nhập
    ReferenceID INT, -- ID tham chiếu (OrderID, PurchaseOrderID, etc.)
    ReferenceType NVARCHAR(50), -- Loại tham chiếu
    MovementDate DATETIME DEFAULT GETDATE(),
    CreatedBy INT,
    Notes NVARCHAR(500),
    UnitCost DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- 10. IMPORT RECEIPTS TABLE - Bảng Phiếu Nhập
CREATE TABLE ImportReceipts (
    ImportID INT PRIMARY KEY IDENTITY,
    SupplierID INT,
    WarehouseID INT,
    ImportDate DATE DEFAULT GETDATE(),
    Notes NVARCHAR(200),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- 11. IMPORT DETAILS TABLE - Bảng Chi Tiết Nhập
CREATE TABLE ImportDetails (
    ImportDetailID INT PRIMARY KEY IDENTITY,
    ImportID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(18,2),
    FOREIGN KEY (ImportID) REFERENCES ImportReceipts(ImportID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 12. ORDERS TABLE - Đơn hàng
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderNumber NVARCHAR(20) UNIQUE NOT NULL, -- Mã đơn hàng
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderType NVARCHAR(20) DEFAULT 'Online' CHECK (OrderType IN ('Online', 'In-Store')),
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Confirmed', 'Processing', 'Completed', 'Cancelled')),
    TotalAmount DECIMAL(12,2) NOT NULL,
    DiscountAmount DECIMAL(10,2) DEFAULT 0,
    TaxAmount DECIMAL(10,2) DEFAULT 0,
    FinalAmount DECIMAL(12,2) NOT NULL,
    PaymentStatus NVARCHAR(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Pending', 'Paid', 'Partial', 'Refunded', 'Failed')),
    PaymentMethod NVARCHAR(30),
    DeliveryAddress NVARCHAR(500),
    DeliveryDate DATETIME,
    CompletedDate DATETIME,
    ProcessedBy INT, -- Nhân viên xử lý
    Notes NVARCHAR(500),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProcessedBy) REFERENCES Users(UserID)
);

-- 13. ORDER DETAILS TABLE - Chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    DiscountPercent DECIMAL(5,2) DEFAULT 0,
    DiscountAmount DECIMAL(10,2) DEFAULT 0,
    TotalPrice DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 14. SHOPPING CART TABLE - Giỏ hàng
CREATE TABLE ShoppingCart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    UNIQUE(UserID, ProductID)
);

-- 15. PAYMENTS TABLE - Thanh toán
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(30) NOT NULL, -- Cash, QR, E-Wallet, Card
    PaymentProvider NVARCHAR(50), -- MoMo, ZaloPay, VNPay, etc.
    Amount DECIMAL(12,2) NOT NULL,
    TransactionID NVARCHAR(100), -- Mã giao dịch từ cổng thanh toán
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Success', 'Failed', 'Cancelled', 'Refunded')),
    PaymentDate DATETIME DEFAULT GETDATE(),
    ProcessedBy INT,
    Notes NVARCHAR(500),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProcessedBy) REFERENCES Users(UserID)
);

-- 16. PROMOTIONS TABLE - Khuyến mãi
CREATE TABLE Promotions (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    PromotionName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000),
    PromotionType NVARCHAR(20) NOT NULL CHECK (PromotionType IN ('Percentage', 'Fixed', 'Buy X Get Y', 'Free Shipping')),
    DiscountValue DECIMAL(10,2), -- Giá trị giảm giá
    MinOrderAmount DECIMAL(10,2), -- Đơn hàng tối thiểu
    MaxDiscountAmount DECIMAL(10,2), -- Giảm tối đa
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    UsageLimit INT, -- Số lần sử dụng tối đa
    UsageCount INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedBy INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- 17. PROMOTION PRODUCTS TABLE - Sản phẩm áp dụng khuyến mãi
CREATE TABLE PromotionProducts (
    PromotionProductID INT IDENTITY(1,1) PRIMARY KEY,
    PromotionID INT NOT NULL,
    ProductID INT,
    CategoryID INT,
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CHECK ((ProductID IS NOT NULL AND CategoryID IS NULL) OR (ProductID IS NULL AND CategoryID IS NOT NULL))
);

-- 18. COUPONS TABLE - Mã giảm giá
CREATE TABLE Coupons (
    CouponID INT IDENTITY(1,1) PRIMARY KEY,
    CouponCode NVARCHAR(20) UNIQUE NOT NULL,
    CouponName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    DiscountType NVARCHAR(20) NOT NULL CHECK (DiscountType IN ('Percentage', 'Fixed')),
    DiscountValue DECIMAL(10,2) NOT NULL,
    MinOrderAmount DECIMAL(10,2),
    MaxDiscountAmount DECIMAL(10,2),
    UsageLimit INT, -- Số lần sử dụng tối đa trên toàn hệ thống
    UsageCount INT DEFAULT 0,
    OrderLimit INT DEFAULT 0, -- Giới hạn số đơn hàng áp dụng (thay thế UserLimit)
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedBy INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- 19. COUPON USAGE TABLE - Lịch sử sử dụng coupon (chỉ theo OrderID)
CREATE TABLE CouponUsage (
    UsageID INT IDENTITY(1,1) PRIMARY KEY,
    CouponID INT NOT NULL,
    OrderID INT NOT NULL, -- Chỉ liên kết với OrderID
    UsedDate DATETIME DEFAULT GETDATE(),
    DiscountAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    -- Thêm ràng buộc UNIQUE trên OrderID nếu muốn mỗi đơn hàng chỉ dùng một coupon
    -- CONSTRAINT UQ_CouponUsage_OrderID UNIQUE (OrderID)
);

-- 20. REVIEWS TABLE - Đánh giá sản phẩm
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    OrderID INT, -- Chỉ cho phép review sau khi mua
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewTitle NVARCHAR(200),
    ReviewContent NVARCHAR(2000),
    IsVerifiedPurchase BIT DEFAULT 0,
    IsApproved BIT DEFAULT 0,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ApprovedBy INT,
    ApprovedDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ApprovedBy) REFERENCES Users(UserID)
);

-- 21. WISHLIST TABLE - Danh sách yêu thích
CREATE TABLE Wishlist (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    UNIQUE(UserID, ProductID)
);

-- 22. PRODUCT RECOMMENDATIONS TABLE - Gợi ý sản phẩm (AI)
CREATE TABLE ProductRecommendations (
    RecommendationID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    RecommendationType NVARCHAR(50) NOT NULL, -- 'Purchase History', 'Similar Products', 'Trending', etc.
    Score DECIMAL(5,4), -- Điểm tin cậy của gợi ý
    GeneratedDate DATETIME DEFAULT GETDATE(),
    IsViewed BIT DEFAULT 0,
    IsClicked BIT DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- 23. DISPATCH RECEIPTS TABLE - Bảng Phiếu Xuất Kho
CREATE TABLE DispatchReceipts (
    DispatchID INT PRIMARY KEY IDENTITY,
    WarehouseID INT NOT NULL,
    DispatchDate DATE DEFAULT GETDATE(),
    DispatchType NVARCHAR(50) NOT NULL CHECK (DispatchType IN ('Return to Supplier', 'Write-off', 'Internal Transfer', 'Internal Use')),
    CreatedBy INT, -- User tạo phiếu
    Reference NVARCHAR(255), -- Tham chiếu đến (nếu có): mã NCC, mã kho nhận
    Notes NVARCHAR(500),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- 24. DISPATCH DETAILS TABLE - Bảng Chi Tiết Xuất Kho
CREATE TABLE DispatchDetails (
    DispatchDetailID INT PRIMARY KEY IDENTITY,
    DispatchID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitCost DECIMAL(18,2), -- Ghi nhận giá vốn của sản phẩm tại thời điểm xuất
    Reason NVARCHAR(255), -- Lý do chi tiết cho từng sản phẩm
    FOREIGN KEY (DispatchID) REFERENCES DispatchReceipts(DispatchID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ================================================================

-- Users table indexes
CREATE INDEX IX_Users_Username ON Users(Username) WHERE Username IS NOT NULL;
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Users_RoleID ON Users(RoleID);
CREATE INDEX IX_Users_IsActive ON Users(IsActive);
CREATE INDEX IX_Users_ExternalID ON Users(ExternalID) WHERE ExternalID IS NOT NULL;

-- Products table indexes
CREATE INDEX IX_Products_CategoryID ON Products(CategoryID);
CREATE INDEX IX_Products_SKU ON Products(SKU);
CREATE INDEX IX_Products_IsActive ON Products(IsActive);
CREATE INDEX IX_Products_ProductName ON Products(ProductName);

-- Orders table indexes
CREATE INDEX IX_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate);
CREATE INDEX IX_Orders_Status ON Orders(Status);
CREATE INDEX IX_Orders_OrderNumber ON Orders(OrderNumber);

-- Inventory table indexes
CREATE INDEX IX_Inventory_ProductID ON Inventory(ProductID);
CREATE INDEX IX_Inventory_WarehouseID ON Inventory(WarehouseID);
CREATE INDEX IX_Inventory_CurrentStock ON Inventory(CurrentStock);

-- Reviews table indexes
CREATE INDEX IX_Reviews_ProductID ON Reviews(ProductID);
CREATE INDEX IX_Reviews_UserID ON Reviews(UserID);
CREATE INDEX IX_Reviews_Rating ON Reviews(Rating);

-- ImportReceipts table indexes
CREATE INDEX IX_ImportReceipts_SupplierID ON ImportReceipts(SupplierID);
CREATE INDEX IX_ImportReceipts_WarehouseID ON ImportReceipts(WarehouseID);
CREATE INDEX IX_ImportReceipts_ImportDate ON ImportReceipts(ImportDate);

-- ImportDetails table indexes
CREATE INDEX IX_ImportDetails_ImportID ON ImportDetails(ImportID);
CREATE INDEX IX_ImportDetails_ProductID ON ImportDetails(ProductID);

-- CouponUsage table index
CREATE INDEX IX_CouponUsage_OrderID ON CouponUsage(OrderID);

-- Performance indexes for reporting
CREATE INDEX IX_Orders_OrderDate_Status ON Orders(OrderDate, Status);
CREATE INDEX IX_OrderDetails_ProductID_OrderID ON OrderDetails(ProductID, OrderID);
CREATE INDEX IX_StockMovements_ProductID_MovementDate ON StockMovements(ProductID, MovementDate);

-- ================================================================
-- INITIAL DATA SETUP
-- ================================================================

-- Insert default roles
INSERT INTO Roles (RoleName) VALUES
('User'),
('Staff'),
('Admin'),
('Manager');

-- Insert default users
INSERT INTO Users (Username, Email, PasswordHash, FullName, RoleID, IsActive, AuthProvider, ExternalID)
VALUES
    ('admin', 'admin@fmart.fpt.edu.vn', 'hashed_password_here', 'System Administrator', (SELECT RoleID FROM Roles WHERE RoleName = 'Admin'), 1, 'Local', NULL),
    ('staff1', 'staff1@fmart.fpt.edu.vn', 'hashed_password_here', 'Staff 1', (SELECT RoleID FROM Roles WHERE RoleName = 'Staff'), 1, 'Local', NULL),
    (NULL, 'user1@fmart.fpt.edu.vn', NULL, 'Customer 1', (SELECT RoleID FROM Roles WHERE RoleName = 'User'), 1, 'Google', 'google_user_id_123'),
    (NULL, 'user2@fmart.fpt.edu.vn', NULL, 'Customer 2', (SELECT RoleID FROM Roles WHERE RoleName = 'User'), 1, 'Facebook', 'facebook_user_id_456');

-- Insert default categories
INSERT INTO Categories (CategoryName, Description, DisplayOrder) VALUES
('Thực phẩm tươi sống', 'Rau củ quả, thịt cá, hải sản tươi', 1),
('Đồ uống', 'Nước ngọt, nước suối, trà, cà phê', 2),
('Bánh kẹo', 'Bánh quy, kẹo, chocolate, snack', 3),
('Vật dụng sinh hoạt', 'Đồ dùng cá nhân, vệ sinh', 4),
('Văn phòng phẩm', 'Bút, vở, giấy, dụng cụ học tập', 5);

-- ================================================================
-- STORED PROCEDURES FOR COMMON OPERATIONS
-- ================================================================

-- Procedure to login user
CREATE PROCEDURE sp_LoginUser
    @Email NVARCHAR(100),
    @ExternalID NVARCHAR(100) = NULL,
    @AuthProvider NVARCHAR(20) = 'Local',
    @PasswordHash NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserID INT, @RoleID INT, @IsActive BIT;

    SELECT 
        @UserID = UserID, 
        @RoleID = RoleID, 
        @IsActive = IsActive
    FROM Users
    WHERE 
        (Email = @Email OR ExternalID = @ExternalID)
        AND AuthProvider = @AuthProvider
        AND (@AuthProvider = 'Local' AND PasswordHash = @PasswordHash OR @AuthProvider != 'Local')
        AND IsActive = 1;

    IF @UserID IS NOT NULL
    BEGIN
        UPDATE Users
        SET LastLoginDate = GETDATE()
        WHERE UserID = @UserID;

        SELECT 
            u.UserID,
            u.Username,
            u.Email,
            u.FullName,
            r.RoleName,
            u.ProfileImageUrl
        FROM Users u
        INNER JOIN Roles r ON u.RoleID = r.RoleID
        WHERE u.UserID = @UserID;
    END
    ELSE
    BEGIN
        SELECT NULL AS UserID, 'Invalid credentials or inactive account' AS ErrorMessage;
    END
END;
GO

-- Procedure to update inventory after order
CREATE PROCEDURE sp_UpdateInventoryAfterOrder
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE i SET 
        CurrentStock = CurrentStock - od.Quantity,
        LastStockUpdate = GETDATE()
    FROM Inventory i
    INNER JOIN OrderDetails od ON i.ProductID = od.ProductID
    WHERE od.OrderID = @OrderID;
    
    INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType)
    SELECT 
        od.ProductID, 
        'OUT', 
        od.Quantity, 
        'Order Sale', 
        @OrderID, 
        'Order'
    FROM OrderDetails od
    WHERE od.OrderID = @OrderID;
END;
GO

-- Procedure to update inventory after import
CREATE PROCEDURE sp_UpdateInventoryAfterImport
    @ImportID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i SET
        CurrentStock = i.CurrentStock + id.Quantity,
        LastStockUpdate = GETDATE()
    FROM Inventory i
    INNER JOIN ImportDetails id ON i.ProductID = id.ProductID
    INNER JOIN ImportReceipts ir ON id.ImportID = ir.ImportID
    WHERE id.ImportID = @ImportID;

    INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, UnitCost)
    SELECT
        id.ProductID,
        'IN',
        id.Quantity,
        'Product Import',
        @ImportID,
        'ImportReceipt',
        id.UnitPrice
    FROM ImportDetails id
    WHERE id.ImportID = @ImportID;
END;
GO

-- Procedure to update inventory after dispatch
CREATE PROCEDURE sp_UpdateInventoryAfterDispatch
    @DispatchID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DispatchType NVARCHAR(50);
    SELECT @DispatchType = DispatchType FROM DispatchReceipts WHERE DispatchID = @DispatchID;

    UPDATE i SET
        CurrentStock = i.CurrentStock - dd.Quantity,
        LastStockUpdate = GETDATE()
    FROM Inventory i
    INNER JOIN DispatchDetails dd ON i.ProductID = dd.ProductID
    WHERE dd.DispatchID = @DispatchID;

    INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, UnitCost, CreatedBy)
    SELECT
        dd.ProductID,
        'OUT',
        dd.Quantity,
        dr.DispatchType,
        @DispatchID,
        'DispatchReceipt',
        dd.UnitCost,
        dr.CreatedBy
    FROM DispatchDetails dd
    JOIN DispatchReceipts dr ON dd.DispatchID = dr.DispatchID
    WHERE dd.DispatchID = @DispatchID;
END;
GO

-- Procedure to get low stock products
CREATE PROCEDURE sp_GetLowStockProducts
AS
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        p.SKU,
        i.CurrentStock,
        p.MinStockLevel,
        c.CategoryName,
        w.WarehouseName
    FROM Products p
    INNER JOIN Inventory i ON p.ProductID = i.ProductID
    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
    INNER JOIN Warehouses w ON i.WarehouseID = w.WarehouseID
    WHERE i.CurrentStock <= p.MinStockLevel
    AND p.IsActive = 1
    ORDER BY (i.CurrentStock - p.MinStockLevel) ASC;
END;
GO

-- Procedure for sales report
CREATE PROCEDURE sp_GetSalesReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        CAST(o.OrderDate AS DATE) as SaleDate,
        COUNT(o.OrderID) as TotalOrders,
        SUM(o.FinalAmount) as TotalRevenue,
        AVG(o.FinalAmount) as AverageOrderValue,
        SUM(od.Quantity) as TotalItemsSold
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.OrderDate >= @StartDate 
    AND o.OrderDate <= @EndDate
    AND o.Status = 'Completed'
    GROUP BY CAST(o.OrderDate AS DATE)
    ORDER BY SaleDate DESC;
END;
GO

-- Procedure to add coupon
CREATE PROCEDURE sp_AddCoupon
    @CouponCode NVARCHAR(20),
    @CouponName NVARCHAR(100),
    @Description NVARCHAR(500),
    @DiscountType NVARCHAR(20),
    @DiscountValue DECIMAL(10,2),
    @MinOrderAmount DECIMAL(10,2),
    @MaxDiscountAmount DECIMAL(10,2),
    @UsageLimit INT,
    @OrderLimit INT = 0,
    @StartDate DATETIME,
    @EndDate DATETIME,
    @CreatedBy INT
AS
BEGIN
    INSERT INTO Coupons (
        CouponCode, CouponName, Description, DiscountType, DiscountValue,
        MinOrderAmount, MaxDiscountAmount, UsageLimit, UsageCount,
        OrderLimit, StartDate, EndDate, IsActive, CreatedBy, CreatedDate
    )
    VALUES (
        @CouponCode, @CouponName, @Description, @DiscountType, @DiscountValue,
        @MinOrderAmount, @MaxDiscountAmount, @UsageLimit, 0,
        @OrderLimit, @StartDate, @EndDate, 1, @CreatedBy, GETDATE()
    );

    SELECT SCOPE_IDENTITY() AS CouponID;
END;
GO

-- Procedure to apply coupon to order
CREATE PROCEDURE sp_ApplyCouponToOrder
    @OrderID INT,
    @CouponCode NVARCHAR(20),
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Kiểm tra mã giảm giá hợp lệ
        DECLARE @CouponID INT, @UsageCount INT, @UsageLimit INT, @OrderLimit INT, @DiscountValue DECIMAL(10,2), @DiscountType NVARCHAR(20), @MinOrderAmount DECIMAL(10,2), @MaxDiscountAmount DECIMAL(10,2);
        
        SELECT 
            @CouponID = CouponID,
            @UsageCount = UsageCount,
            @UsageLimit = UsageLimit,
            @OrderLimit = OrderLimit,
            @DiscountValue = DiscountValue,
            @DiscountType = DiscountType,
            @MinOrderAmount = MinOrderAmount,
            @MaxDiscountAmount = MaxDiscountAmount
        FROM Coupons
        WHERE CouponCode = @CouponCode
        AND IsActive = 1
        AND StartDate <= GETDATE()
        AND EndDate >= GETDATE();

        IF @CouponID IS NULL
            THROW 50001, 'Mã giảm giá không hợp lệ hoặc đã hết hạn.', 1;

        IF @UsageCount >= @UsageLimit
            THROW 50002, 'Mã giảm giá đã hết số lần sử dụng.', 1;

        IF @OrderLimit > 0 AND (SELECT COUNT(*) FROM CouponUsage WHERE CouponID = @CouponID) >= @OrderLimit
            THROW 50003, 'Mã giảm giá đã đạt giới hạn số đơn hàng.', 1;

        -- Lấy tổng giá trị đơn hàng
        DECLARE @OrderTotal DECIMAL(12,2);
        SELECT @OrderTotal = FinalAmount FROM Orders WHERE OrderID = @OrderID;

        IF @OrderTotal IS NULL
            THROW 50004, 'Đơn hàng không tồn tại.', 1;

        IF @MinOrderAmount IS NOT NULL AND @OrderTotal < @MinOrderAmount
            THROW 50005, 'Tổng giá trị đơn hàng không đủ để áp dụng mã giảm giá.', 1;

        -- Tính discount amount
        DECLARE @DiscountAmount DECIMAL(10,2) = 0;
        IF @DiscountType = 'Percentage'
            SET @DiscountAmount = @OrderTotal * (@DiscountValue / 100);
        ELSE IF @DiscountType = 'Fixed'
            SET @DiscountAmount = @DiscountValue;

        IF @MaxDiscountAmount IS NOT NULL AND @DiscountAmount > @MaxDiscountAmount
            SET @DiscountAmount = @MaxDiscountAmount;

        -- Cập nhật đơn hàng với discount
        UPDATE Orders
        SET DiscountAmount = @DiscountAmount,
            FinalAmount = FinalAmount - @DiscountAmount
        WHERE OrderID = @OrderID;

        -- Ghi nhận sử dụng mã giảm giá
        INSERT INTO CouponUsage (CouponID, OrderID, UsedDate, DiscountAmount)
        VALUES (@CouponID, @OrderID, GETDATE(), @DiscountAmount);

        -- Cập nhật UsageCount
        UPDATE Coupons
        SET UsageCount = UsageCount + 1
        WHERE CouponID = @CouponID;

        COMMIT TRANSACTION;
        SELECT @DiscountAmount AS AppliedDiscount;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;
END;
GO



ALTER TABLE ShoppingCart
ADD Unit NVARCHAR(50) NULL;

-- Cập nhật Unit cho các bản ghi hiện có (nếu cần)
UPDATE ShoppingCart
SET Unit = (SELECT Unit FROM Products p WHERE p.ProductID = ShoppingCart.ProductID)
WHERE Unit IS NULL;



USE Fmart;
GO

-- Insert Suppliers
INSERT INTO Suppliers (SupplierName, ContactPerson, PhoneNumber, Email, Address, TaxCode, IsActive, CreatedDate, Notes)
VALUES 
    ('FMart Fresh Foods', 'Nguyen Van A', '0901234567', 'contact@fmart-fresh.com', '123 Nguyen Hue St, Ho Chi Minh City', 'TAX001', 1, GETDATE(), 'Main supplier for fresh products'),
    ('Global Grocery Co.', 'Tran Thi B', '0902345678', 'info@globalgrocery.com', '456 Le Loi St, Ha Noi', 'TAX002', 1, GETDATE(), 'International grocery supplier'),
    ('Vietnam Agriculture', 'Le Van C', '0903456789', 'sales@vn-agri.com', '789 Dong Khoi St, Da Nang', 'TAX003', 1, GETDATE(), 'Local agriculture products'),
    ('Vinamilk Distributor', 'Pham Thi D', '0904567890', 'sales@vinamilk.com', '321 Tran Hung Dao St, Ho Chi Minh City', 'TAX004', 1, GETDATE(), 'Dairy and beverage supplier'),
    ('Uniben Co.', 'Hoang Van E', '0905678901', 'info@uniben.com', '654 Ba Trieu St, Ha Noi', 'TAX005', 1, GETDATE(), 'Instant noodles supplier'),
    ('Trung Nguyen Coffee', 'Le Thi F', '0906789012', 'sales@trungnguyen.com', '987 Hai Ba Trung St, Da Nang', 'TAX006', 1, GETDATE(), 'Coffee products supplier'),
    ('Masan Group', 'Nguyen Van G', '0907890123', 'info@masan.com', '123 Le Duan St, Ho Chi Minh City', 'TAX007', 1, GETDATE(), 'Sauces and instant noodles supplier'),
    ('Nestlé Vietnam', 'Tran Van H', '0908901234', 'sales@nestle.com', '456 Nguyen Trai St, Ho Chi Minh City', 'TAX008', 1, GETDATE(), 'International food and beverage supplier'),
    ('PepsiCo Vietnam', 'Le Van I', '0909012345', 'info@pepsico.com', '789 Pham Van Dong St, Ha Noi', 'TAX009', 1, GETDATE(), 'Beverages and snacks supplier'),
    ('Unilever Vietnam', 'Nguyen Thi K', '0910123456', 'info@unilever.com', '321 Ly Thuong Kiet St, Ho Chi Minh City', 'TAX010', 1, GETDATE(), 'Personal and home care supplier');

-- Insert Warehouses
INSERT INTO Warehouses (WarehouseName, Location)
VALUES 
    ('Main Warehouse', 'District 1, Ho Chi Minh City'),
    ('North Branch Warehouse', 'Cau Giay, Ha Noi'),
    ('Central Branch Warehouse', 'Hai Chau, Da Nang');

-- Insert Categories
INSERT INTO Categories (CategoryName, Description, ParentCategoryID, ImageUrl, IsActive, CreatedDate, DisplayOrder)
VALUES 
    ('Vegetables & Fruits', 'Fresh vegetables and fruits from local farms', NULL, 'images/category/icon-1.svg', 1, GETDATE(), 1),
    ('Grocery & Staples', 'Essential grocery items and staples for daily cooking', NULL, 'images/category/icon-2.svg', 1, GETDATE(), 2),
    ('Dairy & Eggs', 'Fresh dairy products and farm eggs', NULL, 'images/category/icon-3.svg', 1, GETDATE(), 3),
    ('Beverages', 'All kinds of beverages and drinks', NULL, 'images/category/icon-4.svg', 1, GETDATE(), 4),
    ('Snacks', 'Delicious snacks and treats for all ages', NULL, 'images/category/icon-5.svg', 1, GETDATE(), 5),
    ('Home Care', 'Home cleaning and care products', NULL, 'images/category/icon-6.svg', 1, GETDATE(), 6),
    ('Noodles & Sauces', 'Noodles, pasta and various sauces', NULL, 'images/category/icon-7.svg', 1, GETDATE(), 7),
    ('Personal Care', 'Personal hygiene and care products', NULL, 'images/category/icon-8.svg', 1, GETDATE(), 8),
    ('Pet Care', 'Products for your beloved pets', NULL, 'images/category/icon-9.svg', 1, GETDATE(), 9),
    ('Meat & Seafood', 'Fresh meat and seafood products', NULL, 'images/category/icon-10.svg', 1, GETDATE(), 10),
    ('Electronics', 'Electronic products and gadgets', NULL, 'images/category/icon-11.svg', 1, GETDATE(), 11);

-- Insert Products for Category 1: Vegetables & Fruits
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Fresh Spinach', 'SPINACH001', 1, 1, 'Fresh spinach leaves, nutrient-rich', 'kg', 1.00, 1.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '10x10x5 cm', 5, 'FMart Fresh', 'Vietnam'),
('Fresh Cucumber', 'CUCUMBER001', 1, 1, 'Crisp cucumbers, farm fresh', 'kg', 0.80, 1.49, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '15x5x5 cm', 10, 'FMart Fresh', 'Vietnam'),
('Fresh Lettuce', 'LETTUCE001', 1, 1, 'Crisp lettuce for salads', 'kg', 1.20, 2.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '10x10x10 cm', 5, 'FMart Fresh', 'Vietnam'),
('Fresh Mangoes', 'MANGO001', 1, 1, 'Sweet and juicy mangoes', 'kg', 3.00, 4.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '10x10x10 cm', 5, 'FMart Fresh', 'Vietnam'),
('Fresh Dragon Fruit', 'DRAGON001', 1, 1, 'Exotic dragon fruit, sweet', 'piece', 2.50, 3.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '10x10x12 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Pineapple', 'PINEAPPLE001', 1, 1, 'Sweet tropical pineapples', 'piece', 2.00, 3.29, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '15x15x20 cm', 10, 'Dole', 'Philippines'),
('Fresh Avocados', 'AVOCADO001', 1, 1, 'Creamy avocados, rich in fats', 'piece', 1.50, 2.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '8x8x10 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Bell Peppers', 'PEPPER001', 1, 1, 'Colorful bell peppers, crunchy', 'kg', 2.00, 3.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '8x8x8 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Watermelon', 'WATERMELON001', 1, 1, 'Juicy watermelon, refreshing', 'kg', 1.00, 1.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '20x20x20 cm', 10, 'FMart Fresh', 'Vietnam'),
('Fresh Papaya', 'PAPAYA001', 1, 1, 'Sweet papaya, vitamin-rich', 'piece', 1.50, 2.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.80, '15x10x10 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Grapes', 'GRAPE001', 1, 1, 'Sweet red grapes, seedless', 'kg', 3.00, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x8 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Tomatoes', 'TOMATO001', 1, 1, 'Juicy red tomatoes, farm fresh', 'kg', 1.20, 2.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '8x8x8 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Carrots', 'CARROT001', 1, 1, 'Crisp carrots, rich in vitamins', 'kg', 0.90, 1.79, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '15x3x3 cm', 10, 'FMart Fresh', 'Vietnam'),
('Fresh Bananas', 'BANANA001', 1, 1, 'Sweet and ripe bananas', 'kg', 1.00, 1.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '12x12x15 cm', 5, 'Chiquita', 'Philippines'),
('Fresh Oranges', 'ORANGE001', 1, 1, 'Juicy oranges, vitamin C-rich', 'kg', 2.00, 3.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '10x10x10 cm', 7, 'Dole', 'USA'),
('Fresh Green Apples', 'APPLE001', 1, 1, 'Crisp green apples, tart and refreshing', 'kg', 2.20, 3.79, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x8 cm', 7, 'FMart Fresh', 'Vietnam'),
('Fresh Strawberries', 'STRAWBERRY001', 1, 1, 'Sweet and juicy strawberries', 'kg', 4.00, 6.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x8 cm', 5, 'FMart Fresh', 'Vietnam'),
('Fresh Zucchini', 'ZUCCHINI001', 1, 1, 'Fresh zucchini, versatile for cooking', 'kg', 1.30, 2.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '15x5x5 cm', 7, 'FMart Fresh', 'Vietnam'),
('Vissan Pork Sausage', 'SAUSAGE001', 1, 2, 'Premium pork sausage, 500g pack', 'pack', 3.50, 5.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x10x5 cm', 30, 'Vissan', 'Vietnam'),
('Vissan Ham', 'HAM001', 1, 2, 'Sliced pork ham, 200g pack', 'pack', 2.50, 4.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '15x10x3 cm', 30, 'Vissan', 'Vietnam');

-- Insert Products for Category 2: Grocery & Staples
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Uniben 3 Miền Beef Noodles', 'NOODLE001', 2, 5, 'Instant beef noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Hảo Hảo Shrimp Noodles', 'NOODLE002', 2, 5, 'Spicy shrimp instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Trung Nguyên G7 Instant Coffee', 'COFFEE001', 2, 6, 'Instant coffee, 16g sachet, 20 sachets', 'box', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.32, '15x10x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Masan Omachi Potato Noodles', 'NOODLE003', 2, 7, 'Premium potato noodles, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Masan', 'Vietnam'),
('Cai Lan Neptune Cooking Oil', 'OIL001', 2, 2, 'Pure palm cooking oil, 1L bottle', 'bottle', 3.00, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 365, 'Cai Lan', 'Vietnam'),
('Uniben 3 Miền Chicken Noodles', 'NOODLE004', 2, 5, 'Instant chicken noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Trung Nguyên Legend Coffee Beans', 'COFFEE002', 2, 6, 'Roasted coffee beans, 500g pack', 'pack', 5.00, 8.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Masan Chin-su Fish Sauce', 'SAUCE001', 2, 7, 'Premium fish sauce, 500ml bottle', 'bottle', 1.50, 2.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 1095, 'Masan', 'Vietnam'),
('Acecook De Nhat Beef Noodles', 'NOODLE005', 2, 5, 'Premium beef instant noodles, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Cai Lan Simply Canola Oil', 'OIL002', 2, 2, 'Pure canola cooking oil, 1L bottle', 'bottle', 3.50, 5.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 365, 'Cai Lan', 'Vietnam'),
('Uniben 3 Miền Seafood Noodles', 'NOODLE006', 2, 5, 'Instant seafood noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Trung Nguyên G7 Black Coffee', 'COFFEE003', 2, 6, 'Black instant coffee, 15g sachet, 20 sachets', 'box', 1.80, 3.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '15x10x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Masan Chin-su Chili Sauce', 'SAUCE002', 2, 7, 'Spicy chili sauce, 250ml bottle', 'bottle', 1.20, 2.49, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x15 cm', 365, 'Masan', 'Vietnam'),
('Acecook Lau Thai Noodles', 'NOODLE007', 2, 5, 'Thai hot pot instant noodles, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Cai Lan Meizan Soybean Oil', 'OIL003', 2, 2, 'Pure soybean cooking oil, 1L bottle', 'bottle', 3.20, 5.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 365, 'Cai Lan', 'Vietnam'),
('Kraft Heinz Baked Beans', 'BEANS001', 2, 2, 'Baked beans in tomato sauce, 420g can', 'can', 1.80, 3.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.42, '8x8x10 cm', 730, 'Kraft Heinz', 'USA'),
('Nestlé Milo Powder', 'MILO001', 2, 8, 'Chocolate malt drink powder, 400g tin', 'tin', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '10x10x12 cm', 365, 'Nestlé', 'Switzerland'),
('Uniben 3 Miền Pork Noodles', 'NOODLE008', 2, 5, 'Instant pork noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Masan Chin-su Soy Sauce', 'SAUCE003', 2, 7, 'Premium soy sauce, 500ml bottle', 'bottle', 1.50, 2.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 1095, 'Masan', 'Vietnam'),
('Acecook Phở Bò Noodles', 'NOODLE009', 2, 5, 'Beef phở instant noodles, 70g pack', 'pack', 0.25, 0.59, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.07, '15x10x5 cm', 180, 'Acecook', 'Vietnam');

-- Insert Products for Category 3: Dairy & Eggs
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Vinamilk Fresh Milk', 'MILK001', 3, 4, 'Pasteurized fresh milk, 1L carton', 'carton', 2.00, 3.49, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '7x7x20 cm', 7, 'Vinamilk', 'Vietnam'),
('Vinamilk Skimmed Milk', 'MILK002', 3, 4, 'Low-fat skimmed milk, 1L carton', 'carton', 1.90, 3.39, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '7x7x20 cm', 7, 'Vinamilk', 'Vietnam'),
('Vinamilk Organic Milk', 'MILK003', 3, 4, 'Organic fresh milk, 1L carton', 'carton', 2.50, 4.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '7x7x20 cm', 7, 'Vinamilk', 'Vietnam'),
('Vinamilk Strawberry Yogurt', 'YOGURT001', 3, 4, 'Strawberry flavored yogurt, 500g container', 'container', 2.70, 5.29, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '12x12x8 cm', 21, 'Vinamilk', 'Vietnam'),
('Vinamilk Plain Yogurt', 'YOGURT002', 3, 4, 'Natural plain yogurt, 500g container', 'container', 2.50, 4.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '12x12x8 cm', 21, 'Vinamilk', 'Vietnam'),
('Vinamilk Fruit Yogurt', 'YOGURT003', 3, 4, 'Mixed fruit yogurt, 4x125g pack', 'pack', 2.80, 5.49, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '15x10x8 cm', 21, 'Vinamilk', 'Vietnam'),
('Vinamilk Mozzarella Cheese', 'CHEESE001', 3, 4, 'Fresh mozzarella cheese, 200g pack', 'pack', 4.50, 8.49, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '15x10x3 cm', 30, 'Vinamilk', 'Vietnam'),
('Vinamilk Cream Cheese', 'CHEESE002', 3, 4, 'Smooth cream cheese, 200g tub', 'tub', 3.50, 6.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '12x8x5 cm', 30, 'Vinamilk', 'Vietnam'),
('Nutifood Fresh Milk', 'MILK004', 3, 4, 'Nutritious fresh milk, 1L carton', 'carton', 2.10, 3.59, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '7x7x20 cm', 7, 'Nutifood', 'Vietnam'),
('Nutifood Chocolate Milk', 'MILK005', 3, 4, 'Chocolate flavored milk, 500ml bottle', 'bottle', 1.50, 2.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x15 cm', 14, 'Nutifood', 'Vietnam'),
('Nutifood Plain Yogurt', 'YOGURT004', 3, 4, 'Natural plain yogurt, 500g container', 'container', 2.60, 5.19, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '12x12x8 cm', 21, 'Nutifood', 'Vietnam'),
('Farm Fresh Eggs', 'EGGS001', 3, 1, 'Fresh farm eggs, dozen pack', 'dozen', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.80, '30x20x8 cm', 14, 'FMart Fresh', 'Vietnam'),
('Organic Free-Range Eggs', 'EGGS002', 3, 1, 'Organic free-range eggs, dozen pack', 'dozen', 3.00, 5.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.80, '30x20x8 cm', 14, 'FMart Fresh', 'Vietnam'),
('Quail Eggs', 'EGGS003', 3, 1, 'Fresh quail eggs, 24 pieces pack', 'pack', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '20x15x5 cm', 14, 'FMart Fresh', 'Vietnam'),
('Duck Eggs', 'EGGS004', 3, 1, 'Fresh duck eggs, 10 pieces pack', 'pack', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.70, '25x15x8 cm', 14, 'FMart Fresh', 'Vietnam'),
('Vinamilk Salted Butter', 'BUTTER001', 3, 4, 'Premium salted butter, 250g pack', 'pack', 3.80, 7.49, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '12x8x4 cm', 60, 'Vinamilk', 'Vietnam'),
('Vinamilk Unsalted Butter', 'BUTTER002', 3, 4, 'Premium unsalted butter, 250g pack', 'pack', 3.50, 6.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '12x8x4 cm', 60, 'Vinamilk', 'Vietnam'),
('Vinamilk Whipped Cream', 'CREAM001', 3, 4, 'Whipped cream, 250ml can', 'can', 3.00, 5.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x20 cm', 30, 'Vinamilk', 'Vietnam'),
('Nutifood Strawberry Yogurt', 'YOGURT005', 3, 4, 'Strawberry flavored yogurt, 500g container', 'container', 2.70, 5.29, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '12x12x8 cm', 21, 'Nutifood', 'Vietnam'),
('Nestlé Carnation Evaporated Milk', 'MILK006', 3, 8, 'Evaporated milk, 380g can', 'can', 1.80, 3.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.38, '8x8x10 cm', 365, 'Nestlé', 'Switzerland');

-- Insert Products for Category 4: Beverages
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Vinamilk Fresh Orange Juice', 'JUICE001', 4, 4, 'Freshly squeezed orange juice, 1L bottle', 'bottle', 3.00, 5.99, 45, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 7, 'Vinamilk', 'Vietnam'),
('Coca-Cola Classic', 'COLA001', 4, 9, 'Classic cola soft drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Coca-Cola', 'USA'),
('Pepsi Zero Sugar', 'COLA002', 4, 9, 'Zero sugar cola drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'PepsiCo', 'USA'),
('Trung Nguyên Premium Green Tea', 'TEA001', 4, 6, 'Premium green tea bags, 20 pieces', 'box', 4.00, 7.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x10x8 cm', 730, 'Trung Nguyên', 'Vietnam'),
('Nestlé Pure Life Water', 'WATER001', 4, 8, 'Natural mineral water, 1.5L bottle', 'bottle', 1.00, 2.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '9x9x30 cm', 365, 'Nestlé', 'Switzerland'),
('Vinamilk Iced Milk Tea', 'TEA002', 4, 4, 'Iced milk tea, 500ml bottle', 'bottle', 1.80, 3.49, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Vinamilk', 'Vietnam'),
('PepsiCo Lipton Green Tea', 'TEA003', 4, 9, 'Green tea with lemon, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'PepsiCo', 'USA'),
('Coca-Cola Sprite', 'COLA003', 4, 9, 'Lemon-lime soft drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Coca-Cola', 'USA'),
('Trung Nguyên Legend Espresso', 'COFFEE004', 4, 6, 'Espresso coffee beans, 500g pack', 'pack', 5.50, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Nestlé Nescafé Instant Coffee', 'COFFEE005', 4, 8, 'Instant coffee, 100g jar', 'jar', 2.80, 5.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '8x8x10 cm', 365, 'Nestlé', 'Switzerland'),
('Vinamilk Passion Fruit Juice', 'JUICE002', 4, 4, 'Passion fruit juice, 1L bottle', 'bottle', 3.00, 5.99, 45, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 7, 'Vinamilk', 'Vietnam'),
('PepsiCo Mountain Dew', 'COLA004', 4, 9, 'Citrus-flavored soft drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'PepsiCo', 'USA'),
('Coca-Cola Fanta Orange', 'COLA005', 4, 9, 'Orange-flavored soft drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Coca-Cola', 'USA'),
('Trung Nguyên G7 Cappuccino', 'COFFEE006', 4, 6, 'Cappuccino instant coffee, 20g sachet, 12 sachets', 'box', 2.20, 4.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.24, '15x10x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Nestlé Nestea Lemon Iced Tea', 'TEA004', 4, 8, 'Lemon iced tea, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Nestlé', 'Switzerland'),
('Vinamilk Mango Juice', 'JUICE003', 4, 4, 'Mango juice, 1L bottle', 'bottle', 3.00, 5.99, 45, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 7, 'Vinamilk', 'Vietnam'),
('PepsiCo 7UP', 'COLA006', 4, 9, 'Lemon-lime soft drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'PepsiCo', 'USA'),
('Coca-Cola Coke Zero', 'COLA007', 4, 9, 'Zero sugar cola drink, 500ml bottle', 'bottle', 1.50, 2.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 180, 'Coca-Cola', 'USA'),
('Trung Nguyên G7 Mocha', 'COFFEE007', 4, 6, 'Mocha instant coffee, 18g sachet, 12 sachets', 'box', 2.20, 4.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.22, '15x10x8 cm', 365, 'Trung Nguyên', 'Vietnam'),
('Nestlé Pure Life Sparkling Water', 'WATER002', 4, 8, 'Sparkling mineral water, 500ml bottle', 'bottle', 1.20, 2.49, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 365, 'Nestlé', 'Switzerland');

-- Insert Products for Category 5: Snacks
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('PepsiCo Lay’s Classic Chips', 'CHIPS001', 5, 9, 'Classic potato chips, 200g bag', 'bag', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '25x20x8 cm', 90, 'PepsiCo', 'USA'),
('Mars Snickers Bar', 'CHOCO001', 5, 8, 'Chocolate bar with peanuts, 50g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '10x3x2 cm', 365, 'Mars', 'USA'),
('Nestlé KitKat Chunky', 'CHOCO002', 5, 8, 'Chunky chocolate wafer bar, 40g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.04, '10x3x2 cm', 365, 'Nestlé', 'Switzerland'),
('Kraft Heinz Oreo Cookies', 'COOKIE001', 5, 2, 'Chocolate sandwich cookies, 300g pack', 'pack', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '25x20x5 cm', 180, 'Kraft Heinz', 'USA'),
('PepsiCo Doritos Nacho Cheese', 'CHIPS002', 5, 9, 'Nacho cheese tortilla chips, 200g bag', 'bag', 2.20, 4.29, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '25x20x8 cm', 90, 'PepsiCo', 'USA'),
('Mars M&M’s Milk Chocolate', 'CHOCO003', 5, 8, 'Milk chocolate candies, 100g pack', 'pack', 1.80, 3.49, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x8x2 cm', 365, 'Mars', 'USA'),
('Nestlé Crunch Bar', 'CHOCO004', 5, 8, 'Milk chocolate with rice crisps, 100g', 'bar', 1.80, 3.49, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x8x2 cm', 365, 'Nestlé', 'Switzerland'),
('Kraft Heinz Ritz Crackers', 'CRACKER001', 5, 2, 'Salty crackers, 200g pack', 'pack', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x8 cm', 180, 'Kraft Heinz', 'USA'),
('PepsiCo Lay’s Salt & Vinegar Chips', 'CHIPS003', 5, 9, 'Salt and vinegar potato chips, 200g bag', 'bag', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '25x20x8 cm', 90, 'PepsiCo', 'USA'),
('Mars Twix Bar', 'CHOCO005', 5, 8, 'Caramel and biscuit chocolate bar, 50g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '10x3x2 cm', 365, 'Mars', 'USA'),
('Nestlé Milo Snack Bar', 'SNACK001', 5, 8, 'Chocolate malt snack bar, 30g', 'bar', 0.80, 1.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.03, '10x3x2 cm', 365, 'Nestlé', 'Switzerland'),
('Kraft Heinz Cheez-It Crackers', 'CRACKER002', 5, 2, 'Cheese-flavored crackers, 200g pack', 'pack', 2.20, 4.29, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x8 cm', 180, 'Kraft Heinz', 'USA'),
('PepsiCo Cheetos Puffs', 'CHIPS004', 5, 9, 'Cheese-flavored puffed corn snacks, 200g bag', 'bag', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '25x20x8 cm', 90, 'PepsiCo', 'USA'),
('Mars Bounty Bar', 'CHOCO006', 5, 8, 'Coconut chocolate bar, 57g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.06, '10x3x2 cm', 365, 'Mars', 'USA'),
('Nestlé Smarties', 'CHOCO007', 5, 8, 'Colorful chocolate candies, 100g pack', 'pack', 1.80, 3.49, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x8x2 cm', 365, 'Nestlé', 'Switzerland'),
('Kraft Heinz Planters Mixed Nuts', 'NUTS001', 5, 2, 'Roasted mixed nuts, 250g pack', 'pack', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '20x15x5 cm', 365, 'Kraft Heinz', 'USA'),
('PepsiCo Lay’s Barbecue Chips', 'CHIPS005', 5, 9, 'Barbecue-flavored potato chips, 200g bag', 'bag', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '25x20x8 cm', 90, 'PepsiCo', 'USA'),
('Mars Milky Way Bar', 'CHOCO008', 5, 8, 'Milk chocolate and nougat bar, 50g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '10x3x2 cm', 365, 'Mars', 'USA'),
('Nestlé Lion Bar', 'CHOCO009', 5, 8, 'Caramel and wafer chocolate bar, 50g', 'bar', 1.00, 1.99, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '10x3x2 cm', 365, 'Nestlé', 'Switzerland'),
('Kraft Heinz Triscuit Crackers', 'CRACKER003', 5, 2, 'Whole grain crackers, 200g pack', 'pack', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x8 cm', 180, 'Kraft Heinz', 'USA');

-- Insert Products for Category 6: Home Care
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Unilever Sunlight Dishwashing Liquid', 'SOAP001', 6, 10, 'Lemon-scented dishwashing liquid, 500ml bottle', 'bottle', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Cif All-Purpose Cleaner', 'CLEANER001', 6, 10, 'Multi-surface cleaner, 750ml spray bottle', 'bottle', 3.00, 5.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.75, '10x10x25 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Omo Laundry Detergent', 'DETERGENT001', 6, 10, 'Laundry detergent powder, 1kg box', 'box', 5.00, 8.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '25x20x15 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Comfort Fabric Softener', 'SOFTENER001', 6, 10, 'Fabric softener, 1L bottle', 'bottle', 3.50, 6.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Vim Toilet Bowl Cleaner', 'CLEANER002', 6, 10, 'Toilet bowl cleaner, 500ml bottle', 'bottle', 2.20, 4.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Sunlight Floor Cleaner', 'CLEANER003', 6, 10, 'Floor cleaner, 1L bottle', 'bottle', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Sunlight Dishwashing Paste', 'SOAP002', 6, 10, 'Dishwashing paste, 400g tub', 'tub', 1.80, 3.49, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '12x12x8 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Omo Liquid Detergent', 'DETERGENT002', 6, 10, 'Liquid laundry detergent, 1L bottle', 'bottle', 5.50, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '8x8x25 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Domestos Bleach', 'CLEANER004', 6, 10, 'Bleach cleaner, 750ml bottle', 'bottle', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.75, '10x10x25 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Cif Glass Cleaner', 'CLEANER005', 6, 10, 'Glass and surface cleaner, 500ml spray bottle', 'bottle', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('FMart Soft Toilet Paper', 'TISSUE001', 6, 3, 'Soft toilet paper, 12 rolls pack, 3-ply', 'pack', 8.00, 12.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x30x20 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Absorbent Paper Towels', 'TOWEL001', 6, 3, 'Absorbent paper towels, 6 rolls pack', 'pack', 6.00, 9.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '35x25x20 cm', 1095, 'FMart Fresh', 'Vietnam'),
('Unilever Sunlight Dishwashing Liquid Green Tea', 'SOAP003', 6, 10, 'Green tea-scented dishwashing liquid, 500ml bottle', 'bottle', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Cif Kitchen Cleaner', 'CLEANER006', 6, 10, 'Kitchen degreaser, 500ml spray bottle', 'bottle', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Omo Stain Remover', 'DETERGENT003', 6, 10, 'Stain remover powder, 500g pack', 'pack', 3.00, 5.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x5 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Comfort Scent Booster', 'SOFTENER002', 6, 10, 'Scent booster beads, 500g pack', 'pack', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x5 cm', 1095, 'Unilever', 'Netherlands'),
('FMart Facial Tissue', 'TISSUE002', 6, 3, 'Soft facial tissue, 200 sheets pack', 'pack', 1.50, 2.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x8 cm', 1095, 'FMart Fresh', 'Vietnam'),
('Unilever Domestos Toilet Gel', 'CLEANER007', 6, 10, 'Toilet bowl cleaning gel, 500ml bottle', 'bottle', 2.20, 4.29, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Sunlight Dishwashing Liquid Lavender', 'SOAP004', 6, 10, 'Lavender-scented dishwashing liquid, 500ml bottle', 'bottle', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Cif Bathroom Cleaner', 'CLEANER008', 6, 10, 'Bathroom cleaner, 500ml spray bottle', 'bottle', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands');

-- Insert Products for Category 7: Noodles & Sauces
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Uniben 3 Miền Instant Ramen', 'NOODLE010', 7, 5, 'Chicken-flavored instant ramen, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Hảo Hảo Spicy Beef Noodles', 'NOODLE011', 7, 5, 'Spicy beef instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Masan Omachi Shrimp Noodles', 'NOODLE012', 7, 7, 'Shrimp-flavored instant noodles, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Masan', 'Vietnam'),
('Kraft Heinz Spaghetti', 'PASTA001', 7, 2, 'Authentic Italian spaghetti, 500g pack', 'pack', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '30x5x5 cm', 730, 'Kraft Heinz', 'USA'),
('Kraft Heinz Tomato Pasta Sauce', 'SAUCE004', 7, 2, 'Rich tomato pasta sauce, 400g jar', 'jar', 2.50, 4.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x12 cm', 730, 'Kraft Heinz', 'USA'),
('Masan Chin-su Spicy Chili Sauce', 'SAUCE005', 7, 7, 'Extra spicy chili sauce, 250ml bottle', 'bottle', 1.50, 2.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x15 cm', 365, 'Masan', 'Vietnam'),
('Uniben 3 Miền Mushroom Noodles', 'NOODLE013', 7, 5, 'Mushroom-flavored instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Hảo Hảo Chicken Noodles', 'NOODLE014', 7, 5, 'Chicken-flavored instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Masan Chin-su Soy Sauce', 'SAUCE006', 7, 7, 'Premium soy sauce, 500ml bottle', 'bottle', 1.50, 2.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 1095, 'Masan', 'Vietnam'),
('Kraft Heinz Alfredo Sauce', 'SAUCE007', 7, 2, 'Creamy Alfredo pasta sauce, 400g jar', 'jar', 2.80, 5.49, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x12 cm', 730, 'Kraft Heinz', 'USA'),
('Uniben 3 Miền Spicy Noodles', 'NOODLE015', 7, 5, 'Spicy instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Phở Gà Noodles', 'NOODLE016', 7, 5, 'Chicken phở instant noodles, 70g pack', 'pack', 0.25, 0.59, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.07, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Masan Chin-su Fish Sauce Premium', 'SAUCE008', 7, 7, 'Premium fish sauce, 500ml bottle', 'bottle', 2.00, 3.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '6x6x20 cm', 1095, 'Masan', 'Vietnam'),
('Kraft Heinz Penne Pasta', 'PASTA002', 7, 2, 'Penne pasta, 500g pack', 'pack', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '30x5x5 cm', 730, 'Kraft Heinz', 'USA'),
('Uniben 3 Miền Crab Noodles', 'NOODLE017', 7, 5, 'Crab-flavored instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Hủ Tiếu Nam Vang', 'NOODLE018', 7, 5, 'Nam Vang-style instant noodles, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam'),
('Masan Chin-su Garlic Chili Sauce', 'SAUCE009', 7, 7, 'Garlic chili sauce, 250ml bottle', 'bottle', 1.50, 2.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x15 cm', 365, 'Masan', 'Vietnam'),
('Kraft Heinz Pesto Sauce', 'SAUCE010', 7, 2, 'Basil pesto sauce, 190g jar', 'jar', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.19, '6x6x10 cm', 730, 'Kraft Heinz', 'USA'),
('Uniben 3 Miền Vegetable Noodles', 'NOODLE019', 7, 5, 'Vegetable-flavored instant noodles, 75g pack', 'pack', 0.20, 0.49, 100, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Uniben', 'Vietnam'),
('Acecook Bún Bò Huế Noodles', 'NOODLE020', 7, 5, 'Huế-style beef noodle soup, 80g pack', 'pack', 0.30, 0.69, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '15x10x5 cm', 180, 'Acecook', 'Vietnam');

-- Insert Products for Category 8: Personal Care (in English, fixed SKU)
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Unilever Dove Shampoo', 'SHAMPOO001_PC', 8, 10, 'Moisturizing shampoo, 400ml bottle', 'bottle', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Lifebuoy Body Wash', 'BODYSOAP001_PC', 8, 10, 'Antibacterial body wash, 500ml bottle', 'bottle', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Closeup Toothpaste', 'TOOTH001_PC', 8, 10, 'Fluoride toothpaste, 100ml tube, mint flavor', 'tube', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x5x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Dove Hand Crean', 'HANDCREAN001_PC', 8, 10, 'Moisturizing hand crean, 75ml tube', 'tube', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.08, '12x4x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Rexona Deodorant Spray', 'DEOD001_PC', 8, 10, 'Fresh scent deodorant spray, 150ml bottle', 'bottle', 3.50, 6.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '5x5x15 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Sunsilk Conditioner', 'COND001_PC', 8, 10, 'Nourishing conditioner, 400ml bottle', 'bottle', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Pepsodent Toothpaste', 'TOOTH002_PC', 8, 10, 'Whitening toothpaste, 100ml tube', 'tube', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x5x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Lux Body Wash', 'BODYSOAP002_PC', 8, 10, 'Floral-scented body wash, 500ml bottle', 'bottle', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Dove Body Lotion', 'LOTION001_PC', 8, 10, 'Hydrating body lotion, 400ml bottle', 'bottle', 4.50, 8.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Clear Shampoo', 'SHAMPOO002_PC', 8, 10, 'Anti-dandruff shampoo, 400ml bottle', 'bottle', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Lifebuoy Soap Bar', 'SOAP001_PC', 8, 10, 'Antibacterial soap bar, 150g', 'bar', 1.50, 2.99, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '10x6x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Dove Soap Bar', 'SOAP002_PC', 8, 10, 'Moisturizing soap bar, 150g', 'bar', 1.50, 2.99, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '10x6x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Rexona Roll-On Deodorant', 'DEOD002_PC', 8, 10, 'Long-lasting roll-on deodorant, 50ml', 'bottle', 2.00, 3.99, 60, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '5x5x10 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Sunsilk Shampoo', 'SHAMPOO003_PC', 8, 10, 'Shine-enhancing shampoo, 400ml bottle', 'bottle', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Lux Soap Bar', 'SOAP003_PC', 8, 10, 'Floral-scented soap bar, 150g', 'bar', 1.50, 2.99, 70, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '10x6x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Vaseline Lip Balm', 'BALM001_PC', 8, 10, 'Moisturizing lip balm, 10g stick', 'stick', 1.20, 2.49, 80, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.01, '5x2x2 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Clear Conditioner', 'COND002_PC', 8, 10, 'Anti-dandruff conditioner, 400ml bottle', 'bottle', 4.00, 7.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x20 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Dove Facial Cleanser', 'CLEANSER001_PC', 8, 10, 'Gentle facial cleanser, 100ml tube', 'tube', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x5x3 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Pepsodent Mouthwash', 'MOUTHWASH001_PC', 8, 10, 'Mint-flavored mouthwash, 250ml bottle', 'bottle', 2.50, 4.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x15 cm', 1095, 'Unilever', 'Netherlands'),
('Unilever Dove Body Scrub', 'SCRUB001_PC', 8, 10, 'Exfoliating body scrub, 250ml jar', 'jar', 3.50, 6.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '8x8x10 cm', 1095, 'Unilever', 'Netherlands');

-- Insert Products for Category 9: Pet Care
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Mars Pedigree Dry Dog Food', 'DOGFOOD001', 9, 8, 'Dry dog food, chicken flavor, 2kg bag', 'bag', 12.00, 19.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x25x15 cm', 365, 'Mars', 'USA'),
('Mars Whiskas Wet Cat Food', 'CATFOOD001', 9, 8, 'Wet cat food, salmon flavor, 400g can', 'can', 2.00, 3.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x10 cm', 730, 'Mars', 'USA'),
('Nestlé Purina Dog Chow', 'DOGFOOD002', 9, 8, 'Dry dog food, beef flavor, 2kg bag', 'bag', 11.00, 18.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x25x15 cm', 365, 'Nestlé', 'Switzerland'),
('Nestlé Purina Cat Chow', 'CATFOOD002', 9, 8, 'Dry cat food, chicken flavor, 1.5kg bag', 'bag', 8.00, 14.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '35x25x10 cm', 365, 'Nestlé', 'Switzerland'),
('Mars Pedigree Dog Treats', 'DOGTREAT001', 9, 8, 'Chicken-flavored dog treats, 200g pack', 'pack', 4.00, 6.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x5 cm', 365, 'Mars', 'USA'),
('Mars Whiskas Cat Treats', 'CATTREAT001', 9, 8, 'Fish-flavored cat treats, 100g pack', 'pack', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x10x5 cm', 365, 'Mars', 'USA'),
('Nestlé Purina Pro Plan Dog Food', 'DOGFOOD003', 9, 8, 'Premium dry dog food, 2kg bag', 'bag', 15.00, 24.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x25x15 cm', 365, 'Nestlé', 'Switzerland'),
('Nestlé Purina Pro Plan Cat Food', 'CATFOOD003', 9, 8, 'Premium dry cat food, 1.5kg bag', 'bag', 10.00, 17.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '35x25x10 cm', 365, 'Nestlé', 'Switzerland'),
('Mars Pedigree Wet Dog Food', 'DOGFOOD004', 9, 8, 'Wet dog food, beef flavor, 400g can', 'can', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x10 cm', 730, 'Mars', 'USA'),
('Mars Whiskas Dry Cat Food', 'CATFOOD004', 9, 8, 'Dry cat food, tuna flavor, 1.5kg bag', 'bag', 8.00, 14.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '35x25x10 cm', 365, 'Mars', 'USA'),
('FMart Pet Shampoo', 'PETSHAMP001', 9, 3, 'Gentle pet shampoo, 250ml bottle', 'bottle', 5.00, 8.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.25, '6x6x18 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Clumping Cat Litter', 'LITTER001', 9, 3, 'Clumping cat litter, 5kg bag', 'bag', 8.00, 14.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 5.00, '35x25x15 cm', 1095, 'FMart Fresh', 'Vietnam'),
('Mars Pedigree Puppy Food', 'DOGFOOD005', 9, 8, 'Dry puppy food, 2kg bag', 'bag', 12.00, 19.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x25x15 cm', 365, 'Mars', 'USA'),
('Nestlé Purina Kitten Food', 'CATFOOD005', 9, 8, 'Dry kitten food, 1.5kg bag', 'bag', 9.00, 16.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.50, '35x25x10 cm', 365, 'Nestlé', 'Switzerland'),
('Mars Pedigree Dental Chews', 'DOGTREAT002', 9, 8, 'Dental chews for dogs, 200g pack', 'pack', 4.50, 7.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x15x5 cm', 365, 'Mars', 'USA'),
('Mars Whiskas Temptations Treats', 'CATTREAT002', 9, 8, 'Chicken-flavored cat treats, 100g pack', 'pack', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x10x5 cm', 365, 'Mars', 'USA'),
('Nestlé Purina Friskies Wet Cat Food', 'CATFOOD006', 9, 8, 'Wet cat food, chicken flavor, 400g can', 'can', 2.00, 3.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x10 cm', 730, 'Nestlé', 'Switzerland'),
('FMart Pet Grooming Brush', 'BRUSH001', 9, 3, 'Pet grooming brush, 1 piece', 'piece', 3.00, 5.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x10x5 cm', 1095, 'FMart Fresh', 'Vietnam'),
('Mars Pedigree Beef Dog Food', 'DOGFOOD006', 9, 8, 'Dry dog food, beef flavor, 2kg bag', 'bag', 12.00, 19.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 2.00, '40x25x15 cm', 365, 'Mars', 'USA'),
('Nestlé Purina Fancy Feast Cat Food', 'CATFOOD007', 9, 8, 'Wet cat food, tuna flavor, 400g can', 'can', 2.50, 4.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.40, '8x8x10 cm', 730, 'Nestlé', 'Switzerland');

-- Insert Products for Category 10: Meat & Seafood
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('Vissan Fresh Chicken Breast', 'CHICKEN001', 10, 2, 'Fresh chicken breast, boneless and skinless', 'kg', 8.00, 12.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '25x15x5 cm', 3, 'Vissan', 'Vietnam'),
('Vissan Premium Beef Steak', 'BEEF001', 10, 2, 'Premium beef steak, grade A, 500g pack', 'pack', 15.00, 24.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 5, 'Vissan', 'Vietnam'),
('Vissan Fresh Ground Pork', 'PORK001', 10, 2, 'Fresh ground pork, lean meat', 'kg', 6.00, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '25x20x5 cm', 3, 'Vissan', 'Vietnam'),
('Vissan Pork Sausage', 'SAUSAGE002', 10, 2, 'Fresh pork sausage, 500g pack', 'pack', 3.50, 5.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x10x5 cm', 30, 'Vissan', 'Vietnam'),
('Vissan Smoked Ham', 'HAM002', 10, 2, 'Smoked ham slices, 200g pack', 'pack', 3.00, 5.49, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '15x10x3 cm', 30, 'Vissan', 'Vietnam'),
('FMart Fresh Shrimp', 'SHRIMP001', 10, 1, 'Large fresh shrimp, peeled and deveined', 'kg', 12.00, 19.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '25x20x8 cm', 2, 'FMart Fresh', 'Vietnam'),
('FMart Fresh Salmon Fillet', 'SALMON001', 10, 1, 'Fresh Atlantic salmon fillet, omega-3 rich', 'kg', 18.00, 29.99, 15, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '35x15x3 cm', 2, 'FMart Fresh', 'Vietnam'),
('Vissan Chicken Thighs', 'CHICKEN002', 10, 2, 'Fresh chicken thighs, bone-in', 'kg', 7.00, 11.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '25x15x5 cm', 3, 'Vissan', 'Vietnam'),
('Vissan Beef Ribs', 'BEEF002', 10, 2, 'Fresh beef ribs, 500g pack', 'pack', 10.00, 17.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 5, 'Vissan', 'Vietnam'),
('FMart Fresh Tilapia', 'FISH001', 10, 1, 'Fresh tilapia fish, whole', 'kg', 5.00, 8.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '30x15x5 cm', 2, 'FMart Fresh', 'Vietnam'),
('FMart Frozen Squid', 'SQUID001', 10, 1, 'Frozen squid, cleaned, 500g pack', 'pack', 6.00, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x5 cm', 30, 'FMart Fresh', 'Vietnam'),
('Vissan Pork Chops', 'PORK002', 10, 2, 'Fresh pork chops, 500g pack', 'pack', 7.00, 11.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 3, 'Vissan', 'Vietnam'),
('FMart Fresh Mackerel', 'FISH002', 10, 1, 'Fresh mackerel fish, whole', 'kg', 6.00, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '30x15x5 cm', 2, 'FMart Fresh', 'Vietnam'),
('Vissan Beef Brisket', 'BEEF003', 10, 2, 'Fresh beef brisket, 500g pack', 'pack', 12.00, 19.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 5, 'Vissan', 'Vietnam'),
('FMart Frozen Shrimp', 'SHRIMP002', 10, 1, 'Frozen shrimp, peeled, 500g pack', 'pack', 10.00, 16.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x5 cm', 30, 'FMart Fresh', 'Vietnam'),
('Vissan Chicken Wings', 'CHICKEN003', 10, 2, 'Fresh chicken wings, 500g pack', 'pack', 6.00, 9.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x5 cm', 3, 'Vissan', 'Vietnam'),
('FMart Fresh Tuna Steak', 'FISH003', 10, 1, 'Fresh tuna steak, 500g pack', 'pack', 15.00, 24.99, 15, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 2, 'FMart Fresh', 'Vietnam'),
('Vissan Pork Ribs', 'PORK003', 10, 2, 'Fresh pork ribs, 500g pack', 'pack', 8.00, 13.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x15x3 cm', 3, 'Vissan', 'Vietnam'),
('FMart Fresh Catfish', 'FISH004', 10, 1, 'Fresh catfish, whole', 'kg', 5.50, 9.49, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 1.00, '30x15x5 cm', 2, 'FMart Fresh', 'Vietnam'),
('Vissan Bacon Strips', 'BACON001', 10, 2, 'Smoked bacon strips, 200g pack', 'pack', 4.00, 6.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '15x10x3 cm', 30, 'Vissan', 'Vietnam');

-- Insert Products for Category 11: Electronics
INSERT INTO Products (ProductName, SKU, CategoryID, SupplierID, Description, Unit, CostPrice, SellingPrice, MinStockLevel, IsActive, CreatedDate, LastUpdated, Weight, Dimensions, ExpiryDays, Brand, Origin) VALUES
('FMart Bluetooth Speaker', 'SPEAKER001', 11, 3, 'Portable Bluetooth speaker, high quality sound', 'piece', 25.00, 49.99, 10, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '15x8x8 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart USB-C Charger', 'CHARGER001', 11, 3, 'Fast charging USB-C charger, 20W', 'piece', 8.00, 14.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '12x8x3 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart LED Light Bulb 9W', 'BULB001', 11, 3, 'Energy-efficient LED bulb, 9W, warm white', 'piece', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '8x8x12 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart 10000mAh Power Bank', 'POWER001', 11, 3, 'Portable power bank, 10000mAh, dual USB', 'piece', 15.00, 29.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '15x8x2 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Wireless Mouse', 'MOUSE001', 11, 3, 'Wireless optical mouse, ergonomic, 2.4GHz', 'piece', 10.00, 19.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '12x7x4 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart USB-A Charger', 'CHARGER002', 11, 3, 'Fast charging USB-A charger, 18W', 'piece', 7.00, 12.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '12x8x3 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart LED Light Bulb 12W', 'BULB002', 11, 3, 'Energy-efficient LED bulb, 12W, cool white', 'piece', 3.50, 6.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '8x8x12 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart 5000mAh Power Bank', 'POWER002', 11, 3, 'Portable power bank, 5000mAh, single USB', 'piece', 10.00, 19.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '10x6x2 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Wired Earphones', 'EARPHONE001', 11, 3, 'Wired earphones with mic, 1.2m cable', 'piece', 5.00, 9.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.05, '10x5x2 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Bluetooth Earbuds', 'EARPHONE002', 11, 3, 'Wireless Bluetooth earbuds, 10h battery', 'piece', 20.00, 39.99, 15, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '8x5x3 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart USB Hub', 'HUB001', 11, 3, '4-port USB hub, high-speed', 'piece', 8.00, 14.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '10x5x3 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart LED Desk Lamp', 'LAMP001', 11, 3, 'LED desk lamp, adjustable brightness', 'piece', 15.00, 29.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '20x10x10 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Wireless Keyboard', 'KEYBOARD001', 11, 3, 'Wireless keyboard, ergonomic, 2.4GHz', 'piece', 12.00, 24.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.50, '40x15x3 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart USB Flash Drive 32GB', 'FLASH001', 11, 3, '32GB USB flash drive, high-speed', 'piece', 6.00, 11.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.02, '5x2x1 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart HDMI Cable', 'CABLE001', 11, 3, 'HDMI cable, 1.5m, 4K support', 'piece', 5.00, 9.99, 40, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x10x2 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Portable Fan', 'FAN001', 11, 3, 'USB-powered portable fan, 5W', 'piece', 10.00, 19.99, 25, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.30, '15x10x10 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart LED Strip Lights', 'LIGHT001', 11, 3, 'LED strip lights, 2m, RGB', 'piece', 8.00, 15.99, 30, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '20x10x5 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Phone Holder', 'HOLDER001', 11, 3, 'Adjustable phone holder, desk mount', 'piece', 4.00, 7.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.15, '10x5x5 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart USB Extension Cable', 'CABLE002', 11, 3, 'USB extension cable, 2m', 'piece', 3.00, 5.99, 50, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.10, '15x10x2 cm', 1095, 'FMart Fresh', 'Vietnam'),
('FMart Wireless Charger', 'CHARGER003', 11, 3, 'Wireless charger, 10W, Qi-compatible', 'piece', 12.00, 24.99, 20, 1, '2025-06-25 08:00:00', '2025-06-25 08:00:00', 0.20, '10x10x2 cm', 1095, 'FMart Fresh', 'Vietnam');
 
-- Insert ProductImages for all products (CategoryID 1-11)
INSERT INTO ProductImages (ProductID, ImageUrl, AltText, IsMainImage, DisplayOrder, CreatedDate)
SELECT 
    ProductID,
    CONCAT('images/product/img-', ProductID, '.jpg') AS ImageUrl,
    CONCAT(ProductName, ' - Main Image') AS AltText,
    1 AS IsMainImage,
    1 AS DisplayOrder,
    '2025-06-25 08:00:00' AS CreatedDate
FROM Products
WHERE CategoryID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);

-- Insert Inventory for all products (CategoryID 1-11)
INSERT INTO Inventory (ProductID, WarehouseID, CurrentStock, ReservedStock, LastStockUpdate, Location)
SELECT 
    p.ProductID,
    1 AS WarehouseID, -- Main Warehouse
    p.MinStockLevel * 2 AS CurrentStock,
    0 AS ReservedStock,
    '2025-06-25 08:00:00' AS LastStockUpdate,
    CONCAT('Shelf-', p.CategoryID, '-', (p.ProductID % 10) + 1) AS Location
FROM Products p
WHERE p.CategoryID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);

-- Insert StockMovements for all products (CategoryID 1-11)
INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, MovementDate, Notes, UnitCost)
SELECT 
    p.ProductID,
    'IN' AS MovementType,
    p.MinStockLevel * 2 AS Quantity,
    'Initial Stock' AS Reason,
    NULL AS ReferenceID,
    'Initial Setup' AS ReferenceType,
    '2025-06-25 08:00:00' AS MovementDate,
    'Initial inventory setup' AS Notes,
    p.CostPrice AS UnitCost
FROM Products p
WHERE p.CategoryID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);

-- Print summary
PRINT 'Data inserted successfully!';
PRINT 'Products: 220 products added (20 per category for CategoryID 1-11)';
PRINT 'Product Images: Images assigned for CategoryID 1-11';
PRINT 'Inventory: Stock levels initialized for CategoryID 1-11';
PRINT 'Stock Movements: Initial stock movements recorded for CategoryID 1-11';

-- View summary
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount,
    AVG(p.SellingPrice) AS AvgPrice,
    SUM(i.CurrentStock) AS TotalStock
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
LEFT JOIN Inventory i ON p.ProductID = i.ProductID
WHERE c.IsActive = 1 AND (p.IsActive = 1 OR p.IsActive IS NULL) AND c.CategoryID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
GROUP BY c.CategoryID, c.CategoryName, c.DisplayOrder
ORDER BY c.DisplayOrder;





-- Chạy trong SQL Server Management Studio
CREATE TABLE ContactMessages (
    MessageID INT PRIMARY KEY IDENTITY(1,1),
    SenderName NVARCHAR(100) NOT NULL,
    SenderEmail NVARCHAR(255) NOT NULL,
    SenderPhone NVARCHAR(20),
    Subject NVARCHAR(200) NOT NULL,
    Message NTEXT NOT NULL,
    MessageType NVARCHAR(20) DEFAULT 'INQUIRY',
    Status NVARCHAR(20) DEFAULT 'NEW',
    Priority NVARCHAR(20) DEFAULT 'MEDIUM',
    CreatedDate DATETIME DEFAULT GETDATE(),
    UpdatedDate DATETIME NULL,
    AssignedTo INT NULL,
    Response NTEXT NULL,
    ResponseDate DATETIME NULL,
    CustomerIP NVARCHAR(45),
    UserAgent NTEXT,
    CustomerID INT NULL
);

-- Tạo indexes
CREATE INDEX IX_ContactMessages_Status ON ContactMessages(Status);
CREATE INDEX IX_ContactMessages_CreatedDate ON ContactMessages(CreatedDate);
CREATE INDEX IX_ContactMessages_CustomerID ON ContactMessages(CustomerID);