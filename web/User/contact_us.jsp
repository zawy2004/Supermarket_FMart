<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="${pageDescription != null ? pageDescription : 'Contact FMart Super Market - We are here to help you with your questions, feedback, and support needs.'}">
    <meta name="author" content="FMart Team">		
    <title>${pageTitle != null ? pageTitle : 'FMart - Contact Us'}</title>

    <!-- Favicon Icon -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/User/images/fav.png">

    <!-- Stylesheets -->
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/night-mode.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/step-wizard.css" rel="stylesheet">

    <!-- Vendor Stylesheets -->
    <link href="${pageContext.request.contextPath}/User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
</head>

<body>
    <!-- Include header with cart sidebar -->
    <jsp:include page="header.jsp"></jsp:include>
    
    <!-- Body Start -->
    <div class="wrapper">
        <!-- Breadcrumb -->
        <div class="gambo-Breadcrumb">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Contact Us</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty contactSuccess or param.success eq 'true'}">
            <div class="container">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${not empty contactSuccess}">
                            ${contactSuccess}
                        </c:when>
                        <c:otherwise>
                            Your message has been submitted successfully! We will get back to you within 24-48 hours.
                        </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="container">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </div>
        </c:if>
        
        <!-- Contact Section -->
        <div class="all-product-grid">
            <div class="container">
                <div class="row">
                    <!-- Header Section -->
                    <div class="col-lg-12 col-md-12 mb-4">
                        <div class="contact-title text-center">
                            <h2>Get in Touch with FMart</h2>
                            <p class="lead">We're here to help! Whether you have questions about our products, need support with your order, or want to share feedback, our customer service team is ready to assist you.</p>
                            
                            <c:if test="${user != null}">
                                <div class="mt-3">
                                    
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Quick Contact Cards -->
                    <div class="col-lg-12 mb-4">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="card h-100 text-center border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="text-primary mb-3">
                                            <i class="fas fa-headset fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Customer Support</h5>
                                        <p class="card-text">Get help with orders, products, and account issues</p>
                                        <small class="text-muted">Response time: 2-4 hours</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card h-100 text-center border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="text-success mb-3">
                                            <i class="fas fa-comments fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Feedback & Suggestions</h5>
                                        <p class="card-text">Share your thoughts to help us improve our service</p>
                                        <small class="text-muted">We value your input!</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card h-100 text-center border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="text-warning mb-3">
                                            <i class="fas fa-exclamation-triangle fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Report an Issue</h5>
                                        <p class="card-text">Report problems with products or service quality</p>
                                        <small class="text-muted">Urgent issues prioritized</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Contact Form -->
                    <div class="col-lg-6 col-md-12">
                        <div class="contact-form">
                            <h4 class="mb-4">Send us a Message</h4>
                            <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm">
                                <input type="hidden" name="action" value="submit">
                                
                                <!-- Message Type Selection -->
                                <div class="form-group mb-4">
                                    <label class="control-label">Message Type*</label>
                                    <select class="form-select" name="messagetype" id="messagetype" required>
                                        <option value="">Select message type...</option>
                                        <option value="INQUIRY" ${formData != null && formData.messageType eq 'INQUIRY' ? 'selected' : ''}>General Inquiry</option>
                                        <option value="SUPPORT" ${formData != null && formData.messageType eq 'SUPPORT' ? 'selected' : ''}>Technical Support</option>
                                        <option value="COMPLAINT" ${formData != null && formData.messageType eq 'COMPLAINT' ? 'selected' : ''}>Complaint</option>
                                        <option value="FEEDBACK" ${formData != null && formData.messageType eq 'FEEDBACK' ? 'selected' : ''}>Feedback & Suggestions</option>
                                    </select>
                                </div>
                                
                                <!-- Full Name -->
                                <div class="form-group mb-4">
                                    <label class="control-label">Full Name*</label>
                                    <div class="ui search focus">
                                        <div class="ui left icon input swdh11 swdh19">
                                            <input class="prompt srch_explore form-control" 
                                                   type="text" 
                                                   name="sendername" 
                                                   id="sendername" 
                                                   required 
                                                   placeholder="Enter your full name"
                                                   value="${userFullName != null ? userFullName : (formData != null ? formData.senderName : '')}"
                                                   maxlength="100">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Email Address -->
                                <div class="form-group mb-4">
                                    <label class="control-label">Email Address*</label>
                                    <div class="ui search focus">
                                        <div class="ui left icon input swdh11 swdh19">
                                            <input class="prompt srch_explore form-control" 
                                                   type="email" 
                                                   name="emailaddress" 
                                                   id="emailaddress" 
                                                   required 
                                                   placeholder="Enter your email address"
                                                   value="${userEmail != null ? userEmail : (formData != null ? formData.senderEmail : '')}">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Phone Number (Optional) -->
                                <div class="form-group mb-4">
                                    <label class="control-label">Phone Number</label>
                                    <div class="ui search focus">
                                        <div class="ui left icon input swdh11 swdh19">
                                            <input class="prompt srch_explore form-control" 
                                                   type="tel" 
                                                   name="phone" 
                                                   id="phone" 
                                                   placeholder="Enter your phone number (optional)"
                                                   value="${userPhone != null ? userPhone : (formData != null ? formData.senderPhone : '')}"
                                                   maxlength="15">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Subject -->
                                <div class="form-group mb-4">
                                    <label class="control-label">Subject*</label>
                                    <div class="ui search focus">
                                        <div class="ui left icon input swdh11 swdh19">
                                            <input class="prompt srch_explore form-control" 
                                                   type="text" 
                                                   name="sendersubject" 
                                                   id="sendersubject" 
                                                   required 
                                                   placeholder="Enter subject (5-200 characters)"
                                                   value="${formData != null ? formData.subject : ''}"
                                                   maxlength="200">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Message -->
                                <div class="form-group mb-4">	
                                    <div class="field">
                                        <label class="control-label">Message*</label>
                                        <textarea rows="5" 
                                                  class="form-control" 
                                                  id="sendermessage" 
                                                  name="sendermessage" 
                                                  required 
                                                  placeholder="Please describe your inquiry, issue, or feedback in detail (10-2000 characters)"
                                                  maxlength="2000">${formData != null ? formData.message : ''}</textarea>
                                        <small class="form-text text-muted">
                                            <span id="charCount">0</span>/2000 characters
                                        </small>
                                    </div>
                                </div>
                                
                                <!-- Submit Button -->
                                <button class="btn btn-primary btn-lg hover-btn" type="submit" id="submitBtn">
                                    <i class="fas fa-paper-plane me-2"></i>
                                    <span id="submitText">Submit Request</span>
                                    <span id="submitLoader" style="display: none;">
                                        <i class="fas fa-spinner fa-spin me-2"></i>Submitting...
                                    </span>
                                </button>
                            </form>
                        </div>
                    </div>
                    
                                            <!-- Contact Information & Store Locations -->
                    <div class="col-lg-6 col-md-12">
                        <div class="contact-info mb-4">
                            <h4 class="mb-4">Contact Information</h4>
                            <div class="contact-item mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="contact-icon me-3">
                                        <i class="fas fa-phone-alt fa-lg text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Customer Service Hotline</h6>
                                        <p class="mb-0">1800-000-000 (Toll Free)</p>
                                        <small class="text-muted">Thứ 2 - Chủ Nhật: 8:00 - 22:00</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="contact-item mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="contact-icon me-3">
                                        <i class="fas fa-envelope fa-lg text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Email Support</h6>
                                        <p class="mb-0">support@fmart.vn</p>
                                        <small class="text-muted">Phản hồi trong vòng 24 giờ</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="contact-item mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="contact-icon me-3">
                                        <i class="fas fa-comments fa-lg text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Live Chat</h6>
                                        <p class="mb-0">Có sẵn trên website</p>
                                        <small class="text-muted">Thứ 2 - Thứ 6: 9:00 - 18:00</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Store Locations -->
                        <div class="store-locations">
                            <h4 class="mb-4">Hệ Thống Cửa Hàng</h4>
                            <div class="panel-group accordion" id="accordion0">
                                <!-- Ho Chi Minh City -->
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingHCM">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseHCM" href="#" aria-expanded="false" aria-controls="collapseHCM">
                                                <i class="fas fa-building text-primary me-2"></i>Trụ Sở Chính - TP. Hồ Chí Minh
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseHCM" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingHCM" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <strong>FMart Trụ Sở Chính:</strong><br>
                                            123 Đường Nguyễn Huệ, Quận 1<br>
                                            TP. Hồ Chí Minh, Việt Nam<br>
                                            <div class="text-primary mt-2">
                                                <i class="fas fa-phone me-1"></i>Tel: 028-3829-1234<br>
                                                <i class="fas fa-envelope me-1"></i>Email: hcm@fmart.vn<br>
                                                <i class="fas fa-clock me-1"></i>Giờ mở: 7:00 - 22:00 hằng ngày
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Hanoi Branch -->
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingHanoi">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseHanoi" href="#" aria-expanded="false" aria-controls="collapseHanoi">
                                                <i class="fas fa-store text-primary me-2"></i>Chi Nhánh Hà Nội
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseHanoi" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingHanoi" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <strong>FMart Hà Nội:</strong><br>
                                            456 Đường Ba Triệu, Quận Hai Bà Trưng<br>
                                            Hà Nội, Việt Nam<br>
                                            <div class="text-primary mt-2">
                                                <i class="fas fa-phone me-1"></i>Tel: 024-3974-5678<br>
                                                <i class="fas fa-envelope me-1"></i>Email: hanoi@fmart.vn<br>
                                                <i class="fas fa-clock me-1"></i>Giờ mở: 7:00 - 22:00 hằng ngày
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Da Nang Branch -->
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingDanang">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseDanang" href="#" aria-expanded="false" aria-controls="collapseDanang">
                                                <i class="fas fa-store text-primary me-2"></i>Chi Nhánh Đà Nẵng
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseDanang" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingDanang" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <strong>FMart Đà Nẵng:</strong><br>
                                            789 Đường Lê Duẩn, Quận Hải Châu<br>
                                            Đà Nẵng, Việt Nam<br>
                                            <div class="text-primary mt-2">
                                                <i class="fas fa-phone me-1"></i>Tel: 0236-3881-999<br>
                                                <i class="fas fa-envelope me-1"></i>Email: danang@fmart.vn<br>
                                                <i class="fas fa-clock me-1"></i>Giờ mở: 7:00 - 22:00 hằng ngày
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Nha Trang Branch -->
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingNhaTrang">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseNhaTrang" href="#" aria-expanded="false" aria-controls="collapseNhaTrang">
                                                <i class="fas fa-store text-primary me-2"></i>Chi Nhánh Nha Trang
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseNhaTrang" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingNhaTrang" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <strong>FMart Nha Trang:</strong><br>
                                            234 Đường Trần Phú, TP. Nha Trang<br>
                                            Khánh Hòa, Việt Nam<br>
                                            <div class="text-primary mt-2">
                                                <i class="fas fa-phone me-1"></i>Tel: 0258-3527-777<br>
                                                <i class="fas fa-envelope me-1"></i>Email: nhatrang@fmart.vn<br>
                                                <i class="fas fa-clock me-1"></i>Giờ mở: 7:00 - 22:00 hằng ngày
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Can Tho Branch -->
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingCanTho">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseCanTho" href="#" aria-expanded="false" aria-controls="collapseCanTho">
                                                <i class="fas fa-store text-primary me-2"></i>Chi Nhánh Cần Thơ
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseCanTho" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingCanTho" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <strong>FMart Cần Thơ:</strong><br>
                                            567 Đường 3 Tháng 2, Quận Ninh Kiều<br>
                                            Cần Thơ, Việt Nam<br>
                                            <div class="text-primary mt-2">
                                                <i class="fas fa-phone me-1"></i>Tel: 0292-3765-888<br>
                                                <i class="fas fa-envelope me-1"></i>Email: cantho@fmart.vn<br>
                                                <i class="fas fa-clock me-1"></i>Giờ mở: 7:00 - 22:00 hằng ngày
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- FAQ Section -->
                <div class="row mt-5">
                    <div class="col-lg-12">
                        <div class="faq-section">
                            <h4 class="mb-4 text-center">Frequently Asked Questions</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="faq-item mb-3">
                                        <h6><i class="fas fa-question-circle text-primary me-2"></i>How can I track my order?</h6>
                                        <p class="text-muted small">You can track your order by logging into your account and going to "My Orders" section.</p>
                                    </div>
                                    <div class="faq-item mb-3">
                                        <h6><i class="fas fa-question-circle text-primary me-2"></i>What is your return policy?</h6>
                                        <p class="text-muted small">We offer 7-day return policy for most items. Please check our return policy page for details.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="faq-item mb-3">
                                        <h6><i class="fas fa-question-circle text-primary me-2"></i>Do you offer home delivery?</h6>
                                        <p class="text-muted small">Yes, we provide free home delivery for orders above $50 within city limits.</p>
                                    </div>
                                    <div class="faq-item mb-3">
                                        <h6><i class="fas fa-question-circle text-primary me-2"></i>How can I change my order?</h6>
                                        <p class="text-muted small">Orders can be modified within 1 hour of placement. Contact our support team immediately.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>	
    </div>
    <!-- Body End -->
    
    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/User/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/OwlCarousel/owl.carousel.js"></script>
    <script src="${pageContext.request.contextPath}/User/js/custom.js"></script>
    
    <script>
        $(document).ready(function() {
            // Character counter for message
            $('#sendermessage').on('input', function() {
                const maxLength = 2000;
                const currentLength = $(this).val().length;
                $('#charCount').text(currentLength);
                
                if (currentLength > maxLength * 0.9) {
                    $('#charCount').addClass('text-warning');
                } else {
                    $('#charCount').removeClass('text-warning');
                }
                
                if (currentLength >= maxLength) {
                    $('#charCount').addClass('text-danger').removeClass('text-warning');
                } else {
                    $('#charCount').removeClass('text-danger');
                }
            });
            
            // Form validation and submission
            $('#contactForm').on('submit', function(e) {
                e.preventDefault();
                
                if (!validateForm()) {
                    return false;
                }
                
                // Show loading state
                showLoadingState();
                
                // Submit form
                this.submit();
            });
            
            // Real-time validation
            $('#sendername').on('blur', function() {
                validateName();
            });
            
            $('#emailaddress').on('blur', function() {
                validateEmail();
            });
            
            $('#phone').on('blur', function() {
                validatePhone();
            });
            
            $('#sendersubject').on('blur', function() {
                validateSubject();
            });
            
            $('#sendermessage').on('blur', function() {
                validateMessage();
            });
            
            // Initialize character counter
            $('#sendermessage').trigger('input');
        });
        
        function validateForm() {
            let isValid = true;
            
            isValid = validateName() && isValid;
            isValid = validateEmail() && isValid;
            isValid = validateSubject() && isValid;
            isValid = validateMessage() && isValid;
            isValid = validateMessageType() && isValid;
            
            return isValid;
        }
        
        function validateName() {
            const name = $('#sendername').val().trim();
            const $field = $('#sendername');
            
            if (name.length < 2) {
                showFieldError($field, 'Full name must be at least 2 characters long');
                return false;
            }
            
            if (name.length > 100) {
                showFieldError($field, 'Full name cannot exceed 100 characters');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function validateEmail() {
            const email = $('#emailaddress').val().trim();
            const $field = $('#emailaddress');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailRegex.test(email)) {
                showFieldError($field, 'Please enter a valid email address');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function validateSubject() {
            const subject = $('#sendersubject').val().trim();
            const $field = $('#sendersubject');
            
            if (subject.length < 5) {
                showFieldError($field, 'Subject must be at least 5 characters long');
                return false;
            }
            
            if (subject.length > 200) {
                showFieldError($field, 'Subject cannot exceed 200 characters');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function validateMessage() {
            const message = $('#sendermessage').val().trim();
            const $field = $('#sendermessage');
            
            if (message.length < 10) {
                showFieldError($field, 'Message must be at least 10 characters long');
                return false;
            }
            
            if (message.length > 2000) {
                showFieldError($field, 'Message cannot exceed 2000 characters');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function validateMessageType() {
            const messageType = $('#messagetype').val();
            const $field = $('#messagetype');
            
            if (!messageType) {
                showFieldError($field, 'Vui lòng chọn loại tin nhắn');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function validateForm() {
            let isValid = true;
            
            isValid = validateName() && isValid;
            isValid = validateEmail() && isValid;
            isValid = validatePhone() && isValid; // Add phone validation
            isValid = validateSubject() && isValid;
            isValid = validateMessage() && isValid;
            isValid = validateMessageType() && isValid;
            
            return isValid;
        }
        
        // Enhanced phone validation for Vietnam numbers
        function validatePhone() {
            const phone = $('#phone').val().trim();
            const $field = $('#phone');
            
            if (phone === '') {
                clearFieldError($field);
                return true; // Phone is optional
            }
            
            // Vietnam phone number pattern: 10 digits starting with 0
            const phonePattern = /^0[0-9]{9}$/;
            
            if (!phonePattern.test(phone)) {
                showFieldError($field, 'Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0');
                return false;
            }
            
            clearFieldError($field);
            return true;
        }
        
        function showFieldError($field, message) {
            clearFieldError($field);
            $field.addClass('is-invalid');
            $field.after('<div class="invalid-feedback">' + message + '</div>');
        }
        
        function clearFieldError($field) {
            $field.removeClass('is-invalid');
            $field.siblings('.invalid-feedback').remove();
        }
        
        function showLoadingState() {
            const $btn = $('#submitBtn');
            const $text = $('#submitText');
            const $loader = $('#submitLoader');
            
            $btn.prop('disabled', true);
            $text.hide();
            $loader.show();
        }
        
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>