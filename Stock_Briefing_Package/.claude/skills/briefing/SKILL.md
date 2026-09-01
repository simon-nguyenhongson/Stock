---
name: briefing
description: Chạy briefing cho danh mục chứng khoán cá nhân và vàng Việt Nam — đọc DANH_MUC.md, thu thập tin tức và giá thị trường mới nhất, lấy BCTC quý gần nhất từ 24HMoney, tính P&L cùng khoảng cách stop-loss/target, xuất báo cáo briefing.html và mở trên trình duyệt. Dùng khi người dùng gọi /briefing, yêu cầu "chạy briefing", "báo cáo danh mục", "cập nhật giá cổ phiếu và vàng", hoặc hỏi về tình trạng danh mục đầu tư cá nhân của họ. Đây là danh mục cá nhân, KHÔNG phải dữ liệu ngân hàng.
---

# Briefing — Danh mục chứng khoán & vàng Việt Nam

Toàn bộ báo cáo viết bằng **tiếng Việt có dấu**. Đầu báo cáo ghi rõ ngày **và giờ** chạy.

Skill chạy được ở bất kỳ thời điểm nào trong ngày — **không giả định là buổi sáng**. Xác định thời điểm chạy rồi ghi rõ trong báo cáo giá đang dùng là loại nào:

- Trước 09:00 → giá **đóng cửa phiên gần nhất**.
- 09:00–14:45 → giá **trong phiên** (ghi rõ mốc giờ lấy giá).
- Sau 14:45 → giá **đóng cửa phiên hôm nay**.

## Nguồn dữ liệu — thứ tự ưu tiên

**Bước 0: kiểm tra MCP môi giới trước khi tra web.** Workspace có cấu hình MCP TCBS (`tcbs`, xem `.mcp.json`) — đây là tài khoản môi giới thật của người dùng.

1. **Ưu tiên 1 — MCP `tcbs` nếu đã kết nối.** Đầu mỗi lần chạy, dùng `ToolSearch` với query `+tcbs` để xem MCP có tool nào. Có tool đọc được giá / vị thế / số dư thì **dùng nó thay cho web** cho đúng phần dữ liệu đó. Ghi trong báo cáo là nguồn TCBS kèm mốc giờ.
2. **Ưu tiên 2 — web** (24HMoney, CafeF, Vietstock, Investing.com) cho phần MCP không có: tin tức, chỉ số thế giới, hàng hoá, giá vàng, BCTC.
3. **MCP chưa kết nối** (`Pending approval`, chưa đăng nhập OAuth, hoặc `ToolSearch` không trả tool nào) → chạy hoàn toàn bằng web như cũ, và **nói rõ trong báo cáo là chưa dùng được TCBS** để người dùng biết mà đi đăng nhập.

Quy tắc khi có cả hai nguồn:

- **Số lượng và giá vốn: MCP thắng `DANH_MUC.md`.** Đây là dữ liệu tài khoản thật. Lệch nhau → lấy theo MCP, cập nhật `DANH_MUC.md`, và **báo rõ cho người dùng chỗ nào lệch bao nhiêu** (thường là do giao dịch chưa ghi vào file).
- **Giá thị trường: MCP thắng web** vì là giá sàn thật, không qua trung gian.
- **Tuyệt đối không im lặng ghi đè.** Mọi lần MCP làm đổi số trong `DANH_MUC.md` đều phải liệt kê ra trong phần báo lại.
- **Không gọi tool giao dịch.** Nếu MCP có tool đặt/sửa/hủy lệnh hoặc chuyển tiền, briefing **chỉ đọc, không bao giờ gọi những tool đó** — kể cả khi báo cáo đang đề xuất mua/bán. Quyết định đặt lệnh là của người dùng.

## Nguyên tắc bắt buộc

1. **`DANH_MUC.md` là nguồn dữ liệu duy nhất.** Không hardcode mã cổ phiếu, giá vốn, số lượng, stop-loss, target hay vùng giá vàng. File đổi → báo cáo phải tự đổi theo.
2. **Không bịa số.** Nếu không tìm được giá của một mã, ghi rõ "không tra được" thay vì suy đoán hoặc dùng số cũ.
3. **Tách riêng truy vấn từng mã.** Không gộp nhiều mã vào một lần search.
4. **VIẾT CỰC GỌN.** Báo cáo là bảng tra cứu nhanh, không phải bài phân tích. Mỗi `<li>` tối đa **1 dòng ≤20 từ**; mỗi khối tối đa **4 bullet**; mọi số liệu nằm trong `<table>` và **không nhắc lại** ở phần diễn giải; một dữ kiện xuất hiện **đúng một lần** trong toàn báo cáo. Không lời dẫn, không chuyển ý. Giới hạn chi tiết: [references/report-spec.md](references/report-spec.md) — mục "Quy tắc độ dài".
5. **Đây là thông tin tham khảo, không phải khuyến nghị đầu tư** — luôn giữ `div.disclaimer` ở đầu báo cáo.

