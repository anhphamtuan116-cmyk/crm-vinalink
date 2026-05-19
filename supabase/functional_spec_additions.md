# Tài Liệu Đặc Tả Chức Năng Bổ Sung (Functional Spec Additions) - Bản Cập Nhật
## Dự án: CRM Yến Sào Vĩnh Hưng

Tài liệu này được viết lại để đồng bộ chính xác với cơ sở dữ liệu thực tế tại `CRM-VNL-Demo/supabase`, bao gồm các cấu trúc bảng (`01_schema.sql`), hàm tự động (`03_functions.sql`), và các chính sách bảo mật cấp dòng (`04_rls.sql`).

---

## 1. Nhóm Tính Năng: Công Việc (Tasks)

Quản lý các tác vụ chăm sóc khách hàng hàng ngày của nhân viên, liên kết trực tiếp với dữ liệu Khách hàng (`leads`) hoặc Cơ hội (`opportunities`).

### 1.1 User Flow (Luồng Người Dùng)
1. **Khởi tạo công việc**:
   * **Từ trang chi tiết Lead/Opportunity**: Người dùng nhấn "Tạo công việc" ➔ Hệ thống tự động trích xuất và điền sẵn `lead_id` hoặc `opportunity_id` vào form.
   * **Từ trang Quản lý công việc chung**: Người dùng nhấn "Tạo công việc mới" ➔ Tìm kiếm và chọn Khách hàng/Cơ hội liên quan bằng ô tìm kiếm gợi ý (Autocomplete).
   * Điền Tiêu đề, Mô tả, đặt Hạn chót (Due date) và mức độ ưu tiên ➔ Nhấn "Lưu".
2. **Cập nhật công việc**:
   * Người dùng thay đổi trạng thái của công việc:
     * Tích chọn hoàn thành nhanh trên danh sách ➔ Đổi trạng thái sang `done`.
     * Hoặc kéo thả thẻ trên Kanban Board (`todo` ➔ `in_progress` ➔ `done`).
   * Click vào công việc để mở modal thay đổi Tiêu đề, Mô tả, Hạn chót, Mức độ ưu tiên.
3. **Xóa công việc**: Người dùng nhấn biểu tượng Thùng rác bên cạnh công việc để xóa khi không còn cần thiết.

### 1.2 UI Elements (Thành Phần Giao Diện)
* **Nút bấm**: "Thêm công việc" (Primary Button).
* **Modal Form**:
  * `Tiêu đề (title)`: Text Input (Bắt buộc).
  * `Mô tả (description)`: Textarea (Tùy chọn).
  * `Khách hàng (lead_id)`: Autocomplete Select từ bảng `leads` (Tùy chọn).
  * `Cơ hội (opportunity_id)`: Autocomplete Select từ bảng `opportunities` (Tùy chọn).
  * `Thời hạn (due_date)`: DateTime Picker (Tùy chọn).
  * `Mức độ ưu tiên (priority)`: Select Dropdown (Thấp - `low`, Trung bình - `medium`, Cao - `high`).
  * `Trạng thái (status)`: Select Dropdown (Cần làm - `todo`, Đang làm - `in_progress`, Hoàn thành - `done`, Quá hạn - `overdue`).
* **Bảng danh sách / Kanban Board**: Hiển thị danh sách thẻ công việc kèm theo thông tin khách hàng liên kết. Các công việc có trạng thái `overdue` sẽ được tô viền đỏ hoặc gắn nhãn cảnh báo nổi bật.

### 1.3 Validation (Kiểm Tra Dữ Liệu)
* **Tiêu đề (`title`)**: Bắt buộc nhập, tối đa 255 ký tự, không chứa khoảng trắng thừa.
* **Người phụ trách (`assigned_to`)**: Mặc định là UUID của tài khoản đang đăng nhập (`auth.uid()`).
* **Tính đồng nhất của Nhóm (`team_id`)**: Hệ thống tự động truy vấn và kế thừa `team_id` của Khách hàng (`leads`) hoặc Cơ hội (`opportunities`) được chọn để gán vào công việc, đảm bảo đồng bộ dữ liệu nhóm.

