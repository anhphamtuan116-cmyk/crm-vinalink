# PRD chi tiết cho Web App CRM của Công ty Yến Sào Vĩnh Hưng

## 1. Bối cảnh và mục tiêu sản phẩm

### 1.1 Bối cảnh kinh doanh

Công ty Yến Sào Vĩnh Hưng hoạt động trong ngành thương mại và bán lẻ yến sào tại Việt Nam. Đây là một ngành hàng có đặc thù vừa mang tính tiêu dùng thường xuyên, vừa mang tính quà tặng, biếu tặng, chăm sóc sức khỏe và xây dựng lòng tin dài hạn với khách hàng. Khác với nhiều ngành bán lẻ thông thường, khách hàng trong ngành yến sào thường quan tâm mạnh đến nguồn gốc sản phẩm, mức độ tinh chế, công dụng, đối tượng sử dụng, chất lượng chăm sóc sau bán và uy tín thương hiệu.

Trong thực tế vận hành, dữ liệu khách hàng của doanh nghiệp thường đến từ nhiều nguồn như khách đến cửa hàng, khách nhắn tin qua Facebook, Zalo, TikTok, khách gọi điện trực tiếp, khách được giới thiệu bởi người quen, khách mua lại theo chu kỳ, đại lý nhỏ và các khách VIP có nhu cầu mua thường xuyên hoặc mua giá trị cao. Khi thông tin này không được quản lý tập trung, doanh nghiệp dễ gặp các vấn đề như thất lạc lịch sử tư vấn, bỏ sót khách hàng tiềm năng, không theo dõi được nhu cầu sản phẩm, không kiểm soát được tiến độ chăm sóc và khó đánh giá hiệu quả bán hàng của từng nhân sự. [file:33]

Use case đầu vào cho thấy giai đoạn 1 của hệ thống CRM cần tập trung giải quyết những bài toán cốt lõi nhất: quản lý khách hàng tập trung, theo dõi cơ hội bán hàng theo từng giai đoạn, phân công người phụ trách, ghi nhận lịch sử chăm sóc, hỗ trợ quản lý đội ngũ và kiểm soát quyền truy cập dữ liệu theo vai trò. Đây là định hướng phù hợp với mô hình bán lẻ và thương mại của doanh nghiệp vừa và nhỏ tại Việt Nam, đặc biệt trong các ngành hàng đòi hỏi chăm sóc khách hàng chặt chẽ như yến sào. [file:33]

### 1.2 Lý do cần sản phẩm CRM

CRM của Yến Sào Vĩnh Hưng không chỉ là nơi lưu danh sách khách hàng. Hệ thống cần trở thành công cụ điều hành hoạt động bán hàng hằng ngày, giúp ban quản lý nhìn được tình hình kinh doanh trên một màn hình chung, giúp trưởng nhóm theo dõi tiến độ đội ngũ, đồng thời giúp nhân viên sales xử lý khách hàng có trật tự và không bỏ sót việc phải làm.

Trong ngành yến sào, khách hàng có thể quay lại nhiều lần với nhu cầu khác nhau. Một khách hàng hôm nay có thể chỉ hỏi yến chưng để dùng thử, nhưng vài tuần sau có thể mua yến tinh chế để biếu tặng hoặc đặt định kỳ cho gia đình. Một đại lý nhỏ ban đầu có thể mua ít, nhưng sau đó trở thành nhóm khách mang lại doanh thu đều đặn. Vì vậy, doanh nghiệp cần một hệ thống đủ rõ để ghi nhận khách hàng, lưu sản phẩm quan tâm, quản lý phân khúc khách và theo dõi hành trình chăm sóc theo thời gian.

### 1.3 Mục tiêu sản phẩm giai đoạn 1

Giai đoạn 1 của sản phẩm tập trung vào việc xây dựng nền tảng CRM vận hành được trong thực tế, thay vì cố gắng làm quá nhiều tính năng nâng cao. Mục tiêu chính gồm:

- Tập trung toàn bộ dữ liệu khách hàng về một nơi.
- Theo dõi được cơ hội bán hàng theo từng giai đoạn xử lý.
- Hỗ trợ nhân sự làm việc hằng ngày thông qua danh sách công việc và lịch theo dõi.
- Cho phép phân loại khách hàng theo giá trị và nhu cầu sản phẩm.
- Hỗ trợ quản lý xem báo cáo nhanh qua dashboard.
- Quản lý thanh toán ở mức phù hợp với giai đoạn 1.
- Tạo nền tảng người dùng và xác thực ổn định để có thể lưu dữ liệu thật bằng Supabase.
- Thiết lập cơ chế phân quyền rõ ràng để bảo vệ dữ liệu khách hàng.

### 1.4 Mục tiêu kinh doanh trong 90 ngày đầu sau triển khai

Dựa trên use case đầu vào, hệ thống cần hỗ trợ doanh nghiệp đạt được các kết quả vận hành sau trong giai đoạn đầu sử dụng:

- Tăng tỷ lệ khách hàng được lưu trữ đầy đủ thông tin cơ bản.
- Tăng tỷ lệ khách hàng được gắn người phụ trách rõ ràng.
- Tăng tốc độ phản hồi lead mới trong ngày.
- Giảm tình trạng bỏ sót cuộc gọi lại hoặc bỏ sót khách đang chờ tư vấn.
- Tăng khả năng chăm sóc lại khách cũ và khai thác mua lại.
- Hỗ trợ ban quản lý theo dõi hiệu suất theo người và theo nhóm dễ hơn. [file:33]

### 1.5 Phạm vi của tài liệu này

