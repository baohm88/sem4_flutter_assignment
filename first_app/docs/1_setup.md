**1. Tải Android Studio cho Windows:**

*   Truy cập trang chủ Android Studio: [https://developer.android.com/studio](https://developer.android.com/studio)
*   Bạn sẽ thấy nút "Download Android Studio". Click vào đó.
*   Đọc và chấp nhận các điều khoản và điều kiện.
*   Click vào nút tải về tương ứng với hệ điều hành Windows của bạn.

**2. Bắt đầu cài đặt:**

*   Sau khi tải về, bạn sẽ có một file `.exe` (ví dụ: `android-studio-2023.2.1.23-windows.exe`).
*   Double-click vào file `.exe` để bắt đầu quá trình cài đặt.

**3. Cài đặt:**

*   **Welcome screen:** Click "Next" để tiếp tục.
*   **Choose Components:**
    *   **Android Studio:** Đã được chọn sẵn, giữ nguyên.
    *   **Android Virtual Device:**  **Rất quan trọng để chọn nếu bạn muốn chạy ứng dụng trên emulator.**  Chọn nó.
    *   Click "Next".
*   **Installation Settings:**
    *   Chọn thư mục cài đặt Android Studio.  Bạn có thể giữ thư mục mặc định hoặc chọn một thư mục khác.  **Lưu ý:** Tránh các thư mục có chứa khoảng trắng hoặc ký tự đặc biệt.
    *   Click "Next".
*   **Choose Start Menu Folder:**
    *   Chọn một thư mục trong Start Menu để tạo shortcut cho Android Studio.  Bạn có thể giữ mặc định hoặc tạo một thư mục mới.
    *   Click "Install".
*   **Installing:**
    *   Quá trình cài đặt sẽ bắt đầu.  Đợi cho đến khi hoàn tất.
*   **Completing the Android Studio Setup:**
    *   Khi cài đặt hoàn tất, click "Next".
    *   Nếu bạn muốn khởi động Android Studio ngay lập tức, hãy tích vào ô "Start Android Studio".
    *   Click "Finish".

**4. Thiết lập Android Studio lần đầu tiên:**

*   Khi Android Studio khởi động lần đầu tiên, bạn sẽ thấy một cửa sổ "Import Android Studio settings".
    *   **"Do not import settings" (khuyến nghị nếu bạn mới cài đặt Android Studio).**
    *   Click "OK".
*   **Data Sharing:**
    *   Chọn liệu bạn có muốn chia sẻ dữ liệu sử dụng với Google hay không.
    *   Click "Don't send" hoặc "Send usage statistics to Google" tùy theo sở thích của bạn.
*   **Setup Wizard:**
    *   Bạn sẽ được chào đón bởi một Setup Wizard. Click "Next".
    *   **Install Type:** Chọn "Standard" (khuyến nghị cho người mới bắt đầu).
    *   Click "Next".
*   **Select UI Theme:** Chọn theme bạn muốn (ví dụ: "Darcula" cho dark mode hoặc "Light"). Click "Next".
*   **Verify Settings:**
    *   Android Studio sẽ hiển thị một danh sách các thành phần sẽ được tải về và cài đặt.
    *   Bạn có thể thấy:
        *   Android SDK
        *   Android SDK Platform
        *   Android Virtual Device (AVD)
    *   Click "Next".
*   **License Agreement:**
    *   Bạn sẽ thấy các license agreements cho Android SDK và các thành phần khác.
    *   Chọn từng license, tích vào ô "Accept", rồi click "Next".
*   **Downloading Components:**
    *   Android Studio sẽ bắt đầu tải về và cài đặt các thành phần cần thiết.  Quá trình này có thể mất một thời gian tùy thuộc vào tốc độ internet của bạn.
    *   Đợi cho đến khi hoàn tất.
*   **Finish:**
    *   Khi tất cả các thành phần đã được tải về và cài đặt, click "Finish".

**5. Cấu hình Android SDK:**

*   **Xác định vị trí Android SDK:**
    *   Trong Android Studio, click "More Actions" (hoặc "Configure") -> "SDK Manager".
    *   Trong cửa sổ "Settings/Preferences", bạn sẽ thấy "Android SDK Location" ở trên cùng.  Ghi nhớ đường dẫn này (ví dụ: `C:\Users\YourUsername\AppData\Local\Android\Sdk`).
*   **Đặt biến môi trường ANDROID_HOME (nếu cần):**
    *   Một số công cụ (ví dụ: Flutter) có thể yêu cầu biến môi trường `ANDROID_HOME` để trỏ đến vị trí Android SDK.  Mặc dù thường thì Android Studio sẽ tự động cấu hình, nhưng bạn nên kiểm tra lại:
        1.  Tìm kiếm "Edit the system environment variables" trong Windows Search.
        2.  Click vào "Environment Variables...".
        3.  Trong phần "System variables", click "New...".
        4.  Đặt "Variable name" là `ANDROID_HOME`.
        5.  Đặt "Variable value" là đường dẫn đến Android SDK (ví dụ: `C:\Users\YourUsername\AppData\Local\Android\Sdk`).
        6.  Click "OK" để lưu các thay đổi.
        7.  Chọn "Path" trong phần "System variables", click "Edit...", click "New", và thêm `%ANDROID_HOME%\platform-tools` và `%ANDROID_HOME%\tools` vào danh sách.
        8.  Click "OK" để lưu các thay đổi.
* **Khởi động lại máy tính:** Sau khi thay đổi các biến môi trường, hãy khởi động lại máy tính để các thay đổi có hiệu lực.

**6. Tạo và chạy Android Emulator:**

*   **Mở AVD Manager:**
    *   Trong Android Studio, click "More Actions" (hoặc "Configure") -> "AVD Manager".
*   **Create Virtual Device:**
    *   Click "Create Virtual Device...".
    *   Chọn một hardware profile (ví dụ: Pixel 5). Click "Next".
    *   Chọn một system image (Android version). **Nếu bạn chưa tải về system image, hãy click "Download" và đợi cho đến khi hoàn tất.** Khuyến nghị chọn phiên bản Android mới nhất. Click "Next".
    *   Đặt tên cho AVD (Android Virtual Device). Bạn có thể giữ mặc định hoặc chọn một tên khác.
    *   Click "Finish".
*   **Run the Emulator:**
    *   Trong AVD Manager, bạn sẽ thấy danh sách các AVD đã tạo.
    *   Click vào biểu tượng tam giác màu xanh (Run) bên cạnh AVD bạn muốn chạy.
    *   Android Emulator sẽ khởi động. Quá trình này có thể mất một vài phút.

**7. Kiểm tra với Flutter (sau khi đã cài đặt Flutter SDK như hướng dẫn trước):**

*   Mở terminal hoặc command prompt.
*   Chạy lệnh sau:
    ```bash
    flutter doctor
    ```
    *   Kiểm tra xem `flutter doctor` có phát hiện Android Studio và Android SDK của bạn hay không.  Nếu có bất kỳ lỗi nào, hãy làm theo hướng dẫn để khắc phục.
*   Tạo một project Flutter mới (nếu bạn chưa có):
    ```bash
    flutter create my_app
    cd my_app
    ```
*   Chạy ứng dụng Flutter trên Android Emulator:
    ```bash
    flutter run
    ```
    *   Chọn thiết bị Android Emulator của bạn từ danh sách.
    *   Ứng dụng Flutter của bạn sẽ được cài đặt và chạy trên emulator.

**Khắc phục sự cố thường gặp:**

*   **Emulator không khởi động:**
    *   Đảm bảo rằng virtualization đã được bật trong BIOS/UEFI của bạn.  Thông thường, bạn có thể truy cập BIOS/UEFI bằng cách nhấn Delete, F2, F12 hoặc một phím tương tự khi máy tính khởi động. Tìm tùy chọn liên quan đến "Virtualization Technology" (VT-x hoặc AMD-V) và bật nó.
    *   Đảm bảo rằng bạn đã cài đặt và cập nhật Android Emulator và Android SDK Platform Tools mới nhất thông qua SDK Manager trong Android Studio.
    *   Thử tạo một AVD mới với cấu hình khác.
*   **HAXM installation failed:**
    *   HAXM (Hardware Accelerated Execution Manager) là một trình ảo hóa phần cứng giúp tăng tốc emulator.  Nếu cài đặt HAXM thất bại, hãy đảm bảo rằng virtualization đã được bật trong BIOS/UEFI của bạn.
    *   Có thể có xung đột với các phần mềm ảo hóa khác (ví dụ: Hyper-V).  Bạn có thể cần phải tắt Hyper-V.
*   **Flutter không tìm thấy Android SDK:**
    *   Kiểm tra biến môi trường `ANDROID_HOME` đã được cấu hình đúng chưa.
    *   Thử chạy `flutter config --android-sdk /path/to/android/sdk` để cấu hình Flutter trỏ đến Android SDK.