## Quy trình

Tạo todo list 6 bước dưới đây rồi thực hiện tuần tự.

### Bước 1 — Đọc danh mục (làm trước tiên)

Đọc `DANH_MUC.md` ở thư mục làm việc hiện tại. Nếu không có, thử `D:\0.Work\Others\Stock\DANH_MUC.md`; vẫn không có thì hỏi người dùng cung cấp file.

Trích ra: mã **đang nắm giữ** (SL > 0), mã trong **chiến lược mua**, mã trong **watchlist**, mã **đã loại**, giá vốn / SL / stop-loss / target từng mã, tiền mặt khả dụng, NAV, và phần **vàng** (vùng mua/bán dự kiến, ghi chú chiến lược).

### Bước 2 — Tin tức & thị trường thế giới

- Tin tức mới nhất tính tới thời điểm chạy, ảnh hưởng tới **tất cả** mã trong danh mục + chiến lược + watchlist (CafeF, Vietstock, Investing.com và các trang tin uy tín trong nước).
- Chỉ số thế giới: Dow Jones, S&P 500, Nasdaq, Nikkei, KOSPI, Thượng Hải, Hang Seng.
- Hàng hoá & tỷ giá: thép HRC/thép xây dựng, dầu WTI, DXY, USD/VND, XAU/USD.
- Đánh giá tác động tới từng mã theo ngành ghi trong `DANH_MUC.md`.

### Bước 3 — Vàng Việt Nam

Giá SJC miếng 1 lượng và nhẫn trơn 9999 (SJC, DOJI, PNJ, Bảo Tín Minh Châu), XAU/USD spot, chênh lệch SJC vs thế giới quy đổi, xu hướng gần nhất. Đưa ra vùng mua và vùng bán dự kiến; nếu `DANH_MUC.md` có vùng chiến lược thì so sánh và cảnh báo khi gần trigger.

### Bước 4 — Giá thị trường, BCTC & P&L

Chi tiết quy tắc thu thập và kiểm chứng: đọc [references/data-sources.md](references/data-sources.md).

Ngắn gọn: lấy giá khớp lệnh mới nhất (hoặc giá đóng cửa phiên gần nhất nếu ngoài giờ) cho từng mã; lấy "Lợi nhuận của Cổ đông của Công ty mẹ" quý gần nhất + %YoY từ `24hmoney.vn/stock/{MÃ}/financial-report`; tính P&L từng mã theo giá vốn × SL; tính khoảng cách % tới stop-loss và biên tăng kỳ vọng tới target.

### Bước 5 — Cảnh báo & tóm tắt

- Cảnh báo mã chạm/gần **stop-loss** hoặc **target**, mã trong chiến lược mua gần **trigger kích hoạt**, và cảnh báo vàng nếu có.
- Mọi mã đều phải có đủ Stop-loss/Target trước khi tới bước này — thiếu thì quay lại tự lập theo mục "Khi dữ liệu thiếu". Không có mã nào được để trống ô rủi ro trong báo cáo.
- Tóm tắt 1 trang: 3 điểm chính + hành động đề xuất cho phiên gần nhất kế tiếp.

### Bước 6 — Xuất báo cáo, đẩy lên git & trình cho người dùng

1. Sinh `briefing.html` tại thư mục làm việc (ghi đè file cũ để đường dẫn cố định). Bắt đầu từ [assets/briefing-template.html](assets/briefing-template.html) — template đã chứa sẵn đúng CSS design system, **không tự đổi màu/font/layout**. Cấu trúc 7 mục và quy tắc bảng: [references/report-spec.md](references/report-spec.md).
2. Cập nhật `DANH_MUC.md`: giá TT mới, mốc thời gian cập nhật, **mọi Stop-loss/Target vừa tự lập theo mục "Khi dữ liệu thiếu"**, và thêm một dòng vào bảng nhật ký kiểm tra trigger (nếu file có bảng này).

   **Nhật ký trigger phải NGẮN — tối đa 5 gạch đầu dòng, mỗi dòng ≤25 từ.** Chỉ ghi: P&L tổng + mức đổi · mã vi phạm stop · trigger vừa kích hoạt · đính chính lần trước (nếu có) · `n/a` liệt kê phẩy. **Không chép lại tin tức, chỉ số thế giới, giá vàng hay BCTC vào đây** — những thứ đó đã nằm trong `briefing.html`. Cột "Ghi chú" của các bảng cũng theo giới hạn ≤20 từ như báo cáo.
3. Cập nhật/tạo `open_briefing.bat` cạnh báo cáo:
   ```bat
   @echo off
   set "SCRIPT_DIR=%~dp0"
   start "" "%SCRIPT_DIR%briefing.html"
   ```
