# XÂY DỰNG ỨNG DỤNG DI ĐỘNG "TECH-EVENTS HUB"

**Yêu cầu:**
Công ty công nghệ **Global Tech Solutions** thường xuyên tổ chức các buổi hội thảo, lớp học chuyên đề (Workshops) và các buổi Tech-talk cho cộng đồng lập trình viên. Hiện tại, việc quản lý và đăng ký tham gia đang thực hiện thủ công qua Google Forms, dẫn đến khó khăn trong việc quản lý dữ liệu tập trung.

Bộ phận CNTT của công ty yêu cầu bạn xây dựng một ứng dụng di động có tên **"Tech-Events Hub"** (sử dụng Flutter cho Mobile và Strapi cho CMS) để chuyên nghiệp hóa quy trình này.

---

## I. YÊU CẦU KỸ THUẬT CHI TIẾT

### 1. Phía Backend (Strapi CMS)
*   Thiết kế Content-type `Category` (Danh mục: Web, AI, Mobile, Cloud...).
*   Thiết kế Content-type `Event` (Thông tin sự kiện: Tên, Mô tả, Hình ảnh, Ngày giờ, Danh mục).
*   Thiết kế Content-type `Registration` (Lưu thông tin người đăng ký).
*   Cấu hình API Permissions để Flutter có thể truy cập và gửi dữ liệu.

### 2. Phía Mobile App (Flutter)
*   **Màn hình chào (Splash Screen):** Hiển thị logo của Global Tech Solutions khi mở ứng dụng.
*   **Điều hướng (Navigation Bar):** Sử dụng thanh điều hướng phía dưới để chuyển đổi giữa các màn hình chính.
*   **Trang danh sách sự kiện:**
    *   Lấy dữ liệu thực tế từ Strapi.
    *   Có tính năng **Pagination (Phân trang)**: Khi người dùng cuộn (scroll) xuống dưới cùng, ứng dụng tự động tải thêm dữ liệu sự kiện mới (Infinite Scroll).
*   **Bộ lọc (Category Filter):** Cho phép người dùng chọn danh mục để lọc các sự kiện tương ứng.
*   **Form Đăng ký tham gia:**
    *   Xây dựng form nhập liệu: Họ tên, Email, Số điện thoại.
    *   **Validate Form:** Kiểm tra định dạng email, số điện thoại không được để trống và đúng quy tắc trước khi gửi.
    *   **Lưu dữ liệu:** Sau khi validate thành công, dữ liệu phải được gửi và lưu trữ trực tiếp vào Content-type `Registration` trên Strapi thông qua API.

---

## II. THANG ĐIỂM CHI TIẾT (TỔNG 10 ĐIỂM)

| STT | Hạng mục đánh giá | Yêu cầu chi tiết | Điểm tối đa |
|:---:|:--- |:--- |:---:|
| **1** | **Flash Screen (Splash)** | Hiển thị Logo công ty đẹp, căn giữa, có hiệu ứng chuyển cảnh mượt mà vào trang chính. | **1.0đ** |
| **2** | **Navigation Bar** | Sử dụng BottomNavigationBar để điều hướng giữa các trang, hoạt động ổn định và đúng UI. | **1.0đ** |
| **3** | **Danh sách sự kiện & Phân trang** | Hiển thị danh sách từ API Strapi. Thực hiện thành công cơ chế load dữ liệu thêm khi scroll xuống cuối trang (Infinite Scroll). | **3.0đ** |
| **4** | **Bộ lọc danh mục (Filter)** | Hiển thị danh sách Category từ Strapi. Khi chọn vào category, danh sách sự kiện được cập nhật đúng theo chủ đề đã chọn. | **1.5đ** |
| **5** | **Form Đăng ký & Validation** | Thiết kế giao diện Form hợp lý. Thực hiện kiểm tra dữ liệu (Validation) các trường: Email, SĐT, Họ tên. | **1.5đ** |
| **6** | **Tích hợp Backend (Post data)** | Dữ liệu sau khi validate được gửi qua phương thức POST và lưu thành công vào cơ sở dữ liệu của Strapi. | **2.0đ** |
| | **TỔNG ĐIỂM** | | **10.0đ** |

---
**Yêu cầu nộp bài:**
1. Mã nguồn Flutter (GitHub Link).
2. Tệp cấu hình hoặc Folder của dự án Strapi.
3. Một video ngắn (1-2 phút) quay màn hình thao tác: Mở app -> Xem danh sách -> Scroll phân trang -> Lọc theo danh mục -> Đăng ký thử và kiểm tra dữ liệu trên Admin Strapi.