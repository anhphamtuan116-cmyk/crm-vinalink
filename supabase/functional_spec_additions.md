# Tài Liệu Đặc Tả Chức Năng Bổ Sung (Functional Spec Additions) - Bản Hoàn Chỉnh
## Dự án: CRM Yến Sào Vĩnh Hưng

Tài liệu này được tổng hợp và đối chiếu chéo dựa trên 3 tài liệu cốt lõi của dự án: **PRD**, **Design Brief**, và cấu trúc cơ sở dữ liệu **Supabase Design** hiện tại.

---

## 1. Nhóm Tính Năng: Công Việc (Tasks)

Mục tiêu giúp nhân viên Sales quản lý các điểm chạm với khách hàng, đảm bảo "thấy rõ việc phải làm" trong ngày/tuần.

### 1.1 User Flow (Luồng Người Dùng)
1. **Khởi tạo công việc**:
   * **Từ trang chi tiết Khách hàng/Cơ hội**: Người dùng nhấn nút "Thêm công việc" ➔ Form tự động điền sẵn `lead_id` hoặc `opportunity_id`. Người dùng nhập Tiêu đề, Mô tả, Hạn chót và Mức độ ưu tiên. Nhấn "Lưu".
   * **Từ trang Công việc chung**: Nhấn "Tạo công việc mới" ➔ Tự tìm kiếm và chọn khách hàng liên quan qua trường Autocomplete.
2. **Cập nhật & Chuyển trạng thái**:
   * Người dùng có thể kéo-thả (Drag & Drop) thẻ công việc trên bảng Board view từ cột `Todo` sang `In Progress` hoặc `Done`.
   * Hoặc bấm vào checkbox nhanh trên List view để chuyển `done`.
3. **Xóa công việc**: Nhấn icon thùng rác bên trong panel chi tiết công việc để xóa bỏ.

### 1.2 UI Elements (Thành Phần Giao Diện)
*Tuân thủ phong cách Glassmorphism, tone màu Vàng kem (`#F9F5EE`) - Nâu ấm (`#C89A3D`)*.
* **Layout 2 chế độ hiển thị**:
  * **List view**: Bảng 1 cột lớn, mỗi dòng hiển thị: Tiêu đề, Tên khách hàng, Badge Priority, Deadline.
  * **Board view (Kanban đơn giản)**: Các cột `Cần làm`, `Đang làm`, `Hoàn thành`. Thẻ (Card) bo góc 12px, nền trắng kính mờ `rgba(255,255,255,0.9)`, shadow cực nhẹ.
* **Badge (Nhãn ưu tiên)**:
  * **Cao (High)**: Nền cam đất rất nhạt `rgba(217,108,63,0.1)`, chữ `#D96C3F`.
  * **Trung bình (Medium)**: Nền nâu xám nhạt, chữ `#8B8375`.
  * **Thấp (Low)**: Đường viền nhạt, chữ nhạt `#C1B5A4`.
* **Right Panel Detail**: Bấm vào dòng/thẻ task, một panel dạng slide-in trượt ra từ bên phải hiển thị chi tiết (nền kính mờ).

### 1.3 Validation & Rules (Quy Tắc Xử Lý)
* **Bắt buộc**: `title` không được trống.
* **Overdue (Quá hạn)**: Trạng thái `overdue` được cập nhật ngầm thông qua hàm tự động `mark_overdue_tasks()` chạy lúc 00:05 mỗi ngày trên Supabase (những task có `due_date < NOW()` và khác `done`). Trên UI, các task này hiển thị viền đỏ và dồn lên đầu danh sách.

### 1.4 Supabase RLS \& Queries
* **RLS Policies (`04_rls.sql`)**: 
  * `tasks_select`: Sales thấy task của mình; Team Lead thấy task của nhóm; Admin thấy tất cả.
  * `tasks_insert_sales` / `tasks_update_sales`: Sales chỉ được gán (`assigned_to = auth.uid()`) và sửa task do mình phụ trách. Không thể tạo task gán cho người khác.
  * `tasks_delete_own`: Sales được phép xóa task của mình.