Tài liệu PRD này mô tả chi tiết yêu cầu sản phẩm cho web app CRM của Công ty Yến Sào Vĩnh Hưng trong giai đoạn 1. Tài liệu bám sát use case đầu vào nhưng được điều chỉnh theo bối cảnh thực tế của ngành thương mại và bán lẻ yến sào. Tài liệu này là cơ sở để thống nhất giữa ban lãnh đạo, người quản lý vận hành, đội phát triển sản phẩm, đội thiết kế giao diện và đội kiểm thử trước khi bắt đầu triển khai.

## 2. Chân dung người dùng

### 2.1 Nhóm người dùng chính

Hệ thống phục vụ ba nhóm người dùng cốt lõi, tương ứng với cấu trúc vận hành phổ biến của doanh nghiệp bán hàng:

#### 2.1.1 Admin

Admin là người có quyền cao nhất trong hệ thống. Vai trò này thường là chủ doanh nghiệp, quản lý cấp cao hoặc người được giao phụ trách toàn bộ vận hành CRM. Admin cần xem toàn bộ dữ liệu, cấu hình hệ thống, quản lý người dùng, thiết lập phân quyền và theo dõi bức tranh chung về khách hàng, cơ hội bán hàng, thanh toán và hiệu suất đội ngũ. [file:33]

Nhu cầu chính của Admin:

- Nhìn tổng thể hoạt động kinh doanh trên dashboard.
- Theo dõi phân bổ khách hàng và hiệu quả xử lý lead.
- Quản lý người dùng, vai trò và phạm vi dữ liệu.
- Kiểm tra tình trạng thanh toán và doanh thu cơ bản.
- Ra quyết định nhanh khi thấy khách VIP, đại lý hoặc cơ hội lớn bị chậm xử lý.

#### 2.1.2 Trưởng nhóm

Trưởng nhóm là người chịu trách nhiệm điều phối và giám sát đội ngũ sales hoặc chăm sóc khách hàng. Họ không cần can thiệp toàn bộ hệ thống như Admin, nhưng cần xem và quản lý dữ liệu thuộc nhóm mình. Vai trò này cần bám sát tiến độ xử lý từng cơ hội, kiểm tra công việc tồn đọng, hỗ trợ phân công và thúc đẩy đội ngũ chốt đơn. [file:33]

Nhu cầu chính của Trưởng nhóm:

- Xem toàn bộ khách hàng và cơ hội của nhóm.
- Theo dõi Kanban để biết lead đang nằm ở giai đoạn nào.
- Phát hiện trường hợp chậm chăm sóc, chậm báo giá hoặc chậm chốt.
- Kiểm tra công việc cần làm của từng thành viên.
- Hỗ trợ xử lý khách giá trị cao hoặc khách có nguy cơ mất.

#### 2.1.3 Nhân viên sales

Nhân viên sales là người trực tiếp tư vấn, theo dõi và chốt đơn với khách hàng. Họ cần một hệ thống đơn giản, rõ ràng, cập nhật nhanh, tập trung vào khách mình phụ trách và các việc phải làm trong ngày. [file:33]

Nhu cầu chính của Sales:

- Thêm mới khách hàng tiềm năng nhanh chóng.
- Cập nhật tình trạng tư vấn dễ dàng.
- Ghi nhận sản phẩm khách quan tâm.
- Theo dõi việc cần làm và lịch hẹn gọi lại.
- Kiểm tra lịch sử trao đổi với khách.
- Ghi nhận thanh toán hoặc theo dõi tình trạng thanh toán.

### 2.2 Chân dung khách hàng của Yến Sào Vĩnh Hưng trong CRM

Ngoài người dùng hệ thống, CRM cần phản ánh đúng nhóm khách hàng ngoài thị trường mà doanh nghiệp đang phục vụ. Việc này rất quan trọng vì nó ảnh hưởng đến cấu trúc dữ liệu và cách tổ chức module.

#### 2.2.1 Khách lẻ

Đây là nhóm khách mua sử dụng cho bản thân hoặc gia đình, thường quan tâm đến công dụng, độ an tâm, giá cả hợp lý, sản phẩm phù hợp với trẻ nhỏ, người lớn tuổi hoặc người cần bồi bổ sức khỏe. Họ có thể mua yến chưng dùng thử, sau đó mua tiếp yến tinh chế hoặc yến thô nếu tin tưởng thương hiệu.

#### 2.2.2 Đại lý

Đây là nhóm khách mua đi bán lại hoặc cộng tác bán hàng, quan tâm đến mức giá, chính sách hợp tác, độ ổn định nguồn hàng, chất lượng đóng gói và khả năng giao hàng đúng hẹn. Họ thường có giá trị đơn hàng lớn hơn, vòng lặp mua hàng dài hơn và cần lịch sử chăm sóc chặt chẽ hơn.

#### 2.2.3 Khách VIP

Đây là nhóm khách có tần suất mua cao, giá trị mua lớn, hoặc có tầm ảnh hưởng như khách doanh nghiệp, khách mua quà biếu cao cấp, khách hàng trung thành lâu năm hoặc người được ưu tiên chăm sóc riêng. Nhóm này cần được nhận diện rõ trong CRM để tránh bị bỏ sót hoặc xử lý như khách thông thường.

### 2.3 Kỳ vọng của người dùng đối với hệ thống

Người dùng của hệ thống CRM trong doanh nghiệp thương mại bán lẻ thường không muốn một công cụ quá phức tạp. Họ cần tính rõ ràng, thao tác nhanh, dễ hiểu, dễ nhìn, không mất nhiều thời gian học sử dụng. Do đó, sản phẩm phải ưu tiên tính trực quan, luồng sử dụng ngắn, ít bước thừa và thể hiện thông tin theo ngôn ngữ kinh doanh thay vì thuật ngữ chuyên sâu.

## 3. Danh sách module

