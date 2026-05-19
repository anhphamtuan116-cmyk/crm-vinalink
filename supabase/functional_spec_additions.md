# Tài Liệu Đặc Tả Chức Năng Bổ Sung (Functional Spec Additions)
## Dự án: CRM Yến Sào Vĩnh Hưng

Tài liệu này đặc tả chi tiết 3 nhóm tính năng bổ sung dựa trên PRD, Design Brief, và Schema Supabase hiện có.

---

## 1. Nhóm Tính Năng: Công Việc (Tasks)

Nhóm tính năng này quản lý các tác vụ hàng ngày của nhân viên bán hàng (gọi điện, gửi báo giá, chăm sóc lại...) gắn liền với khách hàng hoặc cơ hội bán hàng.

### 1.1 User Flow (Luồng Người Dùng)
1. **Tạo công việc**:
   * **Từ màn hình chi tiết Khách hàng/Cơ hội**: Người dùng nhấn "Tạo công việc" ➔ Hệ thống tự động điền thông tin Khách hàng/Cơ hội vào form ➔ Người dùng điền Tiêu đề, Mô tả, Hạn chót, Mức độ ưu tiên ➔ Nhấn "Lưu".
   * **Từ màn hình Quản lý Công việc chung**: Người dùng nhấn "Tạo công việc mới" ➔ Điền form và chọn thủ công Khách hàng liên quan từ danh sách gợi ý (autocomplete) ➔ Nhấn "Lưu".
2. **Xem danh sách và bộ lọc**: Người dùng xem danh sách công việc dạng bảng hoặc Kanban (phân chia theo trạng thái: Cần làm, Đang làm, Hoàn thành, Quá hạn).
3. **Cập nhật công việc (Sửa / Đổi trạng thái)**:
   * Click vào công việc để mở modal chỉnh sửa thông tin.
   * Hoặc kéo thả thẻ công việc trên bảng Kanban để đổi trạng thái.
   * Hoặc tích chọn vào checkbox nhanh để đổi trạng thái sang "Hoàn thành" (`done`).

### 1.2 UI Elements (Thành Phần Giao Diện)
* **Nút bấm**: "Tạo công việc" (Primary Button).
* **Modal Form**:
  * `Tiêu đề` (Text Input - Bắt buộc).
  * `Mô tả` (Textarea - Tùy chọn).
  * `Khách hàng liên quan` (Autocomplete Search Select - Liên kết với bảng `leads`).
  * `Thời hạn chót (Due date)` (DateTime Picker - Tùy chọn).
  * `Mức độ ưu tiên` (Dropdown: Thấp, Trung bình, Cao - mặc định Trung bình).
  * `Trạng thái` (Dropdown/Segmented Control: Mới, Đang làm, Hoàn thành).
* **Bảng Kanban / List View**: Hiển thị thẻ công việc với màu sắc tương ứng với độ ưu tiên (Đỏ: Cao, Vàng: Trung bình, Xám: Thấp) và cảnh báo đỏ nếu công việc bị quá hạn (`overdue`).

### 1.3 Validation (Kiểm Tra Dữ Liệu)
* **Tiêu đề**: Không được để trống, độ dài từ 5 đến 255 ký tự.
* **Thời hạn chót (Due date)**: Phải là một ngày/giờ hợp lệ. Nếu thiết lập thời gian trong quá khứ, hệ thống sẽ hiển thị cảnh báo nhẹ nhưng vẫn cho phép lưu (phục vụ trường hợp ghi nhận lại các công việc đã làm trước đó).
* **Quyền hạn**: Người phụ trách (`assigned_to`) phải là một UUID tồn tại trong bảng `profiles`.

### 1.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Lỗi quá hạn (Overdue status)**: Nếu công việc có `due_date < NOW()` và trạng thái khác `done`, hệ thống tự động hiển thị tag "Quá hạn" và chuyển đổi logic hiển thị (front-end hiển thị trạng thái `overdue` dù trong DB vẫn là `todo` hoặc `in_progress`).
* **Lỗi phân quyền (RLS Violation)**: Khi Sales tìm cách sửa công việc của người khác ➔ Supabase trả về lỗi ➔ Hệ thống hiển thị Toast cảnh báo: *"Bạn không có quyền chỉnh sửa công việc này."*

