# KHỞI TẠO VÀ CẤU TRÚC DỰ ÁN FLUTTER TRÊN ANDROID STUDIO

---

### PHẦN 1: QUY TRÌNH KHỞI TẠO DỰ ÁN MỚI

Để bắt đầu một dự án Flutter trong Android Studio, thực hiện theo các bước sau:

1.  **Khởi động Android Studio**: Tại màn hình chào mừng, chọn **New Flutter Project**.
2.  **Cấu hình Flutter SDK**:
    *   Chọn mục **Flutter** ở cột bên trái.
    *   Tại dòng **Flutter SDK path**, chỉ định đường dẫn đến thư mục chứa bộ cài đặt Flutter SDK.
    *   Nhấn **Next**.
3.  **Thiết lập thông tin dự án**:
    *   **Project name**: Tên ứng dụng (phải viết thường, không khoảng trắng, ngăn cách bằng dấu gạch dưới. Ví dụ: `my_first_app`).
    *   **Project location**: Đường dẫn lưu trữ thư mục dự án.
    *   **Description**: Mô tả ngắn gọn về ứng dụng.
    *   **Project type**: Chọn **Application**.
    *   **Organization**: Định danh tổ chức (thường dùng tên miền ngược, ví dụ: `com.example`). Đây là thành phần cấu tạo nên Package Name/Bundle ID cho ứng dụng.
    *   **Android/iOS Language**: Mặc định là Kotlin (Android) và Swift (iOS).
    *   **Platforms**: Tích chọn các nền tảng muốn hỗ trợ (Android, iOS, Web, Windows, macOS, Linux).
4.  **Hoàn tất**: Nhấn **Create** để hệ thống tự động sinh mã nguồn mẫu.

---

### PHẦN 2: CHI TIẾT CẤU TRÚC THƯ MỤC VÀ CÁC FILE QUAN TRỌNG

Một dự án Flutter tiêu chuẩn bao gồm các thành phần cốt lõi sau:

#### 1. Thư mục `lib/` (Thư mục quan trọng nhất)
Đây là nơi chứa toàn bộ mã nguồn Dart của ứng dụng. Hầu hết thời gian lập trình sẽ diễn ra tại đây.
*   **`main.dart`**: Điểm khởi đầu (Entry point) của ứng dụng. Khi ứng dụng chạy, hàm `main()` trong file này sẽ được gọi đầu tiên để kích hoạt các Widget.

#### 2. File `pubspec.yaml` (Cấu hình dự án)
Đây là file quản lý tài nguyên và các thư viện bổ trợ. Các thành phần chính bao gồm:
*   **Dependencies**: Khai báo các thư viện (package) từ bên ngoài (như gọi API, lưu trữ dữ liệu, icon...).
*   **Assets**: Khai báo đường dẫn cho hình ảnh, video, tệp âm thanh hoặc font chữ được sử dụng trong app.
*   **Version**: Quản lý phiên bản của ứng dụng (version name và build number).

#### 3. Thư mục `android/` và `ios/`
Chứa mã nguồn bản địa (native code) tương ứng cho hai hệ điều hành:
*   **`android/`**: Chứa các file cấu hình Gradle, quyền truy cập hệ thống (Manifest), và icon ứng dụng trên Android.
*   **`ios/`**: Chứa cấu hình Xcode, file Info.plist (quản lý quyền truy cập) và các cấu hình đặc thù của hệ sinh thái Apple.
*   *Lưu ý*: Chỉ can thiệp vào đây khi cần cấu hình sâu như: xin quyền Camera, GPS, hoặc thiết lập thông báo đẩy (Push Notification).

#### 4. Thư mục `test/`
Dùng để chứa các file mã nguồn phục vụ việc kiểm thử tự động (Unit test, Widget test). Giúp đảm bảo các chức năng của ứng dụng hoạt động chính xác trước khi phát hành.

#### 5. File `analysis_options.yaml`
Chứa các quy tắc (lint rules) để kiểm tra chất lượng code. Hệ thống sẽ dựa vào file này để đưa ra các cảnh báo nếu mã nguồn viết không đúng tiêu chuẩn hoặc tiềm ẩn lỗi.

#### 6. Các thư mục nền tảng khác (`web/`, `windows/`, `macos/`...)
Xuất hiện nếu dự án được cấu hình để chạy trên các nền tảng này. Mỗi thư mục chứa các file mồi (wrapper) để chạy ứng dụng Flutter trên trình duyệt hoặc máy tính để bàn.

#### 7. File `.gitignore`
Xác định các tệp tin và thư mục mà Git (hệ thống quản lý phiên bản) sẽ bỏ qua, không đưa lên kho lưu trữ (như các file tạm, file cấu hình cá nhân của IDE).

#### 8. Thư mục `.idea/` và `.dart_tool/`
*   **`.idea/`**: Chứa cấu hình riêng của Android Studio cho project.
*   **`.dart_tool/`**: Thư mục do Flutter tự động tạo ra để phục vụ quá trình biên dịch và quản lý gói.
*   *Lưu ý*: Không nên chỉnh sửa thủ công các thư mục này.

---

### PHẦN 3: CÁC THAO TÁC CƠ BẢN SAU KHI TẠO DỰ ÁN

*   **Lệnh `flutter pub get`**: Chạy lệnh này (hoặc nhấn nút tương ứng trong Android Studio) mỗi khi chỉnh sửa file `pubspec.yaml` để cập nhật các thư viện mới.
*   **Chọn thiết bị chạy (Device Selector)**: Chọn máy ảo (Emulator/Simulator) hoặc thiết bị thật ở thanh công cụ phía trên trước khi nhấn nút **Run** (mũi tên xanh).
*   **Hot Reload (Sấm sét vàng)**: Tính năng cho phép cập nhật thay đổi giao diện ngay lập tức mà không cần khởi động lại toàn bộ ứng dụng.