### 1.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Lỗi Quá Hạn**: Trạng thái quá hạn (`overdue`) được kiểm soát chủ động ở DB thông qua hàm `mark_overdue_tasks()` chạy tự động hàng ngày lúc 00:05. Nếu do lỗi hệ thống cron không chạy, front-end sẽ có cơ chế so sánh phụ: nếu `due_date < NOW()` và status không phải `done` thì hiển thị giao diện ở trạng thái Quá hạn và gửi lệnh cập nhật nhẹ về DB.
* **Lỗi phân quyền sửa đổi (RLS Violation)**: Nhân viên Sales chỉ được cập nhật trạng thái hoặc thông tin của công việc do chính mình phụ trách (`assigned_to = auth.uid()`). Nếu sửa công việc của người khác, Supabase sẽ trả về lỗi `403 Forbidden` ➔ Hiển thị Toast thông báo: *"Bạn không có quyền cập nhật công việc này."*

### 1.5 Supabase Queries (Truy Vấn Supabase)
* **Tạo công việc**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .insert([
      {
        title: 'Liên hệ tư vấn Yến Thô',
        description: 'Gọi điện báo giá sỉ cho khách lẻ có tiềm năng lên đại lý',
        lead_id: 'lead-uuid-1234',
        assigned_to: (await supabase.auth.getUser()).data.user.id,
        team_id: 'team-uuid-abcd', // Kế thừa từ lead_id
        priority: 'medium',
        due_date: '2026-05-25T15:30:00Z'
      }
    ]);
  ```
* **Đổi trạng thái hoàn thành**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .update({ 
      status: 'done',
      completed_at: new Date().toISOString()
    })
    .eq('id', 'task-uuid-5678');
  ```