* **Query Cập nhật Trạng thái**:
  ```javascript
  // Khi Sales kéo thẻ Kanban sang Done
  await supabase.from('tasks')
    .update({ status: 'done', completed_at: new Date().toISOString() })
    .eq('id', taskId)
    .eq('assigned_to', currentUser.id); // RLS tự động check lớp bảo mật này
  ```

---

## 2. Nhóm Tính Năng: Danh Sách Khách Hàng (Lead Lists)

Giúp phân nhóm khách tĩnh (Static Segment Lists) phục vụ chiến dịch chăm sóc (VD: "Đại lý chiến lược miền Nam", "Khách lẻ VIP quà biếu").

### 2.1 User Flow (Luồng Người Dùng)
1. **Tạo danh sách**: 
   * Tại trang Danh sách khách hàng ➔ Nhấn "Tạo danh sách mới".
   * Form kính mờ mở lên ➔ Nhập Tên danh sách, Mô tả.
2. **Thêm hàng loạt (Bulk Add)**:
   * Sales lọc danh sách khách ở bảng Leads chung ➔ Tích chọn các ô checkbox ở đầu dòng.
   * Thanh công cụ (Bulk Action Bar) nổi lên ➔ Nhấn "Thêm vào danh sách..." ➔ Chọn danh sách đích.
3. **Quản lý danh sách**:
   * Truy cập chi tiết danh sách, dùng ô tìm kiếm (Search Bar) góc phải để tìm tên/SĐT thành viên.
   * Cột thao tác có icon "Xóa" (Remove) để rút Lead khỏi danh sách.

### 2.2 UI Elements (Thành Phần Giao Diện)
* **Trang Tổng hợp Danh sách**: Hiển thị lưới các thẻ (Cards) kính mờ, viền 1px `rgba(215, 195, 160, 0.4)`. Mỗi thẻ hiện tên danh sách, mô tả và số lượng thành viên (Metric số lớn).
* **Bảng danh sách thành viên**:
  * Các hàng (Rows) có hover đổi nền rất nhẹ, thiết kế thoáng.
  * Hiển thị Badge Phân Khúc chuẩn: VIP (Nền nhạt ánh vàng `#C89A3D`), Đại lý (Nâu xám), Khách lẻ (Trắng đục).
* **Nút bấm (Buttons)**: Nút "Thêm vào danh sách" sử dụng nút Secondary (Nền trong suốt, viền `#C89A3D`), khi hover nền hiện `rgba(200,154,61,0.08)`.

### 2.3 Validation & Rules (Quy Tắc Xử Lý)
* **Quyền tạo danh sách**: Sales chỉ tạo được danh sách cá nhân (`team_id IS NULL`).
* **Tránh trùng lặp thành viên (Duplicate Handling)**: DB có Primary Key `(list_id, lead_id)` trong `lead_list_members`. Khi thêm hàng loạt, code sử dụng phương thức `upsert` hoặc `ON CONFLICT DO NOTHING` để âm thầm bỏ qua những Lead đã có trong nhóm.

### 2.4 Supabase RLS \& Queries
* **RLS Policies**:
  * `lead_lists_insert_sales`: Bắt buộc `created_by = auth.uid()` và `team_id IS NULL`.
  * `lead_list_members_insert` / `delete`: Hệ thống check xem list_id đó có thuộc về người dùng (hoặc nhóm của họ) hay không trước khi cho phép thay đổi thành viên.
* **Query Tìm kiếm thành viên**:
  ```javascript
  // Tìm kiếm trong chi tiết danh sách bằng Join
  await supabase.from('lead_list_members')
    .select('added_at, leads!inner(id, full_name, phone_primary, segment)')
    .eq('list_id', listId)
    .ilike('leads.full_name', `%${searchTerm}%`);
  ```

---

## 3. Nhóm Tính Năng: Import / Export CSV