4. Mở báo cáo: `powershell -Command "Start-Process '<đường dẫn tuyệt đối>\briefing.html'"` (mở bằng trình duyệt mặc định — không phụ thuộc Chrome đã cài).
5. **Commit & push toàn bộ kết quả lên git — bắt buộc, không hỏi lại.** Mỗi lần chạy xong đều đẩy lên remote để báo cáo không bị mất và để routine chạy trên máy khác luôn thấy bản mới nhất.

   ```bash
   git add -A
   git commit -m "Briefing DD/MM/YYYY HH:MM — <1 dòng ≤12 từ về diễn biến chính>"
   git push origin HEAD
   ```

   Quy tắc an toàn khi push:

   - Thư mục không phải git repo, hoặc `git remote -v` rỗng → **bỏ qua bước này**, ghi một dòng trong phần báo lại. Không tự `git init`, không tự thêm remote.
   - Không có gì thay đổi (`git status` sạch) → bỏ qua, không tạo commit rỗng.
   - Push bị từ chối vì remote đi trước → `git pull --rebase origin HEAD` rồi push lại một lần.
   - **Tuyệt đối không `git push --force`, không `git reset --hard`, không xoá hay sửa commit đã có.** Push thất bại hai lần → dừng, giữ nguyên commit ở local, báo rõ lý do cho người dùng để họ xử lý tay.
   - Chỉ commit trên nhánh đang làm việc. Không tự tạo nhánh, không tự merge.
6. Báo lại cho người dùng đường dẫn file + 3 điểm chính, kèm danh sách dữ liệu nào không tra được (nếu có), mọi Stop-loss/Target vừa tự lập, và **mã commit vừa push** (hoặc lý do không push được).

## Khi dữ liệu thiếu

Phân biệt hai loại dữ liệu thiếu — xử lý khác nhau:

### Loại 1 — Dữ liệu chỉ người dùng biết → hỏi

Giá vốn, số lượng, tiền mặt: đây là dữ kiện giao dịch thật, **không được suy ra**. Vẫn làm đủ bước 2, 3, 5, 6; bỏ phần P&L của mã đó; nhắc người dùng bổ sung đúng ô còn trống.

### Loại 2 — Stop-loss / Target thiếu → TỰ LẬP, KHÔNG HỎI

Nếu một mã trong danh mục nắm giữ / chiến lược mua / watchlist chưa có Stop-loss hoặc Target: **tự lập ngưỡng, ghi thẳng vào `DANH_MUC.md`, rồi báo lại cho người dùng biết đã đặt gì và vì sao.** Tuyệt đối không để trống rồi nhắc người dùng tự điền — thiếu ngưỡng thì không tính được biên rủi ro, cả mã đó bị loại khỏi mọi quyết định, và lỗi này sẽ lặp lại ở mọi lần chạy sau.

Cách lập:

1. **Stop-loss** — ưu tiên mốc kỹ thuật, không phải số tròn tùy ý:
   - Có hỗ trợ xác nhận gần (đáy 52 tuần, nền giá vừa tạo, đáy nhịp trước) → đặt tại/ngay dưới mốc đó.
   - Không có mốc gần → dùng biên rủi ro theo đặc tính mã: **6–8%** cho large-cap phòng thủ/beta thấp, **10–15%** cho mid/small-cap hoặc beta cao. Nói rõ đây là ngưỡng theo biên rủi ro, chưa phải hỗ trợ đã xác nhận.
   - Mã đang sát đáy 52 tuần → thêm `hard stop` dưới đáy để tách nhiễu khỏi phá vỡ thật.
2. **Target** — lấy từ dữ liệu ngoài, không tự nghĩ ra:
   - Dải giá mục tiêu của các CTCK, **tối thiểu 2 nguồn**, ghi rõ tên CTCK + ngày báo cáo. Bỏ báo cáo cũ nếu đã có bản cập nhật sau đó.
   - Hoặc kháng cự đỉnh 52 tuần khi không có báo cáo nào.
   - Ghi dạng dải `thấp – cao`, không phải một con số.
3. **Kiểm tra risk/reward bắt buộc:** R:R tính trên target **thấp nhất** phải `≥ 2:1`. Không đạt → siết stop lại hoặc ghi rõ trong ô ghi chú là "R:R chưa đủ, chưa giải ngân".
4. **Ghi lại căn cứ** ngay trong cột "Quy tắc đặc biệt" của bảng Stop-loss & Target: mốc kỹ thuật đã dùng, nguồn target, R:R. Đánh dấu rõ đây là ngưỡng **skill tự lập** để người dùng biết mà chỉnh.
5. Nếu tiền mặt khả dụng quá nhỏ so với giá mã đó, tính luôn số cổ phiếu mua được và mức lỗ tối đa tại stop — để người dùng thấy vị thế có đáng mở hay không.