* **Xóa công việc**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .delete()
    .eq('id', 'task-uuid-5678');
  ```

### 1.6 RLS (Chính Sách Bảo Mật) Liên Quan
* Theo file `04_rls.sql`:
  * **Xem (`SELECT`)**: Người dùng xem được công việc của mình (`assigned_to = auth.uid()`), hoặc nếu là Team Lead thì xem được công việc của nhóm (`team_id = ANY(get_my_team_ids())`), hoặc Admin xem toàn bộ.
  * **Thêm (`INSERT`)**: Sales chỉ được tạo task được gán cho chính mình (`assigned_to = auth.uid()`).
  * **Sửa (`UPDATE`)**: Sales chỉ được sửa task của chính mình (`assigned_to = auth.uid()`).
  * **Xóa (`DELETE`)**: Cho phép Admin, Team Lead của nhóm, hoặc chính Sales phụ trách xóa task đó (`tasks_delete_own` cho phép `assigned_to = auth.uid()`).

### 1.7 Tiêu Chỉ Nghiệm Thu (Acceptance Criteria)
* [ ] Task được hiển thị đúng màu sắc theo mức độ ưu tiên trên giao diện.
* [ ] Nhân viên Sales chỉ thao tác được trên các Task gán cho họ; nút sửa/xóa sẽ bị ẩn đối với Task của người khác.
* [ ] Hàm tự động `mark_overdue_tasks()` trong file `03_functions.sql` hoạt động chính xác khi quét các công việc trễ hạn chót chưa hoàn thành.

---

## 2. Nhóm Tính Năng: Danh Sách Khách Hàng (Lead Lists)

Quản lý phân nhóm khách hàng tĩnh (Static Segment Lists) bằng cách liên kết nhiều Lead vào một danh sách để phục vụ cho các chiến dịch marketing hoặc chăm sóc đặc biệt.

### 2.1 User Flow (Luồng Người Dùng)
1. **Tạo danh sách**: Người dùng vào trang quản trị danh sách ➔ Nhấn "Tạo danh sách" ➔ Nhập Tên và Mô tả danh sách ➔ Nhấn "Lưu".
2. **Lưu nhiều khách hàng vào danh sách**:
   * Người dùng vào bảng danh sách Leads chung.
   * Tích chọn nhiều khách hàng muốn thêm.
   * Nhấn nút "Thêm vào danh sách..." ở thanh công cụ hàng loạt ➔ Chọn danh sách đích ➔ Hệ thống ghi nhận mối quan hệ vào bảng nối `lead_list_members`.
3. **Quản lý & Tìm kiếm thành viên**:
   * Người dùng mở trang chi tiết của một danh sách cụ thể.
   * Nhập từ khóa tìm kiếm (Tên hoặc Số điện thoại) để lọc nhanh các thành viên trong danh sách.
4. **Xóa khách hàng khỏi danh sách**: Nhấn nút "Xóa khỏi nhóm" bên cạnh dòng thông tin khách hàng ➔ Xác nhận xóa liên kết mà không làm mất thông tin Lead gốc trong DB.

### 2.2 UI Elements (Thành Phần Giao Diện)
* **Trang danh sách nhóm**: Hiển thị các nhóm hiện tại dưới dạng lưới (Grid), mỗi thẻ hiển thị tên nhóm, mô tả, ngày tạo và tổng số lượng Lead đang có trong nhóm.
* **Thanh tác vụ hàng loạt (Bulk Action Bar)**: Xuất hiện ở phía trên bảng Leads khi có ít nhất một dòng được tích chọn checkbox, chứa nút "Thêm vào danh sách".
* **Modal chọn danh sách**: Dropdown tìm kiếm danh sách đích để thêm Lead vào.
* **Trang chi tiết danh sách**: Bảng hiển thị thông tin thành viên (Họ tên, Số điện thoại, Email, Phân khúc, Ngày thêm) kèm nút "Xóa khỏi danh sách" (`Remove`).

### 2.3 Validation (Kiểm Tra Dữ Liệu)
* **Tên danh sách (`name`)**: Bắt buộc nhập, độ dài tối đa 255 ký tự.
* **Quyền hạn của Sales khi tạo danh sách**: Nhân viên Sales chỉ được phép tạo danh sách cá nhân, trường `team_id` bắt buộc phải là `NULL`. Chỉ Admin và Team Lead mới được phép tạo danh sách liên kết với `team_id` của nhóm.
* **Ngăn chặn trùng lặp thành viên**: Ràng buộc khóa chính phức hợp `PRIMARY KEY (list_id, lead_id)` trong bảng `lead_list_members` đảm bảo một khách hàng không thể bị thêm trùng lặp vào cùng một danh sách.

### 2.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Lỗi thêm trùng lặp Lead**: Khi người dùng chọn thêm hàng loạt 10 Lead, nhưng có 2 Lead đã nằm sẵn trong danh sách ➔ Hệ thống sử dụng cú pháp `ON CONFLICT (list_id, lead_id) DO NOTHING` để bỏ qua 2 dòng đã có và lưu thành công 8 dòng còn lại mà không gây gián đoạn hay báo lỗi UI.
* **Lead bị xóa khỏi CRM**: Nhờ khóa ngoại `ON DELETE CASCADE` kết nối từ bảng `leads` đến `lead_list_members`, khi xóa một Lead gốc khỏi hệ thống, thông tin thành viên của Lead đó trong tất cả danh sách liên quan cũng tự động bị xóa sạch.

### 2.5 Supabase Queries (Truy Vấn Supabase)
* **Tạo danh sách**:
  ```javascript
  const { data, error } = await supabase
    .from('lead_lists')
    .insert([
      {
        name: 'Đại lý Yến Sào miền Nam',
        description: 'Danh sách đại lý cấp 1 và cấp 2 khu vực phía Nam',
        created_by: 'user-uuid',
        team_id: null // Hoặc team-uuid nếu là Team Lead/Admin tạo cho nhóm
      }
    ]);
  ```
* **Lưu nhiều khách hàng vào danh sách (Bulk Insert)**:
  ```javascript
  const leadsToAdd = [
    { list_id: 'list-uuid-1', lead_id: 'lead-uuid-A', added_by: 'user-uuid' },
    { list_id: 'list-uuid-1', lead_id: 'lead-uuid-B', added_by: 'user-uuid' }
  ];
  const { data, error } = await supabase
    .from('lead_list_members')
    .insert(leadsToAdd);
  ```
* **Xóa khách hàng khỏi danh sách**:
  ```javascript
  const { data, error } = await supabase
    .from('lead_list_members')
    .delete()
    .eq('list_id', 'list-uuid-1')
    .eq('lead_id', 'lead-uuid-A');
  ```
* **Tìm kiếm và lọc thành viên trong danh sách**:
  ```javascript
  const { data, error } = await supabase
    .from('lead_list_members')
    .select(`
      added_at,
      leads!inner ( id, full_name, phone_primary, segment )
    `)
    .eq('list_id', 'list-uuid-1')
    .or('full_name.ilike.%tuan%,phone_primary.ilike.%090%'); // Tìm kiếm theo tên hoặc số điện thoại
  ```

### 2.6 RLS (Chính Sách Bảo Mật) Liên Quan
* Theo file `04_rls.sql`:
  * **Xem danh sách**:
    * Sales chỉ xem được danh sách do mình tạo (`created_by = auth.uid()`).
    * Team Lead xem được danh sách của nhóm mình (`team_id = ANY(get_my_team_ids())`).
    * Admin xem được toàn bộ.
  * **Sửa / Thêm thành viên**: Chỉ người dùng có quyền xem danh sách đích tương ứng mới được phép thêm/xóa thành viên (`list_id IN (SELECT id FROM lead_lists WHERE created_by = auth.uid() OR team_id = ANY(get_my_team_ids()))`).

### 2.7 Tiêu Chỉ Nghiệm Thu (Acceptance Criteria)
* [ ] Tạo danh sách thành công và cập nhật tức thì số lượng Lead đếm được trong nhóm.
* [ ] Kiểm tra trùng lặp hoạt động tốt, không xuất hiện lỗi màn hình khi cố ý thêm Lead đã tồn tại.
* [ ] Tìm kiếm nhanh thành viên hoạt động chính xác theo từ khóa Tiếng Việt có dấu.

---

## 3. Nhóm Tính Năng: Import / Export CSV

Hỗ trợ quản trị viên và nhân viên nhập nhanh lượng lớn dữ liệu khách hàng từ file bảng tính Excel/CSV vào CRM, hoặc xuất ngược dữ liệu ra để phục vụ lưu trữ, báo cáo ngoại tuyến.

### 3.1 User Flow (Luồng Người Dùng)
1. **Import (Nhập dữ liệu)**:
   * **Tải lên**: Người dùng bấm "Nhập từ CSV" ➔ Kéo thả file `.csv` vào vùng chỉ định.
   * **Xem trước**: Hệ thống hiển thị bảng xem trước (Preview) tối đa 5 dòng dữ liệu đầu tiên đọc từ file.
   * **Ánh xạ cột (Mapping)**: Hệ thống cố gắng tự động khớp tiêu đề cột của file CSV với các trường dữ liệu trong DB. Người dùng tinh chỉnh lại qua các hộp chọn Dropdown (ví dụ: cột "Tên Khách Hàng" map vào trường `full_name`).
   * **Chọn đích đến**: Người dùng có thể chọn thêm nhanh toàn bộ Lead sắp import vào một "Danh sách khách hàng" cụ thể.
   * **Thực thi**: Nhấn "Tiến hành nhập" ➔ Hệ thống chạy import hàng loạt ➔ Hiển thị báo cáo kết quả (Thành công: X dòng, Thất bại: Y dòng, chi tiết dòng lỗi).
2. **Export (Xuất dữ liệu)**:
   * Người dùng lọc dữ liệu mong muốn trên bảng khách hàng (hoặc chọn một Danh sách khách hàng cụ thể).
   * Nhấn nút "Xuất file CSV" ➔ Hệ thống chuyển đổi dữ liệu hiển thị thành định dạng CSV và tải xuống trình duyệt của người dùng.

### 3.2 UI Elements (Thành Phần Giao Diện)
* **Khu vực kéo thả file**: Hộp thả file lớn (Dropzone) kèm hướng dẫn định dạng và file mẫu (Template download).
* **Giao diện Mapping Matrix**:
  * Cột bên trái: Các trường đích trong CRM (`Họ tên`, `Số điện thoại`, `Email`, `Địa chỉ`, `Phân khúc`, `Ghi chú`, `Sản phẩm quan tâm`).
  * Cột bên phải: Dropdown chứa danh sách tiêu đề cột trích xuất từ file CSV.
* **Bộ chọn danh sách**: Dropdown chứa danh sách `lead_lists` có sẵn của người dùng.
* **Báo cáo kết quả**: Bảng tóm tắt hiển thị số dòng lỗi kèm lý do (ví dụ: *"Dòng 15: Số điện thoại không hợp lệ"*).

### 3.3 Validation (Kiểm Tra Dữ Liệu)
* **Loại và kích thước file**: Chỉ nhận file có đuôi `.csv`, dung lượng nhỏ hơn 5MB để tránh quá tải trình duyệt.
* **Trường bắt buộc**: Trường `Họ tên (full_name)` trong CRM phải được map với một cột trong file CSV và giá trị không được trống ở bất kỳ dòng nào.
* **Định dạng Số điện thoại**: Tự động loại bỏ các ký tự lạ, chỉ giữ lại số và ký tự `+` ở đầu.
* **Chuẩn hóa giá trị Enum**:
  * `segment` (Phân khúc) tự động chuyển về chữ thường và khớp với các giá trị: `retail`, `agent`, `vip`. Nếu không khớp, tự động gán mặc định là `retail`.
  * `product_interests` (Sản phẩm quan tâm) là một mảng chuỗi (`product_interest[]`). Hệ thống cần tách chuỗi bằng dấu phẩy trong file CSV để chuyển thành dạng mảng DB (`raw_nest`, `stewed_nest`, `refined_nest`).

### 3.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Trùng lặp Số điện thoại**: Để tránh trùng lặp dữ liệu khách hàng, hệ thống sử dụng cơ chế `UPSERT` dựa trên trường `phone_primary`. Nếu số điện thoại đã tồn tại trong DB, hệ thống sẽ cập nhật đè thông tin mới từ file CSV lên bản ghi cũ.
* **Lỗi phân quyền khi Import (RLS Validation)**: 
  * Đối với nhân viên Sales, khi import dữ liệu, hệ thống bắt buộc phải gán `assigned_to` bằng UUID của chính nhân viên đó (`auth.uid()`).
  * Sales không được phép import khách hàng và gán cho người khác (được bảo vệ bởi điều kiện `WITH CHECK (assigned_to = auth.uid())` của RLS `leads_insert_sales`). Nếu cố tình sửa đổi `assigned_to` trong file CSV, Supabase sẽ chặn đứng giao dịch.

### 3.5 Supabase Queries (Truy Vấn Supabase)
* **Thực hiện Nhập hàng loạt (Bulk Upsert)**:
  ```javascript
  const leadsData = [
    { full_name: 'Trần Thị B', phone_primary: '0912345678', email: 'b@example.com', segment: 'vip', created_by: 'sales-uuid-1', assigned_to: 'sales-uuid-1' },
    { full_name: 'Đại lý Yến Vang', phone_primary: '0977777777', segment: 'agent', created_by: 'sales-uuid-1', assigned_to: 'sales-uuid-1' }
  ];
  
  // Thực hiện lưu hàng loạt vào DB
  const { data, error } = await supabase
    .from('leads')
    .upsert(leadsData, { onConflict: 'phone_primary' }) // Nếu trùng SĐT chính, tự động cập nhật thông tin
    .select('id');
  ```
* **Liên kết thành viên sau khi Import thành công**:
  ```javascript
  if (targetListId && data) {
    const listMembers = data.map(lead => ({
      list_id: targetListId,
      lead_id: lead.id,
      added_by: 'user-uuid'
    }));
    
    await supabase
      .from('lead_list_members')
      .insert(listMembers);
  }
  ```

### 3.6 RLS (Chính Sách Bảo Mật) Liên Quan
* **Ghi nhận dữ liệu**:
  * Khi import, các bản ghi của Sales tạo ra phải đảm bảo: `assigned_to = auth.uid()`. RLS `leads_insert_sales` và `leads_update_sales` sẽ từ chối nếu có bất kỳ dòng nào vi phạm điều kiện này.
  * Team Lead được phép import và phân bổ Lead cho các thành viên trực thuộc thông qua chính sách `leads_insert_team_lead` (cho phép chèn Lead có `team_id` thuộc quyền quản lý của Team Lead đó).

### 3.7 Tiêu Chỉ Nghiệm Thu (Acceptance Criteria)
* [ ] Nhập thành công danh sách khách hàng từ file CSV có dấu tiếng Việt, không bị vỡ font chữ (hỗ trợ đọc mã hóa UTF-8).
* [ ] Tự động cập nhật đè (Upsert) chính xác thông tin nếu trùng số điện thoại chính (`phone_primary`), không tạo ra bản ghi mới trùng lặp.
* [ ] Hệ thống chỉ ra chính xác số thứ tự dòng bị lỗi dữ liệu trong file CSV để người dùng dễ dàng chỉnh sửa lại.
* [ ] Xuất dữ liệu ra file CSV tải xuống chứa đầy đủ và đúng định dạng các cột thông tin khách hàng đang hiển thị.