Ứng dụng CRM giai đoạn 1 của Yến Sào Vĩnh Hưng bao gồm 6 khu vực chính theo yêu cầu đầu vào: Tổng quan, Cơ hội bán hàng, Công việc, Danh sách khách hàng, Thanh toán và Cài đặt.

### 3.1 Module Tổng quan

Module Tổng quan là màn hình đầu tiên sau khi đăng nhập. Đây là nơi thể hiện bức tranh tóm tắt về hoạt động bán hàng và chăm sóc khách hàng trong ngày, trong tuần hoặc trong tháng.

Chức năng chính:

- Hiển thị số khách hàng mới.
- Hiển thị số cơ hội bán hàng đang xử lý.
- Hiển thị số cơ hội theo từng giai đoạn.
- Hiển thị số công việc đến hạn hoặc quá hạn.
- Hiển thị tình trạng thanh toán cơ bản.
- Hiển thị biểu đồ doanh thu hoặc số lượng thanh toán theo kỳ.
- Hiển thị biểu đồ cơ cấu khách hàng theo phân khúc như Khách lẻ, Đại lý, VIP.
- Hiển thị biểu đồ sản phẩm quan tâm như Yến thô, Yến chưng, Yến tinh chế.

Mục tiêu của module này là giúp người quản lý và người bán hàng nhìn nhanh tình hình hiện tại, từ đó ưu tiên đúng việc cần xử lý trước.

### 3.2 Module Cơ hội bán hàng

Đây là module quan trọng nhất của hệ thống trong giai đoạn 1. Mọi khách hàng tiềm năng sau khi được ghi nhận đều cần có thể đi qua một luồng xử lý rõ ràng.

Chức năng chính:

- Xem cơ hội bán hàng theo dạng Kanban kéo thả.
- Các cột trạng thái mặc định gồm: Mới, Đang tư vấn, Đã báo giá, Chờ phản hồi, Đã chốt, Thất bại.
- Tạo mới cơ hội bán hàng.
- Sửa thông tin cơ hội.
- Xóa cơ hội bán hàng khi có quyền phù hợp.
- Gắn khách hàng liên quan cho cơ hội.
- Gắn người phụ trách.
- Ghi giá trị dự kiến của cơ hội.
- Ghi nhu cầu sản phẩm khách quan tâm.
- Kéo thả thẻ cơ hội từ cột này sang cột khác để thay đổi trạng thái.
- Lưu lịch sử thay đổi trạng thái.
- Tìm kiếm và lọc theo người phụ trách, phân khúc khách, sản phẩm quan tâm, ngày tạo và trạng thái.

Kanban kéo thả là yêu cầu quan trọng vì nó giúp đội bán hàng nhìn rõ dòng chảy cơ hội và xử lý trực quan hơn so với dạng bảng đơn thuần.

### 3.3 Module Công việc

Module Công việc giúp biến CRM thành công cụ làm việc hằng ngày thay vì chỉ là nơi lưu thông tin.

Chức năng chính:

- Tạo công việc mới.
- Giao công việc cho bản thân hoặc cho thành viên trong nhóm nếu có quyền.
- Gắn công việc với khách hàng hoặc cơ hội bán hàng.
- Thiết lập ngày đến hạn.
- Đánh dấu mức độ ưu tiên.
- Cập nhật trạng thái công việc: Chưa làm, Đang làm, Hoàn thành, Quá hạn.
- Hiển thị danh sách công việc theo ngày.
- Lọc công việc theo người phụ trách, trạng thái, độ ưu tiên.
- Nhắc người dùng về các công việc đến hạn.

Ví dụ công việc thường gặp trong ngành yến sào gồm gọi lại khách đã được tư vấn, gửi bảng giá đại lý, chăm sóc khách VIP sau mua, nhắc khách hoàn tất thanh toán hoặc xác nhận nhu cầu mua lại.

### 3.4 Module Danh sách khách hàng

Đây là module quản lý dữ liệu khách hàng tập trung của toàn bộ hệ thống.

Chức năng chính:

- Thêm khách hàng mới.
- Sửa thông tin khách hàng.
- Xóa khách hàng khi có quyền phù hợp.
- Xem chi tiết hồ sơ khách hàng.
- Tìm kiếm khách hàng theo tên, số điện thoại, email.
- Gắn phân khúc khách hàng: Khách lẻ, Đại lý, VIP.
- Gắn sản phẩm khách quan tâm: Yến thô, Yến chưng, Yến tinh chế.
- Gắn người phụ trách.
- Ghi chú nhu cầu hoặc lịch sử liên hệ.
- Import khách hàng từ CSV.
- Export danh sách khách hàng ra CSV.
- Hạn chế tạo trùng khách hàng ở mức cơ bản.

Đối với ngành yến sào, việc ghi nhận phân khúc và sản phẩm quan tâm là đặc biệt quan trọng vì nó liên quan trực tiếp tới cách chăm sóc, ưu tiên và chiến lược chốt bán.

### 3.5 Module Thanh toán

Module Thanh toán trong giai đoạn 1 không cần đi quá sâu như hệ thống kế toán, nhưng cần đủ để hỗ trợ đội vận hành nắm được tình trạng thu tiền liên quan đến khách hàng và cơ hội bán hàng.

Chức năng chính:

- Tạo bản ghi thanh toán.
- Liên kết thanh toán với khách hàng.
- Liên kết thanh toán với cơ hội bán hàng nếu có.
- Ghi nhận số tiền.
- Ghi nhận phương thức thanh toán.
- Ghi nhận trạng thái thanh toán như Chưa thanh toán, Thanh toán một phần, Đã thanh toán.
- Ghi nhận ngày thanh toán.
- Ghi chú nội dung thanh toán.
- Lọc danh sách thanh toán theo trạng thái, thời gian, người phụ trách.
- Xem tổng số tiền đã thanh toán trong kỳ ở mức cơ bản.