Tính năng chủ lực để đưa dữ liệu cũ vào hệ thống và kết xuất báo cáo nhanh.

### 3.1 User Flow (Luồng Người Dùng)
1. **Import CSV**:
   * Nhấn "Upload CSV" (Nút Secondary trên Header trang Khách hàng) ➔ Kéo thả file.
   * **Bảng Xem Trước (Mapping Matrix)** hiện lên: So khớp cột CSV (bên phải) vào các trường chuẩn của DB CRM (bên trái).
   * **Xử lý xung đột**: Người dùng chọn 1 trong 2 cơ chế (Ghi đè - Upsert hoặc Bỏ qua - Skip) nếu hệ thống phát hiện trùng `phone_primary`.
   * **Chọn danh sách đích**: Chọn thả các lead sắp import thẳng vào một `lead_list` cụ thể (ví dụ: "Đại lý mới 90 ngày").
   * Nhấn "Tiến hành nhập" ➔ Thanh Progress Bar chạy ➔ Hiển thị kết quả.
2. **Export CSV**:
   * Người dùng áp dụng các Filter có sẵn trên màn hình danh sách Khách hàng.
   * Bấm "Xuất CSV" ➔ File tải xuống mang đúng các dữ liệu đang hiển thị trên bảng.

### 3.2 UI Elements (Thành Phần Giao Diện)
* **Khu vực kéo thả (Dropzone)**: Hình chữ nhật bo góc 16px, viền đứt nét (dashed border) màu `#E3D7C8`, nền kính mờ. Có nút tải file mẫu (Template).
* **Mapping Matrix**: Các dòng tương ứng với các cột DB (`Họ tên`, `Số điện thoại`, `Phân khúc`...), có select dropdown thiết kế viền `1px #E3D7C8`, bo góc 10px để chọn cột tương ứng từ file CSV. Focus viền đổi màu `#C89A3D` và glow nhẹ.

### 3.3 Validation & Rules (Quy Tắc Xử Lý)
* **Chuẩn hóa Số điện thoại**: Xóa toàn bộ khoảng trắng, dấu chấm, dấu gạch ngang trước khi so sánh trùng.
* **Chuẩn hóa Phân khúc & Sản phẩm quan tâm**: 
  * Cột `segment`: Map chuỗi từ CSV về Enum `retail`, `agent`, `vip`. Nếu trống, mặc định là `retail`.
  * Cột `product_interests`: Chuyển đổi dữ liệu chuỗi cách nhau bởi dấu phẩy thành mảng `text[]` (ví dụ: `['raw_nest', 'stewed_nest']`).
* **Identity Protection**: Sales thao tác import thì hệ thống tự động gắn chặt biến `assigned_to = auth.uid()` trước khi chèn vào DB, ngăn chặn Sales import hàng ngàn khách và phân bổ trái phép cho Sales khác.

### 3.4 Supabase RLS \& Queries
* **RLS Cốt lõi**: `leads_insert_sales` có điều kiện `WITH CHECK (get_my_role() = 'sales' AND assigned_to = auth.uid())`. Điều này ép buộc Logic Import phải set cứng `assigned_to` cho từng dòng dữ liệu bằng UUID của người dùng hiện tại, nếu không DB sẽ throw lỗi toàn bộ lô lệnh.
* **Query Bulk Upsert an toàn**:
  ```javascript
  const leadsToImport = parsedData.map(row => ({
    full_name: row.name,
    phone_primary: sanitizePhone(row.phone),
    segment: mapSegment(row.segment),
    assigned_to: currentUser.id, // Bắt buộc cho Sales
    created_by: currentUser.id,
    team_id: currentUser.team_id // Lấy từ get_my_team_ids() để kế thừa
  }));
  
  const { data, error } = await supabase.from('leads')
    .upsert(leadsToImport, { onConflict: 'phone_primary' }) // Nếu trùng SĐT thì ghi đè bản ghi đó
    .select('id');
  ```