### 1.5 Supabase Queries (Truy Vấn Supabase)
* **Tạo công việc**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .insert([
      {
        title: 'Gọi điện báo giá Yến Tinh Chế',
        description: 'Khách yêu cầu báo giá đại lý cho 5kg',
        lead_id: 'lead-uuid-123',
        assigned_to: 'sales-uuid-999',
        team_id: 'team-uuid-456', // Thừa hưởng từ lead
        priority: 'high',
        due_date: '2026-05-20T10:00:00+07:00'
      }
    ]);
  ```
* **Chỉnh sửa / Đổi trạng thái**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .update({ 
      status: 'done',
      completed_at: new Date().toISOString()
    })
    .eq('id', 'task-uuid-789');
  ```
* **Lấy danh sách công việc của tôi (Sales)**:
  ```javascript
  const { data, error } = await supabase
    .from('tasks')
    .select(`
      id, title, description, status, priority, due_date,
      leads ( id, full_name, phone_primary )
    `)
    .order('due_date', { ascending: true });
  ```

### 1.6 RLS (Chính Sách Bảo Mật) Liên Quan
* Áp dụng chính sách `tasks_select`, `tasks_insert_sales`, `tasks_update_sales` trong file `04_rls.sql`:
  * Nhân viên Sales chỉ được xem và sửa các công việc do chính mình phụ trách (`assigned_to = auth.uid()`).
  * Trưởng nhóm (`team_lead`) và `admin` được xem và sửa toàn bộ công việc thuộc nhóm mình quản lý (`team_id = ANY(get_my_team_ids())`).

### 1.7 Tiêu Chỉ Nghiệm Thu (Acceptance Criteria)
* [ ] Người dùng có thể tạo nhanh công việc từ trang chi tiết khách hàng và hệ thống tự liên kết đúng `lead_id`.
* [ ] Nhân viên Sales A không thể xem hoặc sửa công việc của Sales B (ngoại trừ khi họ chung một nhóm và người xem là Team Lead/Admin).
* [ ] Khi tích hoàn thành công việc, cột `completed_at` phải được ghi nhận thời gian thực tế và trạng thái đổi thành `done`.

---

## 2. Nhóm Tính Năng: Danh Sách Khách Hàng (Lead Lists)

Cho phép người dùng phân nhóm khách hàng theo các chiến dịch hoặc tiêu chí cụ thể để dễ dàng quản lý và chăm sóc hàng loạt.

### 2.1 User Flow (Luồng Người Dùng)
1. **Tạo danh sách**: Người dùng vào mục "Nhóm khách hàng" ➔ Nhấn "Tạo danh sách mới" ➔ Điền tên danh sách và mô tả ➔ Nhấn "Xác nhận".
2. **Thêm hàng loạt khách hàng vào danh sách**: Người dùng vào danh sách khách hàng chung ➔ Sử dụng bộ lọc hoặc tích chọn thủ công nhiều khách hàng ➔ Nhấn nút "Thêm vào nhóm" ➔ Chọn danh sách đích ➔ Hệ thống thêm các mối quan hệ vào bảng trung gian.
3. **Quản lý danh sách thành viên**: Người dùng mở chi tiết danh sách ➔ Xem toàn bộ thành viên ➔ Tìm kiếm nhanh theo tên/SĐT trong danh sách ➔ Nhấn "Xóa khỏi nhóm" đối với thành viên muốn loại bỏ.

### 2.2 UI Elements (Thành Phần Giao Diện)
* **Trang danh sách nhóm**: Hiển thị các nhóm khách hàng hiện có dưới dạng thẻ (Cards) kèm số lượng thành viên trong mỗi nhóm.
* **Modal tạo nhóm**: Form đơn giản gồm `Tên danh sách` (Bắt buộc) và `Mô tả` (Tùy chọn).
* **Nút hành động nhanh trên bảng khách hàng**: "Thêm vào danh sách..." (Hiện lên khi người dùng tích chọn ít nhất 1 dòng trên bảng).
* **Trang chi tiết nhóm**: 
  * Thanh tìm kiếm nhanh thành viên.
  * Bộ lọc Phân khúc (Khách lẻ, Đại lý, VIP).
  * Bảng danh sách thành viên kèm nút "Xóa khỏi nhóm" (icon Thùng rác/Remove).

### 2.3 Validation (Kiểm Tra Dữ Liệu)
* **Tên danh sách**: Bắt buộc nhập, tối đa 100 ký tự. Không được trùng tên danh sách đối với cùng một người tạo hoặc cùng một nhóm.
* **Ràng buộc thành viên**: Không được phép thêm trùng lặp một khách hàng vào cùng một danh sách (được đảm bảo bằng Khóa chính kết hợp `(list_id, lead_id)` trong bảng `lead_list_members`).