Module này nhằm giúp ban quản lý và sales phối hợp tốt hơn giữa chốt bán và thu tiền mà chưa cần triển khai chức năng kế toán đầy đủ trong giai đoạn 1.

### 3.6 Module Cài đặt

Module Cài đặt là nơi phục vụ quản trị hệ thống.

Chức năng chính:

- Quản lý người dùng.
- Tạo tài khoản người dùng mới.
- Gán vai trò cho người dùng.
- Gán người dùng vào nhóm.
- Kích hoạt hoặc ngừng sử dụng tài khoản.
- Quản lý danh mục phân khúc khách hàng.
- Quản lý danh mục sản phẩm quan tâm.
- Quản lý trạng thái cơ hội bán hàng nếu cần mở rộng.
- Quản lý cấu hình xác thực.
- Quản lý thông tin doanh nghiệp cơ bản.

## 4. User flow chính

### 4.1 User flow đăng ký và đăng nhập

#### Luồng 1: Đăng ký bằng email và mật khẩu

1. Người dùng mở trang đăng ký.
2. Nhập họ tên, email, mật khẩu.
3. Hệ thống kiểm tra email đã tồn tại hay chưa.
4. Nếu chưa tồn tại, hệ thống tạo hồ sơ người dùng mới.
5. Người dùng đăng nhập vào hệ thống.

#### Luồng 2: Đăng nhập bằng email và mật khẩu

1. Người dùng mở trang đăng nhập.
2. Nhập email và mật khẩu.
3. Hệ thống xác thực thông tin.
4. Nếu đúng, chuyển vào trang Tổng quan.

#### Luồng 3: Đăng nhập bằng Google

1. Người dùng chọn đăng nhập bằng Google.
2. Chọn tài khoản Google.
3. Hệ thống nhận email từ Google.
4. Nếu email chưa tồn tại trong hệ thống, tạo hồ sơ người dùng mới.
5. Nếu email đã tồn tại, liên kết phương thức đăng nhập Google với hồ sơ người dùng hiện có.
6. Người dùng được vào hệ thống với đúng vai trò và quyền đang có.

#### Luồng 4: Quên mật khẩu

1. Người dùng chọn quên mật khẩu.
2. Nhập email đã đăng ký.
3. Hệ thống gửi hướng dẫn đặt lại mật khẩu.
4. Người dùng đặt mật khẩu mới.
5. Đăng nhập lại vào hệ thống.

### 4.2 User flow tạo khách hàng tiềm năng mới

1. Sales mở module Danh sách khách hàng.
2. Chọn Thêm khách hàng.
3. Nhập các thông tin cơ bản như tên, số điện thoại, email, nguồn khách, phân khúc, sản phẩm quan tâm.
4. Chọn người phụ trách.
5. Lưu hồ sơ khách hàng.
6. Hệ thống hiển thị khách trong danh sách và cho phép tạo cơ hội bán hàng tương ứng.

### 4.3 User flow xử lý cơ hội bán hàng bằng Kanban

1. Sales hoặc Trưởng nhóm mở module Cơ hội bán hàng.
2. Xem các thẻ cơ hội theo từng cột trạng thái.
3. Chọn một cơ hội để xem chi tiết.
4. Cập nhật ghi chú, giá trị dự kiến, công việc tiếp theo.
5. Kéo thả thẻ sang trạng thái mới khi tiến độ thay đổi.
6. Hệ thống lưu lại thay đổi và cập nhật số liệu dashboard.

### 4.4 User flow tạo và theo dõi công việc

1. Người dùng mở module Công việc.
2. Tạo công việc mới gắn với khách hàng hoặc cơ hội.
3. Chọn ngày đến hạn và người phụ trách.
4. Hệ thống hiển thị công việc trong danh sách cá nhân hoặc nhóm.
5. Khi hoàn thành, người dùng cập nhật trạng thái.
6. Trưởng nhóm có thể theo dõi việc tồn đọng và hỗ trợ xử lý.

### 4.5 User flow import khách hàng từ CSV

1. Admin hoặc người có quyền mở module Danh sách khách hàng.
2. Chọn chức năng import CSV.
3. Tải lên tệp CSV theo mẫu chuẩn.
4. Hệ thống kiểm tra cấu trúc tệp.
5. Hiển thị kết quả xem trước.
6. Người dùng xác nhận nhập dữ liệu.
7. Hệ thống thêm khách hợp lệ và thông báo các dòng lỗi nếu có.

### 4.6 User flow export khách hàng ra CSV

1. Người dùng mở danh sách khách hàng.
2. Lọc theo điều kiện mong muốn.
3. Chọn xuất CSV.
4. Hệ thống tạo tệp theo danh sách đang xem.
5. Người dùng tải tệp xuống.

### 4.7 User flow ghi nhận thanh toán

1. Sales hoặc người quản lý mở module Thanh toán.
2. Chọn tạo thanh toán mới.
3. Chọn khách hàng liên quan.
4. Chọn cơ hội bán hàng liên quan nếu có.
5. Nhập số tiền, phương thức, ngày thanh toán, trạng thái.
6. Lưu bản ghi.
7. Hệ thống cập nhật tổng quan thanh toán trên dashboard.

## 5. Danh sách data fields chính

### 5.1 Data fields cho người dùng hệ thống

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | user_id | Mã người dùng duy nhất |
| Nhận diện | họ_tên | Họ tên hiển thị |
| Nhận diện | email | Email đăng nhập chính |
| Nhận diện | số_điện_thoại | Số điện thoại nội bộ nếu có |
| Quyền | role | Admin, Trưởng nhóm, Sales |
| Quyền | team_id | Nhóm phụ trách |
| Trạng thái | trạng_thái_tài_khoản | Đang hoạt động hoặc ngừng hoạt động |
| Xác thực | có_mật_khẩu | Có dùng email/mật khẩu hay không |
| Xác thực | có_google | Có liên kết Google hay không |
| Hệ thống | created_at | Ngày tạo |
| Hệ thống | updated_at | Ngày cập nhật |

