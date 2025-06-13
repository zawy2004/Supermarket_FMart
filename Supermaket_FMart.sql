CREATE DATABASE Fmart;
GO

USE Fmart;
GO

-- ================================================================
-- FMART SUPERMARKET MANAGEMENT SYSTEM DATABASE SCHEMA
-- Trường Đại học FPT - Nhóm D05-RT06
-- ================================================================

-- NEW 1. ROLES TABLE - Quản lý các vai trò người dùng (Bảng mới)
CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(20) UNIQUE NOT NULL -- Ví dụ: 'Customer', 'Staff', 'Admin'
);

-- 2. USERS TABLE - Quản lý tài khoản người dùng (Đã chỉnh sửa để sử dụng RoleID)
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    DateOfBirth DATE,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    RoleID INT DEFAULT 1, -- Khóa ngoại đến bảng Roles, mặc định Customer
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME,
    ProfileImageUrl NVARCHAR(255),
    StudentID NVARCHAR(20), -- Mã sinh viên (nếu có)
    Department NVARCHAR(100), -- Khoa/Phòng ban
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
    UsageLimit INT,
    UsageCount INT DEFAULT 0,
    UserLimit INT DEFAULT 1, -- Số lần mỗi user có thể sử dụng
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedBy INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- 19. COUPON USAGE TABLE - Lịch sử sử dụng coupon
CREATE TABLE CouponUsage (
    UsageID INT IDENTITY(1,1) PRIMARY KEY,
    CouponID INT NOT NULL,
    UserID INT NOT NULL,
    OrderID INT NOT NULL,
    UsedDate DATETIME DEFAULT GETDATE(),
    DiscountAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
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

-- ================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ================================================================

-- Users table indexes
CREATE INDEX IX_Users_Username ON Users(Username);
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Users_RoleID ON Users(RoleID); -- Cập nhật index cho RoleID
CREATE INDEX IX_Users_IsActive ON Users(IsActive);

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

-- Performance indexes for reporting
CREATE INDEX IX_Orders_OrderDate_Status ON Orders(OrderDate, Status);
CREATE INDEX IX_OrderDetails_ProductID_OrderID ON OrderDetails(ProductID, OrderID);
CREATE INDEX IX_StockMovements_ProductID_MovementDate ON StockMovements(ProductID, MovementDate);

-- ================================================================
-- INITIAL DATA SETUP
-- ================================================================

-- Insert default roles (Mới)
INSERT INTO Roles (RoleName) VALUES
('Customer'),
('Staff'),
('Admin'),
('Manager');

-- Insert default admin user (Đã chỉnh sửa để sử dụng RoleID)
INSERT INTO Users (Username, Email, PasswordHash, FullName, RoleID, IsActive)
VALUES (
    'admin',
    'admin@fmart.fpt.edu.vn',
    'hashed_password_here',
    'System Administrator',
    (SELECT RoleID FROM Roles WHERE RoleName = 'Admin'), -- Lấy RoleID của 'Admin'
    1
);

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
    
    -- Insert stock movement records
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

    -- Insert stock movement records
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
        w.WarehouseName -- Thêm tên kho
    FROM Products p
    INNER JOIN Inventory i ON p.ProductID = i.ProductID
    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
    INNER JOIN Warehouses w ON i.WarehouseID = w.WarehouseID
    WHERE i.CurrentStock <= p.MinStockLevel
    AND p.IsActive = 1
    ORDER BY (i.CurrentStock - p.MinStockLevel) ASC;
END;

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
-- NEW 23. DISPATCH RECEIPTS TABLE - Bảng Phiếu Xuất Kho
CREATE TABLE DispatchReceipts (
    DispatchID INT PRIMARY KEY IDENTITY,
    WarehouseID INT NOT NULL,
    DispatchDate DATE DEFAULT GETDATE(),
    -- Lý do xuất: Trả hàng NCC, Hủy hàng hỏng, Chuyển kho, Sử dụng nội bộ
    DispatchType NVARCHAR(50) NOT NULL CHECK (DispatchType IN ('Return to Supplier', 'Write-off', 'Internal Transfer', 'Internal Use')),
    CreatedBy INT, -- User tạo phiếu
    Reference NVARCHAR(255), -- Tham chiếu đến (nếu có): mã NCC, mã kho nhận
    Notes NVARCHAR(500),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);
GO

-- NEW 24. DISPATCH DETAILS TABLE - Bảng Chi Tiết Xuất Kho
CREATE TABLE DispatchDetails (
    DispatchDetailID INT PRIMARY KEY IDENTITY,
    DispatchID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitCost DECIMAL(18,2), -- Ghi nhận giá vốn của sản phẩm tại thời điểm xuất
    Reason NVARCHAR(255), -- Lý do chi tiết cho từng sản phẩm (ví dụ: 'Hết hạn sử dụng')
    FOREIGN KEY (DispatchID) REFERENCES DispatchReceipts(DispatchID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- ================================================================
-- NEW STORED PROCEDURE FOR DISPATCH
-- ================================================================

-- Procedure to update inventory after a dispatch/stock write-off
CREATE PROCEDURE sp_UpdateInventoryAfterDispatch
    @DispatchID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Biến để lưu loại phiếu xuất
    DECLARE @DispatchType NVARCHAR(50);
    SELECT @DispatchType = DispatchType FROM DispatchReceipts WHERE DispatchID = @DispatchID;

    -- Cập nhật số lượng tồn kho trong bảng Inventory
    UPDATE i SET
        CurrentStock = i.CurrentStock - dd.Quantity,
        LastStockUpdate = GETDATE()
    FROM Inventory i
    INNER JOIN DispatchDetails dd ON i.ProductID = dd.ProductID
    WHERE dd.DispatchID = @DispatchID;

    -- Thêm bản ghi vào StockMovements để theo dõi lịch sử
    INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, UnitCost, CreatedBy)
    SELECT
        dd.ProductID,
        'OUT',
        dd.Quantity,
        dr.DispatchType, -- Lý do chính là loại phiếu xuất
        @DispatchID,
        'DispatchReceipt', -- Loại tham chiếu là phiếu xuất kho
        dd.UnitCost,
        dr.CreatedBy
    FROM DispatchDetails dd
    JOIN DispatchReceipts dr ON dd.DispatchID = dr.DispatchID
    WHERE dd.DispatchID = @DispatchID;
END;
GO