### 2.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Trùng lặp thành viên**: Khi thêm hàng loạt, nếu có khách hàng đã tồn tại trong danh sách ➔ Hệ thống sử dụng cơ chế `ON CONFLICT DO NOTHING` trên DB để bỏ qua dòng trùng lặp và tiếp tục thêm các dòng khác mà không báo lỗi sập tiến trình.
* **Khách hàng bị xóa khỏi hệ thống**: Nếu một khách hàng bị xóa vĩnh viễn khỏi bảng `leads` ➔ Ràng buộc `ON DELETE CASCADE` trên bảng `lead_list_members` sẽ tự động xóa khách hàng đó khỏi mọi danh sách liên quan mà không cần can thiệp thủ công.

### 2.5 Supabase Queries (Truy Vấn Supabase)
* **Tạo danh sách**:
  ```javascript
  const { data, error } = await supabase
    .from('lead_lists')
    .insert([
      { name: 'Khách mua yến thô tháng 5', description: 'Chiến dịch tri ân khách hàng cũ', created_by: 'user-uuid' }
    ]);
  ```
* **Thêm khách hàng vào danh sách (Hàng loạt)**:
  ```javascript
  const members = [
    { list_id: 'list-uuid-1', lead_id: 'lead-uuid-A', added_by: 'user-uuid' },
    { list_id: 'list-uuid-1', lead_id: 'lead-uuid-B', added_by: 'user-uuid' }
  ];
  const { data, error } = await supabase
    .from('lead_list_members')
    .insert(members); // Supabase hỗ trợ nhận mảng đối tượng để insert bulk
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
    .ilike('leads.full_name', '%Tuan Anh%'); // Tìm kiếm gần đúng theo tên khách hàng
  ```

### 2.6 RLS (Chính Sách Bảo Mật) Liên Quan
* Áp dụng chính sách bảo mật của `lead_lists` và `lead_list_members`:
  * Sales chỉ thấy các danh sách do mình tạo (`created_by = auth.uid()`).
  * Team Lead thấy các danh sách của nhóm mình (`team_id = ANY(get_my_team_ids())`).
  * Việc thêm/xóa thành viên chỉ được thực hiện nếu người dùng có quyền chỉnh sửa đối với danh sách đó.

### 2.7 Tiêu Chí Nghiệm Thu (Acceptance Criteria)
* [ ] Tạo danh sách thành công và hiển thị chính xác số lượng thành viên thực tế.
* [ ] Tính năng thêm hàng loạt hoạt động trơn tru (chọn 10 khách hàng và thêm vào danh sách chỉ bằng 1 click).
* [ ] Việc xóa khách hàng khỏi danh sách KHÔNG được làm mất thông tin của khách hàng đó trong bảng `leads` gốc.

---

## 3. Nhóm Tính Năng: Import / Export CSV

Hỗ trợ đưa dữ liệu khách hàng từ file excel/CSV vào hệ thống CRM nhanh chóng và xuất dữ liệu ra file phục vụ báo cáo.

### 3.1 User Flow (Luồng Người Dùng)
1. **Import (Nhập dữ liệu)**:
   * Bước 1: Người dùng vào trang "Khách hàng" ➔ Nhấn "Nhập từ CSV" ➔ Chọn file hoặc kéo thả file CSV vào vùng tải lên.
   * Bước 2: Hệ thống đọc file, hiển thị bảng xem trước (preview) 5 dòng đầu tiên.
   * Bước 3: Người dùng thực hiện map cột (ví dụ: Cột "Số điện thoại" trong file CSV tương ứng với trường "phone_primary" trong hệ thống).
   * Bước 4: Người dùng chọn danh sách đích (tùy chọn) để gom toàn bộ khách hàng sắp nhập vào một nhóm cụ thể.
   * Bước 5: Nhấn "Tiến hành nhập" ➔ Hệ thống chạy import hàng loạt ➔ Hiển thị kết quả: Số dòng nhập thành công, số dòng lỗi (nếu có).
2. **Export (Xuất dữ liệu)**:
   * Người dùng lọc danh sách khách hàng mong muốn ➔ Nhấn "Xuất file CSV" ➔ Hệ thống truy vấn toàn bộ dữ liệu khớp bộ lọc ➔ Tạo cấu trúc file CSV và tự động tải xuống máy tính của người dùng.