### 5.2 Data fields cho khách hàng

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | customer_id | Mã khách hàng |
| Cơ bản | họ_tên | Tên khách hàng |
| Cơ bản | số_điện_thoại | Số điện thoại |
| Cơ bản | email | Email |
| Cơ bản | giới_tính | Tùy chọn nếu cần |
| Cơ bản | ngày_sinh | Tùy chọn nếu cần |
| Kinh doanh | phân_khúc | Khách lẻ, Đại lý, VIP |
| Kinh doanh | sản_phẩm_quan_tâm | Yến thô, Yến chưng, Yến tinh chế |
| Kinh doanh | nguồn_khách | Facebook, Zalo, Cửa hàng, Giới thiệu, Khác |
| Kinh doanh | người_phụ_trách | User đang phụ trách |
| Kinh doanh | trạng_thái_khách | Mới, Đang chăm sóc, Đã mua, Ngưng theo dõi |
| Ghi chú | ghi_chú | Nhu cầu, đối tượng sử dụng, lịch sử ngắn |
| Hệ thống | created_at | Ngày tạo |
| Hệ thống | updated_at | Ngày cập nhật |

### 5.3 Data fields cho cơ hội bán hàng

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | opportunity_id | Mã cơ hội |
| Liên kết | customer_id | Liên kết khách hàng |
| Cơ bản | tên_cơ_hội | Tên hiển thị |
| Cơ bản | trạng_thái | Mới, Đang tư vấn, Đã báo giá, Chờ phản hồi, Đã chốt, Thất bại |
| Kinh doanh | giá_trị_dự_kiến | Giá trị dự kiến |
| Kinh doanh | xác_suất_chốt | Tùy chọn cho giai đoạn sau |
| Kinh doanh | sản_phẩm_quan_tâm | Yến thô, Yến chưng, Yến tinh chế |
| Phụ trách | owner_id | Người phụ trách |
| Phụ trách | team_id | Nhóm phụ trách |
| Theo dõi | ngày_dự_kiến_chốt | Ngày kỳ vọng |
| Theo dõi | lý_do_thất_bại | Khi cơ hội thất bại |
| Ghi chú | ghi_chú | Tóm tắt nhu cầu và trao đổi |
| Hệ thống | created_at | Ngày tạo |
| Hệ thống | updated_at | Ngày cập nhật |

### 5.4 Data fields cho công việc

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | task_id | Mã công việc |
| Cơ bản | tiêu_đề | Tên công việc |
| Cơ bản | mô_tả | Chi tiết công việc |
| Liên kết | customer_id | Gắn với khách hàng nếu có |
| Liên kết | opportunity_id | Gắn với cơ hội nếu có |
| Phụ trách | assignee_id | Người thực hiện |
| Phụ trách | created_by | Người tạo |
| Theo dõi | ngày_đến_hạn | Deadline |
| Theo dõi | mức_độ_ưu_tiên | Thấp, Trung bình, Cao |
| Theo dõi | trạng_thái | Chưa làm, Đang làm, Hoàn thành, Quá hạn |
| Hệ thống | created_at | Ngày tạo |
| Hệ thống | updated_at | Ngày cập nhật |

### 5.5 Data fields cho thanh toán

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | payment_id | Mã thanh toán |
| Liên kết | customer_id | Khách hàng liên quan |
| Liên kết | opportunity_id | Cơ hội liên quan nếu có |
| Tài chính | số_tiền | Giá trị thanh toán |
| Tài chính | phương_thức | Tiền mặt, Chuyển khoản, Khác |
| Tài chính | trạng_thái | Chưa thanh toán, Một phần, Đã thanh toán |
| Tài chính | ngày_thanh_toán | Ngày ghi nhận |
| Tài chính | mã_tham_chiếu | Mã đối soát nếu có |
| Ghi chú | ghi_chú | Nội dung thêm |
| Phụ trách | owner_id | Người phụ trách |
| Hệ thống | created_at | Ngày tạo |
| Hệ thống | updated_at | Ngày cập nhật |

### 5.6 Data fields cho lịch sử hoạt động

| Nhóm trường | Tên trường | Mô tả |
|---|---|---|
| Nhận diện | activity_id | Mã hoạt động |
| Liên kết | customer_id | Khách liên quan |
| Liên kết | opportunity_id | Cơ hội liên quan |
| Liên kết | task_id | Công việc liên quan |
| Nội dung | loại_hoạt_động | Gọi điện, nhắn tin, gặp trực tiếp, cập nhật trạng thái |
| Nội dung | nội_dung | Chi tiết ghi chú |
| Phụ trách | created_by | Người ghi nhận |
| Hệ thống | created_at | Thời điểm ghi nhận |

## 6. Quy tắc phân quyền

### 6.1 Nguyên tắc chung

Phân quyền của hệ thống không phụ thuộc vào cách đăng nhập. Dù người dùng đăng nhập bằng email và mật khẩu hay đăng nhập bằng Google, hệ thống vẫn phải xác định họ là cùng một người dùng nếu email trùng nhau, và phải giữ nguyên vai trò cũng như phạm vi truy cập dữ liệu. [file:33]

Dữ liệu khách hàng thuộc về doanh nghiệp, không thuộc riêng một tài khoản đăng nhập. Tuy nhiên, việc hiển thị và chỉnh sửa dữ liệu phải theo vai trò và phạm vi được giao để đảm bảo tính kiểm soát, tránh rò rỉ thông tin và giảm nguy cơ thao tác sai. [file:33]

