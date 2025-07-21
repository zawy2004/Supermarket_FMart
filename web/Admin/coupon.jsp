<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FMart Admin - ${isEdit ? 'Chỉnh sửa' : 'Tạo'} mã giảm giá</title>
    
    <!-- CSS Files -->
    <link href="${pageContext.request.contextPath}/Admin/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Admin/css/admin-style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        .form-group {
            margin-bottom: 1.5rem;
        }
        .coupon-preview {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .coupon-code {
            font-size: 1.5rem;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .validation-feedback {
            display: block;
        }
        .is-invalid {
            border-color: #dc3545;
        }
        .is-valid {
            border-color: #28a745;
        }
        .code-suggestion {
            cursor: pointer;
            color: #007bff;
            text-decoration: underline;
        }
        .discount-preview {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="${pageContext.request.contextPath}/Admin/index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
        <a href="${pageContext.request.contextPath}/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/edit_profile.jsp">Edit Profile</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/change_password.jsp">Change Password</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/login.jsp">Logout</a>
                </div>
            </li>
        </ul>
    </nav>

    <div id="layoutSidenav">
        <!-- Sidebar -->
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link" href="${pageContext.request.contextPath}/Admin/index.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>
                        <!-- Other navigation items -->
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/coupon">
                            <div class="sb-nav-link-icon"><i class="fas fa-gift"></i></div>
                            Quản lý Coupon
                        </a>
                    </div>
                </div>
            </nav>
        </div>

        <!-- Main Content -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">
                        <i class="fas fa-gift"></i>
                        ${isEdit ? 'Chỉnh sửa' : 'Tạo'} mã giảm giá
                    </h2>
                    
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/Admin/index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/coupon?action=list">Quản lý Coupon</a></li>
                        <li class="breadcrumb-item active">${isEdit ? 'Chỉnh sửa' : 'Tạo'} mã giảm giá</li>
                    </ol>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <!-- Form Column -->
                        <div class="col-lg-8">
                            <div class="card card-static-2 mb-30">
                                <div class="card-header">
                                    <h5><i class="fas fa-edit"></i> Thông tin mã giảm giá</h5>
                                </div>
                                <div class="card-body">
                                    <form id="couponForm" action="${pageContext.request.contextPath}/admin/coupon" method="post" novalidate>
                                        <input type="hidden" name="action" value="create">
                                        <c:if test="${isEdit}">
                                            <input type="hidden" name="couponId" value="${coupon.couponId}">
                                        </c:if>

                                        <!-- Basic Information -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="couponCode">Mã giảm giá <span class="text-danger">*</span></label>
                                                    <input type="text" 
                                                           id="couponCode" 
                                                           name="couponCode" 
                                                           class="form-control" 
                                                           value="${coupon.couponCode != null ? coupon.couponCode : suggestedCode}"
                                                           placeholder="VD: SUMMER2025"
                                                           pattern="[A-Z0-9]{3,20}"
                                                           title="Chỉ chứa chữ cái in hoa và số, 3-20 ký tự"
                                                           required>
                                                    <div class="invalid-feedback" id="couponCodeFeedback"></div>
                                                    <small class="form-text text-muted">
                                                        Chỉ chứa chữ cái và số, 3-20 ký tự. 
                                                        <span class="code-suggestion" onclick="generateCouponCode()">Tạo mã tự động</span>
                                                    </small>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="couponName">Tên mã giảm giá <span class="text-danger">*</span></label>
                                                    <input type="text" 
                                                           id="couponName" 
                                                           name="couponName" 
                                                           class="form-control" 
                                                           value="${coupon.couponName}"
                                                           placeholder="VD: Giảm giá mùa hè"
                                                           required>
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="description">Mô tả</label>
                                            <textarea id="description" 
                                                      name="description" 
                                                      class="form-control" 
                                                      rows="3"
                                                      placeholder="Mô tả chi tiết về mã giảm giá...">${coupon.description}</textarea>
                                        </div>

                                        <!-- Discount Settings -->
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="discountType">Loại giảm giá <span class="text-danger">*</span></label>
                                                    <select id="discountType" name="discountType" class="form-control" required onchange="updateDiscountPreview()">
                                                        <option value="Percentage" ${coupon.discountType == 'Percentage' ? 'selected' : ''}>Phần trăm (%)</option>
                                                        <option value="Fixed" ${coupon.discountType == 'Fixed' ? 'selected' : ''}>Số tiền cố định (VND)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="discountValue">Giá trị giảm <span class="text-danger">*</span></label>
                                                    <input type="number" 
                                                           id="discountValue" 
                                                           name="discountValue" 
                                                           class="form-control" 
                                                           value="${coupon.discountValue}"
                                                           min="0.01" 
                                                           step="0.01"
                                                           placeholder="0"
                                                           required
                                                           onchange="updateDiscountPreview()">
                                                    <div class="invalid-feedback"></div>
                                                    <small class="form-text text-muted" id="discountValueHelp">
                                                        Nhập % cho giảm theo phần trăm, VND cho giảm cố định
                                                    </small>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="maxDiscountAmount">Giảm tối đa (VND)</label>
                                                    <input type="number" 
                                                           id="maxDiscountAmount" 
                                                           name="maxDiscountAmount" 
                                                           class="form-control" 
                                                           value="${coupon.maxDiscountAmount}"
                                                           min="0" 
                                                           step="1000"
                                                           placeholder="0">
                                                    <small class="form-text text-muted">Để trống = không giới hạn</small>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Order Requirements -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="minOrderAmount">Đơn hàng tối thiểu (VND)</label>
                                                    <input type="number" 
                                                           id="minOrderAmount" 
                                                           name="minOrderAmount" 
                                                           class="form-control" 
                                                           value="${coupon.minOrderAmount}"
                                                           min="0" 
                                                           step="1000"
                                                           placeholder="0"
                                                           onchange="updateDiscountPreview()">
                                                    <small class="form-text text-muted">Giá trị đơn hàng tối thiểu để áp dụng</small>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="discount-preview" id="discountPreview">
                                                    <strong>Ví dụ áp dụng:</strong>
                                                    <div id="previewContent">Nhập thông tin để xem ví dụ</div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Usage Limits -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="usageLimit">Giới hạn sử dụng tổng <span class="text-danger">*</span></label>
                                                    <input type="number" 
                                                           id="usageLimit" 
                                                           name="usageLimit" 
                                                           class="form-control" 
                                                           value="${coupon.usageLimit != null ? coupon.usageLimit : 100}"
                                                           min="1" 
                                                           max="100000"
                                                           required>
                                                    <small class="form-text text-muted">Tổng số lần có thể sử dụng</small>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="orderLimit">Giới hạn mỗi khách hàng</label>
                                                    <input type="number" 
                                                           id="orderLimit" 
                                                           name="orderLimit" 
                                                           class="form-control" 
                                                           value="${coupon.orderLimit}"
                                                           min="0" 
                                                           placeholder="0">
                                                    <small class="form-text text-muted">Để 0 = không giới hạn</small>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Date Range -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="startDate">Ngày bắt đầu <span class="text-danger">*</span></label>
                                                    <input type="datetime-local" 
                                                           id="startDate" 
                                                           name="startDate" 
                                                           class="form-control" 
                                                           value="<fmt:formatDate value='${coupon.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                                                           required>
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="endDate">Ngày kết thúc <span class="text-danger">*</span></label>
                                                    <input type="datetime-local" 
                                                           id="endDate" 
                                                           name="endDate" 
                                                           class="form-control" 
                                                           value="<fmt:formatDate value='${coupon.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                                                           required>
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="form-group mt-4">
                                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                                <i class="fas fa-save"></i> ${isEdit ? 'Cập nhật' : 'Tạo mã giảm giá'}
                                            </button>
                                            <a href="${pageContext.request.contextPath}/admin/coupon?action=list" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left"></i> Quay lại
                                            </a>
                                            <button type="button" class="btn btn-info" onclick="previewCoupon()">
                                                <i class="fas fa-eye"></i> Xem trước
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Preview Column -->
                        <div class="col-lg-4">
                            <div class="card card-static-2 mb-30">
                                <div class="card-header">
                                    <h5><i class="fas fa-eye"></i> Xem trước Coupon</h5>
                                </div>
                                <div class="card-body">
                                    <div class="coupon-preview" id="couponPreviewCard">
                                        <div class="text-center">
                                            <div class="coupon-code" id="previewCode">COUPON2025</div>
                                            <div class="mt-2" id="previewName">Tên coupon</div>
                                            <div class="mt-2" id="previewDiscount">Giảm 0%</div>
                                            <div class="mt-2">
                                                <small id="previewCondition">Đơn hàng tối thiểu: 0 VND</small>
                                            </div>
                                            <div class="mt-2">
                                                <small id="previewValidity">Hiệu lực: --/-- đến --/--</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-3">
                                        <h6>Tips tạo coupon hiệu quả:</h6>
                                        <ul class="small">
                                            <li>Mã coupon ngắn gọn, dễ nhớ</li>
                                            <li>Thời gian có hạn tạo tính khan hiếm</li>
                                            <li>Đặt điều kiện đơn hàng phù hợp</li>
                                            <li>Giới hạn số lượng để tạo sự cấp bách</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            <footer class="py-4 bg-footer mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted-1">© 2024 <b>FMart Supermarket</b></div>
                        <div class="footer-links">
                            <a href="${pageContext.request.contextPath}/privacy_policy.jsp">Privacy Policy</a>
                            <a href="${pageContext.request.contextPath}/term_and_conditions.jsp">Terms & Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <!-- JavaScript Files -->
    <script src="${pageContext.request.contextPath}/Admin/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/Admin/js/scripts.js"></script>

    <script>
        $(document).ready(function() {
            // Set default dates if creating new coupon
            if (!$('#startDate').val()) {
                const now = new Date();
                const startDate = new Date(now.getTime() + 24 * 60 * 60 * 1000); // Tomorrow
                const endDate = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000); // 30 days later
                
                $('#startDate').val(formatDateTimeLocal(startDate));
                $('#endDate').val(formatDateTimeLocal(endDate));
            }

            // Initialize preview
            updateCouponPreview();
            updateDiscountPreview();

            // Real-time validation
            $('#couponCode').on('input', function() {
                validateCouponCode();
                updateCouponPreview();
            });

            $('#couponName, #discountType, #discountValue, #minOrderAmount, #startDate, #endDate').on('input change', function() {
                updateCouponPreview();
            });

            // Form validation
            $('#couponForm').on('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }
            });
        });

        function formatDateTimeLocal(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return `${year}-${month}-${day}T${hours}:${minutes}`;
        }

        function generateCouponCode() {
            const prefixes = ['SAVE', 'DEAL', 'SALE', 'OFF', 'GET', 'BUY'];
            const prefix = prefixes[Math.floor(Math.random() * prefixes.length)];
            const number = Math.floor(Math.random() * 9000) + 1000;
            const newCode = prefix + number;
            
            $('#couponCode').val(newCode);
            validateCouponCode();
            updateCouponPreview();
        }

        function validateCouponCode() {
            const code = $('#couponCode').val();
            const pattern = /^[A-Z0-9]{3,20}$/;
            
            if (!code) {
                setFieldInvalid('couponCode', 'Mã coupon không được để trống');
                return false;
            }
            
            if (!pattern.test(code)) {
                setFieldInvalid('couponCode', 'Mã coupon chỉ chứa chữ cái in hoa và số, 3-20 ký tự');
                return false;
            }

            // Check availability via AJAX
            $.post('${pageContext.request.contextPath}/admin/coupon', {
                action: 'check_code',
                couponCode: code
            }, function(response) {
                const data = JSON.parse(response);
                if (data.available) {
                    setFieldValid('couponCode', 'Mã coupon có thể sử dụng');
                } else {
                    setFieldInvalid('couponCode', data.message);
                }
            });

            return true;
        }

        function validateForm() {
            let isValid = true;
            
            // Validate required fields
            const requiredFields = ['couponCode', 'couponName', 'discountValue', 'usageLimit', 'startDate', 'endDate'];
            
            requiredFields.forEach(function(field) {
                const value = $('#' + field).val();
                if (!value || value.trim() === '') {
                    setFieldInvalid(field, 'Trường này không được để trống');
                    isValid = false;
                } else {
                    setFieldValid(field, '');
                }
            });

            // Validate discount value
            const discountType = $('#discountType').val();
            const discountValue = parseFloat($('#discountValue').val());
            
            if (discountType === 'Percentage' && discountValue > 100) {
                setFieldInvalid('discountValue', 'Phần trăm giảm giá không được vượt quá 100%');
                isValid = false;
            }

            // Validate date range
            const startDate = new Date($('#startDate').val());
            const endDate = new Date($('#endDate').val());
            
            if (startDate >= endDate) {
                setFieldInvalid('endDate', 'Ngày kết thúc phải sau ngày bắt đầu');
                isValid = false;
            }

            return isValid;
        }

        function setFieldValid(fieldId, message) {
            const field = $('#' + fieldId);
            field.removeClass('is-invalid').addClass('is-valid');
            field.siblings('.invalid-feedback').text('');
            if (message) {
                field.siblings('.valid-feedback').text(message);
            }
        }

        function setFieldInvalid(fieldId, message) {
            const field = $('#' + fieldId);
            field.removeClass('is-valid').addClass('is-invalid');
            field.siblings('.invalid-feedback').text(message);
        }

        function updateCouponPreview() {
            const code = $('#couponCode').val() || 'COUPON2025';
            const name = $('#couponName').val() || 'Tên coupon';
            const discountType = $('#discountType').val();
            const discountValue = $('#discountValue').val() || 0;
            const minOrderAmount = $('#minOrderAmount').val() || 0;
            const startDate = $('#startDate').val();
            const endDate = $('#endDate').val();

            $('#previewCode').text(code);
            $('#previewName').text(name);
            
            let discountText = '';
            if (discountType === 'Percentage') {
                discountText = `Giảm ${discountValue}%`;
            } else {
                discountText = `Giảm ${parseInt(discountValue).toLocaleString()} VND`;
            }
            $('#previewDiscount').text(discountText);
            
            $('#previewCondition').text(`Đơn hàng tối thiểu: ${parseInt(minOrderAmount).toLocaleString()} VND`);
            
            if (startDate && endDate) {
                const start = new Date(startDate).toLocaleDateString('vi-VN');
                const end = new Date(endDate).toLocaleDateString('vi-VN');
                $('#previewValidity').text(`Hiệu lực: ${start} đến ${end}`);
            }
        }

        function updateDiscountPreview() {
            const discountType = $('#discountType').val();
            const discountValue = parseFloat($('#discountValue').val()) || 0;
            const minOrderAmount = parseFloat($('#minOrderAmount').val()) || 0;
            
            let exampleOrder = Math.max(minOrderAmount, 500000); // 500k example
            let discount = 0;
            
            if (discountType === 'Percentage') {
                discount = exampleOrder * (discountValue / 100);
                $('#discountValueHelp').text('Nhập phần trăm giảm giá (VD: 10 = 10%)');
            } else {
                discount = discountValue;
                $('#discountValueHelp').text('Nhập số tiền giảm cố định (VND)');
            }
            
            const maxDiscount = parseFloat($('#maxDiscountAmount').val()) || 0;
            if (maxDiscount > 0 && discount > maxDiscount) {
                discount = maxDiscount;
            }
            
            const finalAmount = exampleOrder - discount;
            
            $('#previewContent').html(`
                <div>Đơn hàng: ${exampleOrder.toLocaleString()} VND</div>
                <div>Giảm: ${discount.toLocaleString()} VND</div>
                <div><strong>Thanh toán: ${finalAmount.toLocaleString()} VND</strong></div>
            `);
        }

        function previewCoupon() {
            $('#couponPreviewCard').addClass('shadow-lg');
            setTimeout(function() {
                $('#couponPreviewCard').removeClass('shadow-lg');
            }, 2000);
        }
    </script>
</body>
</html>