### 3.2 UI Elements (Thành Phần Giao Diện)
* **Khu vực kéo thả file (Dropzone)**: Hỗ trợ định dạng `.csv`.
* **Giao diện ánh xạ cột (Mapping Matrix)**:
  * Hiển thị danh sách các trường trong DB CRM (Họ tên, SĐT, Email, Phân khúc, Ghi chú...).
  * Mỗi trường đi kèm một Dropdown chứa danh sách các tiêu đề cột đọc được từ file CSV của người dùng để họ tự chọn ánh xạ.
* **Bộ chọn danh sách đích**: Dropdown hiển thị các danh sách khách hàng của người dùng.
* **Thanh tiến trình (Progress Bar)** và bảng thống kê kết quả nhập (thành công/thất bại).

### 3.3 Validation (Kiểm Tra Dữ Liệu)
* **Định dạng file**: Chỉ chấp nhận file `.csv`, dung lượng tối đa 5MB.
* **Trường bắt buộc**: Trường `Họ tên (full_name)` bắt buộc phải được map với một cột trong file CSV và giá trị không được trống.
* **Chuẩn hóa Phân khúc (Segment)**: Nếu trong CSV có cột phân khúc, giá trị phải được chuẩn hóa về khớp với enum (`retail` - Khách lẻ, `agent` - Đại lý, `vip` - VIP). Nếu không khớp hoặc để trống, hệ thống tự động gán mặc định là `retail`.
* **Số điện thoại**: Hệ thống tự động loại bỏ khoảng trắng và các ký tự đặc biệt không hợp lệ trong số điện thoại trước khi lưu.

### 3.4 Trường Hợp Lỗi (Error Cases) & Hướng Xử Lý
* **Lỗi trùng lặp Số điện thoại**: Theo PRD, nếu số điện thoại đã tồn tại trong hệ thống, hệ thống sẽ thực hiện cập nhật đè (Upsert) thông tin mới lên khách hàng cũ hoặc bỏ qua (tùy người dùng chọn cấu hình trước khi nhập).
* **Lỗi định dạng mã hóa (Encoding)**: Đối với các file CSV lưu tiếng Việt không đúng chuẩn UTF-8 (thường bị lỗi font hiển thị dấu hỏi hoặc ký tự lạ) ➔ Front-end tự động phát hiện mã hóa và chuyển về định dạng UTF-8 trước khi xử lý.

### 3.5 Supabase Queries (Truy Vấn Supabase)
* **Bulk Insert / Upsert Leads**:
  ```javascript
  // Mảng dữ liệu sau khi đã map cột và chuẩn hóa
  const leadsToImport = [
    { full_name: 'Nguyễn Văn A', phone_primary: '0901234567', segment: 'retail', created_by: 'user-uuid' },
    { full_name: 'Đại lý Vĩnh Hưng', phone_primary: '0988888888', segment: 'agent', created_by: 'user-uuid' }
  ];
  
  // Thực hiện nhập hàng loạt. Sử dụng onConflict để upsert nếu trùng số điện thoại
  const { data, error } = await supabase
    .from('leads')
    .upsert(leadsToImport, { onConflict: 'phone_primary' });
  ```
* **Bulk Insert vào Danh sách đích** (nếu người dùng chọn lưu vào danh sách):
  ```javascript
  // Sau khi lấy được danh sách UUID của các Leads vừa import thành công
  const listMembers = importedLeads.map(lead => ({
    list_id: 'target-list-uuid',
    lead_id: lead.id,
    added_by: 'user-uuid'
  }));
  
  await supabase
    .from('lead_list_members')
    .insert(listMembers);
  ```

### 3.6 RLS (Chính Sách Bảo Mật) Liên Quan
* Khi import dữ liệu, hệ thống tự động gán `created_by = auth.uid()` và `assigned_to = auth.uid()` (đối với nhân viên Sales) để tuân thủ chính sách RLS:
  * Sales chỉ được phép import khách hàng do họ phụ trách. Họ không được phép gán khách hàng mới cho người khác.
  * Team Lead có thể gán các khách hàng import cho các thành viên trong nhóm mình nhờ chính sách `leads_insert_team_lead`.

### 3.7 Tiêu Chỉ Nghiệm Thu (Acceptance Criteria)
* [ ] Nhập file CSV tiếng Việt có dấu hiển thị chính xác không bị lỗi font chữ.
* [ ] Hệ thống báo lỗi rõ ràng ở dòng cụ thể nếu dòng đó thiếu trường bắt buộc (ví dụ: dòng thứ 12 thiếu cột Họ tên).
* [ ] Dữ liệu xuất ra (Export) phải giữ nguyên các bộ lọc hiện tại trên màn hình giao diện (xuất đúng những gì đang lọc thấy).