### 6.2 Quyền của Admin

Admin có các quyền sau:

- Xem toàn bộ khách hàng, cơ hội, công việc, thanh toán.
- Tạo, sửa, xóa dữ liệu trên toàn hệ thống.
- Quản lý người dùng và vai trò.
- Gán người dùng vào nhóm.
- Bật hoặc tắt tài khoản.
- Xem báo cáo toàn doanh nghiệp.
- Cấu hình danh mục hệ thống.

### 6.3 Quyền của Trưởng nhóm

Trưởng nhóm có các quyền sau:

- Xem toàn bộ dữ liệu thuộc nhóm mình.
- Tạo, sửa dữ liệu của nhóm mình.
- Theo dõi công việc của thành viên trong nhóm.
- Xem cơ hội bán hàng của nhóm theo Kanban.
- Hỗ trợ cập nhật trạng thái hoặc điều phối xử lý.
- Xem báo cáo giới hạn trong phạm vi nhóm.

Trưởng nhóm không được:

- Xem dữ liệu của nhóm khác nếu không có phân quyền đặc biệt.
- Quản lý toàn bộ người dùng hệ thống.
- Thay đổi cấu hình hệ thống ở mức Admin.

### 6.4 Quyền của Sales

Sales có các quyền sau:

- Xem dữ liệu khách hàng do mình phụ trách.
- Tạo khách hàng mới trong phạm vi được phép.
- Cập nhật cơ hội bán hàng do mình phụ trách.
- Tạo và cập nhật công việc của bản thân.
- Xem thanh toán liên quan tới khách hàng hoặc cơ hội mình phụ trách theo phạm vi được cho phép.

Sales không được:

- Xem dữ liệu của người khác ngoài phạm vi được giao.
- Xem báo cáo toàn hệ thống.
- Quản lý người dùng hoặc cấu hình cài đặt.

### 6.5 Quy tắc truy cập dữ liệu

- Mỗi khách hàng phải có một người phụ trách chính.
- Mỗi cơ hội bán hàng phải có người phụ trách rõ ràng.
- Nếu dữ liệu thuộc về một nhóm, Trưởng nhóm của nhóm đó có quyền xem và quản lý.
- Nếu người phụ trách được thay đổi, quyền hiển thị dữ liệu được cập nhật theo người phụ trách mới và nhóm liên quan.
- Admin luôn có quyền ưu tiên cao nhất trên mọi dữ liệu.

## 7. Yêu cầu giao diện và phong cách thiết kế

### 7.1 Nguyên tắc giao diện

Giao diện của CRM phải theo định hướng chuyên nghiệp, gọn gàng, sáng rõ và dễ sử dụng đối với doanh nghiệp thương mại bán lẻ. Mục tiêu là giúp người dùng nhìn thấy thông tin quan trọng nhanh, thao tác ít bước và cảm thấy quen thuộc ngay trong lần đầu sử dụng.

### 7.2 Phong cách đề xuất

- Bố cục dạng web app hiện đại, có thanh điều hướng bên trái hoặc phía trên.
- Màu sắc chủ đạo nên sạch, tin cậy, phù hợp với ngành chăm sóc sức khỏe và quà tặng cao cấp.
- Có thể ưu tiên các gam trắng, kem, nâu nhạt, vàng nhấn hoặc xanh đậm nhẹ để tạo cảm giác chất lượng và tin cậy.
- Tránh dùng màu quá gắt hoặc bố cục rối mắt.
- Ưu tiên hiển thị dữ liệu rõ ràng hơn là trang trí.

### 7.3 Yêu cầu trải nghiệm sử dụng

- Dashboard phải dễ đọc, ưu tiên số liệu và biểu đồ ngắn gọn.
- Kanban phải kéo thả mượt, nhìn rõ từng giai đoạn.
- Danh sách khách hàng phải hỗ trợ tìm kiếm và lọc nhanh.
- Form thêm mới khách hàng phải ngắn gọn, không bắt người dùng nhập quá nhiều ngay từ đầu.
- Các hành động quan trọng như xóa, đổi trạng thái, import dữ liệu cần có bước xác nhận.
- Mỗi module cần có cảm giác nhất quán về cách bố trí nút, tiêu đề và bảng dữ liệu.

### 7.4 Yêu cầu responsive

Vì đây là web app, hệ thống cần hoạt động tốt trên máy tính là chính. Tuy nhiên, giao diện cũng cần dùng được trên màn hình nhỏ hơn như máy tính bảng và điện thoại ở mức tối thiểu, đặc biệt với các thao tác xem dashboard, xem danh sách khách và cập nhật trạng thái cơ hội.

## 8. Yêu cầu kỹ thuật mức cao

### 8.1 Kiến trúc tổng thể

Ứng dụng được xây dựng dưới dạng web app, hướng tới khả năng sử dụng dữ liệu thật bằng Supabase. Kiến trúc cần đủ rõ để tách các phần chính gồm giao diện, xử lý nghiệp vụ, xác thực người dùng và lưu trữ dữ liệu.

### 8.2 Yêu cầu lưu trữ dữ liệu

- Chuẩn bị cấu trúc dữ liệu thật để lưu trên Supabase.
- Dữ liệu người dùng, khách hàng, cơ hội, công việc, thanh toán và lịch sử hoạt động cần có quan hệ rõ ràng.
- Mỗi bản ghi quan trọng cần có ngày tạo và ngày cập nhật.
- Cần chuẩn bị cơ chế tránh trùng hồ sơ người dùng và hạn chế trùng khách hàng ở mức cơ bản.

### 8.3 Yêu cầu hiệu năng

