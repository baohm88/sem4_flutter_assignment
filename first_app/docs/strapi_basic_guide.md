### 1. Content-Type Builder: "Xây dựng khung"
**Dùng để làm gì:** Dùng để định nghĩa cấu trúc dữ liệu (Database Schema). Bạn quyết định xem một "Sự kiện" sẽ gồm những thông tin gì.

*   **Ví dụ thực tế:** Bạn muốn tạo thực thể **Event (Sự kiện)**. 
    *   Bạn vào Content-Type Builder và thêm các "Trường" (Fields):
        *   `title`: Kiểu **Text** (Để nhập tên sự kiện như "Hội thảo Flutter 2024").
        *   `content`: Kiểu **Rich Text** (Để viết mô tả chi tiết, in đậm, in nghiêng).
        *   `cover_image`: Kiểu **Media** (Để đăng ảnh banner cho sự kiện).
        *   `category`: Kiểu **Relation** (Bạn nối nó với bảng Category để biết sự kiện này thuộc nhóm "Mobile" hay "AI").
*   **Kết quả:** Sau khi nhấn Save, Strapi tự động tạo ra một bảng trong cơ sở dữ liệu và các API tương ứng cho bạn.

---

### 2. Content Manager: "Nhập liệu nội dung"
**Dùng để làm gì:** Sau khi đã có khung ở bước 1, đây là nơi bạn nhập dữ liệu thật để App Flutter có thể hiển thị.

*   **Ví dụ thực tế:** Bạn vừa tổ chức xong một buổi "Workshop về Strapi".
    *   Bạn vào Content Manager -> Chọn mục **Event**.
    *   Nhấn **Create New Entry**.
    *   Bạn nhập: Tiêu đề = "Học Strapi trong 1 giờ", chọn ngày = "25/12/2024", tải ảnh lên.
    *   **Quan trọng:** Bạn nhấn **Save** (Lưu nháp) rồi phải nhấn **Publish** (Xuất bản).
*   **Kết quả:** Dữ liệu này hiện đã sẵn sàng để API trả về cho App. Nếu bạn chỉ Save mà không Publish, App sẽ không thấy sự kiện này (tránh việc lộ thông tin chưa hoàn thiện).

---

### 3. Media Library: "Kho lưu trữ hình ảnh & tài liệu"
**Dùng để làm gì:** Quản lý tập trung tất cả file đa phương tiện.

*   **Ví dụ thực tế:** Bạn có một tấm ảnh logo công ty "Global Tech Solutions" định dạng `.png`.
    *   Bạn tải ảnh này lên Media Library.
    *   Strapi sẽ cung cấp cho bạn một đường dẫn (URL) và tự động tạo ra các phiên bản ảnh nhỏ hơn (Thumbnail, Small, Medium) để tối ưu tốc độ tải trên điện thoại.
*   **Kết quả:** Khi dùng Flutter, bạn có thể lấy link ảnh này để hiển thị trong `Image.network()`.

---

### 4. Settings - Roles (Public API):
**Dùng để làm gì:** Cấp quyền cho phép những ai (hoặc ứng dụng nào) được phép xem/sửa dữ liệu.

*   **Ví dụ thực tế:** Mặc định Strapi sẽ khóa mọi thứ. Bạn muốn App Flutter của sinh viên có thể xem danh sách sự kiện mà không cần đăng nhập.
    *   Vào **Settings** -> **Roles** -> **Public**.
    *   Tìm mục **Event**, tích vào ô `find`. 
    *   Tìm mục **Registration**, tích vào ô `create` (để sinh viên có thể gửi form đăng ký từ App lên).
*   **Kết quả:** Bây giờ, bất kỳ ai truy cập vào đường link `http://localhost:1337/api/events` cũng có thể thấy dữ liệu JSON. Nếu không tích chọn, họ sẽ nhận được lỗi `403 Forbidden`.

---

### 5. API Tokens:
**Dùng để làm gì:** Tạo ra một mã định danh (Token) để App Flutter "chào hỏi" Strapi một cách bảo mật hơn là mở công khai (Public).

*   **Ví dụ thực tế:** Bạn không muốn mở Public API (vì sợ bị phá), bạn tạo một Token tên là "Flutter_App_Key".
    *   Bạn chọn loại Token là `Full Access`.
    *   Strapi cấp cho bạn một chuỗi ký tự dài kiểu: `df823hdsfd823...`
    *   Trong code Flutter, khi gọi API, bạn thêm mã này vào phần Header.
*   **Kết quả:** Strapi nhận ra "đây là App của công ty mình" nên sẽ cho phép truy cập dữ liệu, còn những người truy cập vãng lai từ trình duyệt sẽ bị chặn lại.

---

### Tóm tắt kịch bản:
1.  Dùng **Content-Type Builder** để thiết kế bảng "Người đăng ký" (Registration) gồm: Tên, Email, SĐT.
2.  Dùng **Settings** để cấp quyền `create` cho bảng Registration đó.
3.  Viết code **Flutter** để gửi dữ liệu từ Form vào API của bảng này.
4.  Vào **Content Manager** để kiểm tra xem dữ liệu sinh viên vừa nhập từ điện thoại đã "nhảy" vào trong danh sách của Strapi chưa.