- Dashboard cần tải trong thời gian hợp lý với dữ liệu giai đoạn đầu.
- Danh sách khách hàng cần hỗ trợ phân trang hoặc tải theo từng phần.
- Kanban phải phản hồi nhanh khi kéo thả.
- Import CSV cần xử lý được tệp có quy mô phù hợp với doanh nghiệp vừa và nhỏ.

### 8.4 Yêu cầu an toàn dữ liệu

- Mỗi người dùng chỉ được xem dữ liệu đúng phạm vi.
- Tài khoản ngừng hoạt động không được truy cập vào hệ thống.
- Các hành động quan trọng cần được ghi nhận lịch sử.
- Cần có cơ chế đặt lại mật khẩu an toàn.

### 8.5 Yêu cầu mở rộng tương lai

Thiết kế giai đoạn 1 cần đủ nền tảng để sau này có thể mở rộng thêm:

- Tích hợp hóa đơn và kế toán.
- Tích hợp vận chuyển.
- Tự động hóa chăm sóc khách hàng.
- Chương trình khách hàng thân thiết.
- Báo cáo nâng cao theo khu vực, sản phẩm và nhân sự.
- Tích hợp chatbot hoặc nhắn tin tự động.

## 9. Tiêu chí nghiệm thu giai đoạn 1

### 9.1 Nghiệm thu về chức năng

Hệ thống được xem là đạt yêu cầu giai đoạn 1 khi đáp ứng đầy đủ các tiêu chí sau:

- Có màn hình Tổng quan hiển thị số liệu và biểu đồ cơ bản.
- Có module Cơ hội bán hàng dạng Kanban kéo thả hoạt động ổn định.
- Có module Công việc cho phép tạo, cập nhật, theo dõi việc cần làm.
- Có module Danh sách khách hàng cho phép thêm, sửa, xóa, tìm kiếm và xem chi tiết.
- Có gắn phân khúc khách hàng gồm Khách lẻ, Đại lý, VIP.
- Có gắn sản phẩm quan tâm gồm Yến thô, Yến chưng, Yến tinh chế.
- Có chức năng import khách hàng từ CSV.
- Có chức năng export khách hàng ra CSV.
- Có module Thanh toán ở mức ghi nhận và theo dõi cơ bản.
- Có module Cài đặt để quản lý người dùng và vai trò.

### 9.2 Nghiệm thu về phân quyền

- Admin xem và quản lý được toàn bộ dữ liệu.
- Trưởng nhóm chỉ xem và quản lý dữ liệu của nhóm mình.
- Sales chỉ xem và quản lý dữ liệu do mình phụ trách.
- Người dùng không thể xem dữ liệu ngoài phạm vi được giao.

### 9.3 Nghiệm thu về xác thực

- Người dùng đăng ký và đăng nhập được bằng email và mật khẩu.
- Người dùng đăng nhập được bằng Google.
- Có chức năng quên mật khẩu và đặt lại mật khẩu.
- Nếu cùng một email đăng nhập bằng nhiều cách, hệ thống không tạo hồ sơ người dùng trùng.
- Vai trò và quyền truy cập vẫn giữ nguyên khi người dùng đổi cách đăng nhập. [file:33]

### 9.4 Nghiệm thu về dữ liệu

- Dữ liệu khách hàng được lưu và truy xuất đúng.
- Dữ liệu cơ hội bán hàng cập nhật đúng khi kéo thả Kanban.
- Công việc liên kết đúng với khách hàng hoặc cơ hội.
- Thanh toán hiển thị đúng với khách hàng liên quan.
- Import CSV ghi nhận đúng các dòng hợp lệ và thông báo lỗi rõ các dòng không hợp lệ.
- Export CSV xuất ra đúng các trường đã chọn hoặc đúng danh sách đang lọc.

### 9.5 Nghiệm thu về trải nghiệm sử dụng

- Người dùng có thể hiểu và sử dụng những luồng chính mà không cần đào tạo quá sâu.
- Các màn hình chính hiển thị rõ, không rối, không gây nhầm lẫn.
- Các nút hành động chính dễ nhìn, dễ hiểu.
- Giao diện nhất quán giữa các module.

## 10. Yêu cầu xác thực và liên kết tài khoản

### 10.1 Nguyên tắc bắt buộc

Hệ thống phải cho phép đồng thời hai phương thức xác thực:

1. Đăng ký và đăng nhập bằng email cùng mật khẩu.
2. Đăng nhập bằng Google OAuth.

Đây là yêu cầu bắt buộc của giai đoạn 1 và phải được triển khai song song ngay từ đầu. [file:33]

### 10.2 Một người dùng duy nhất cho một email

Nếu cùng một email được sử dụng ở nhiều phương thức đăng nhập, hệ thống phải coi đó là cùng một người dùng. Ví dụ, nếu một nhân viên đã có tài khoản bằng email và mật khẩu, sau đó dùng chính email đó để đăng nhập bằng Google, hệ thống không được tạo thêm hồ sơ người dùng mới. Thay vào đó, hệ thống phải liên kết phương thức Google vào hồ sơ người dùng hiện có. [file:33]

### 10.3 Nguyên tắc giữ nguyên vai trò và quyền truy cập

Vai trò của người dùng như Admin, Trưởng nhóm hay Sales không được gắn với cách đăng nhập. Vai trò phải được gắn với hồ sơ người dùng. Vì vậy, khi một người dùng đổi từ đăng nhập bằng email và mật khẩu sang Google hoặc ngược lại, hệ thống vẫn phải giữ nguyên:

- Vai trò.
- Nhóm phụ trách.
- Phạm vi dữ liệu được xem.
- Các quyền tạo, sửa, xóa tương ứng.

Yêu cầu này giúp doanh nghiệp tránh rối quyền truy cập, tránh phát sinh tài khoản trùng và giữ hệ thống ổn định trong quá trình sử dụng thực tế. [file:33]

### 10.4 Luật xử lý các trường hợp thường gặp

#### Trường hợp 1: Người dùng mới đăng ký bằng email và mật khẩu

- Nếu email chưa tồn tại, tạo người dùng mới.
- Gán vai trò theo cấu hình ban đầu hoặc chờ Admin duyệt.

#### Trường hợp 2: Người dùng mới đăng nhập bằng Google lần đầu

- Nếu email chưa tồn tại, tạo người dùng mới.
- Gán vai trò theo cấu hình ban đầu hoặc chờ Admin duyệt.

#### Trường hợp 3: Người dùng đã có tài khoản email và mật khẩu, sau đó đăng nhập bằng Google với cùng email

- Không tạo tài khoản mới.
- Liên kết Google với tài khoản hiện có.
- Giữ nguyên vai trò và quyền truy cập.

#### Trường hợp 4: Người dùng đã có tài khoản Google, sau đó muốn đặt mật khẩu để đăng nhập bằng email và mật khẩu

- Không tạo tài khoản mới.
- Bổ sung phương thức đăng nhập bằng mật khẩu vào hồ sơ hiện có.
- Giữ nguyên vai trò và quyền truy cập.

#### Trường hợp 5: Admin đổi vai trò của người dùng

- Vai trò mới phải áp dụng cho toàn bộ lần đăng nhập sau đó, không phân biệt người dùng đăng nhập bằng cách nào.

### 10.5 Yêu cầu quản trị trong Cài đặt

Module Cài đặt cần cho phép Admin nhìn thấy tình trạng xác thực của từng người dùng ở mức dễ hiểu, ví dụ:

- Tài khoản này có đăng nhập bằng email và mật khẩu hay không.
- Tài khoản này có liên kết Google hay không.
- Email chính của tài khoản là gì.
- Vai trò hiện tại là gì.
- Tài khoản đang hoạt động hay tạm ngừng.

### 10.6 Rủi ro cần tránh

- Tạo trùng hồ sơ người dùng khi email giống nhau.
- Mất quyền truy cập cũ khi người dùng đổi cách đăng nhập.
- Phân quyền theo phiên đăng nhập thay vì theo hồ sơ người dùng.
- Khó kiểm soát tài khoản khi nhân sự thay đổi cách truy cập hệ thống.

## 11. Giả định, giới hạn và hạng mục chưa làm trong giai đoạn 1

### 11.1 Giả định

- Doanh nghiệp đã có quy ước cơ bản về đội ngũ bán hàng và người quản lý.
- Dữ liệu khách hàng đầu vào có thể được làm sạch ở mức cơ bản trước khi import.
- Giai đoạn 1 ưu tiên vận hành nhanh, chưa cần tự động hóa sâu.

### 11.2 Giới hạn

- Chưa triển khai hệ thống kế toán đầy đủ.
- Chưa tích hợp vận chuyển.
- Chưa có chương trình khách hàng thân thiết.
- Chưa có chatbot.
- Chưa có phân tích nâng cao bằng trí tuệ nhân tạo.
- Chưa có ứng dụng di động riêng.

### 11.3 Hạng mục chuyển sang giai đoạn sau

- Tự động nhắc chăm sóc khách qua nhiều kênh.
- Kết nối kho hàng và tồn kho.
- Quản lý đơn hàng nâng cao.
- Báo cáo lợi nhuận theo sản phẩm.
- Phân tích vòng đời khách hàng.
- Tự động phân loại khách theo hành vi mua.

## 12. Kế hoạch triển khai đề xuất

### 12.1 Giai đoạn chuẩn bị

- Xác nhận phạm vi và tiêu chí nghiệm thu.
- Chốt danh sách vai trò và quyền dữ liệu.
- Chốt cấu trúc danh mục như phân khúc khách và sản phẩm quan tâm.
- Chuẩn bị mẫu CSV import.

### 12.2 Giai đoạn thiết kế

- Thiết kế luồng sử dụng chính.
- Thiết kế giao diện cho 6 module.
- Xác nhận dashboard, Kanban, danh sách khách hàng, thanh toán và cài đặt.

### 12.3 Giai đoạn phát triển

- Xây dựng xác thực.
- Xây dựng quản lý người dùng và phân quyền.
- Xây dựng khách hàng, cơ hội, công việc, thanh toán.
- Xây dựng dashboard và CSV import/export.
- Kết nối dữ liệu thật bằng Supabase.

### 12.4 Giai đoạn kiểm thử và nghiệm thu

- Kiểm tra luồng đăng nhập.
- Kiểm tra phân quyền theo vai trò.
- Kiểm tra dữ liệu khách hàng, Kanban, công việc, thanh toán.
- Kiểm tra import/export CSV.
- Kiểm tra dashboard và biểu đồ.
- Chạy nghiệm thu cùng đại diện doanh nghiệp.

## 13. Kết luận định hướng sản phẩm

CRM giai đoạn 1 cho Công ty Yến Sào Vĩnh Hưng cần được xây dựng như một công cụ vận hành thực tế, ưu tiên tính rõ ràng, tập trung, dễ dùng và có thể triển khai nhanh trong môi trường bán hàng thật. Trọng tâm của sản phẩm không nằm ở việc có thật nhiều tính năng, mà nằm ở khả năng giúp doanh nghiệp quản lý khách hàng tốt hơn, nhìn được tiến độ bán hàng rõ hơn, giao việc sát hơn, kiểm soát thanh toán thuận tiện hơn và bảo vệ dữ liệu chặt chẽ hơn.

Nếu triển khai đúng theo PRD này, hệ thống sẽ tạo ra nền tảng đủ vững cho doanh nghiệp trong giai đoạn đầu và sẵn sàng mở rộng sang các lớp chức năng sâu hơn ở giai đoạn tiếp theo.
