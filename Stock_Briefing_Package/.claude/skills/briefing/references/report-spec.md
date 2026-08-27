# Đặc tả báo cáo `briefing.html`

Xuất phát từ `assets/briefing-template.html`. Giữ nguyên CSS trong template — không đổi màu, font, layout.

## Quy tắc độ dài — BẮT BUỘC, ưu tiên cao nhất

Báo cáo là **bảng tra cứu nhanh, không phải bài phân tích**. Người dùng cần quét mắt ra quyết định trong 30 giây.

| Thành phần | Giới hạn cứng |
|---|---|
| Mỗi `<li>` | **1 dòng, ≤ 20 từ.** Dài hơn → chuyển thành bảng hoặc cắt bỏ |
| Mỗi khối `<h3>` / `div.warn` / `div.info` | **≤ 4 bullet** |
| Cột `Ghi chú` / `Chiến lược` trong bảng | **≤ 20 từ**, dạng nhãn + số (`Vi phạm stop −6.6%. KL mỏng 236k → chia nhỏ lệnh.`) |
| Accordion `<details>` | **≤ 3 `<li>`**, mỗi cái 1 dòng |
| `div.summary` — 3 điểm chính | **1 dòng mỗi điểm** |
| `div.summary` — hành động | **Dạng bảng** `Mã \| Việc \| Ngưỡng`, không phải `ul` lồng |
| Mục "không tra được" | **Một dòng liệt kê phẩy**, không phải danh sách |

Quy tắc viết:

- **Số liệu chỉ nằm trong bảng.** Không nhắc lại số đã có trong bảng ở phần diễn giải.
- **Một dữ kiện xuất hiện đúng một lần** trong toàn báo cáo. Không lặp giữa Mục 1 / Mục 4 / Mục 5.
- **Không viết lời dẫn, chuyển ý, hay giải thích bối cảnh.** Vào thẳng dữ kiện.
- **Gộp "đánh giá tác động" thành một cột `Tác động` trong bảng** thay vì viết thành `ul` riêng.
- **Cắt, không rút gọn.** Thông tin không đổi được quyết định hôm nay thì bỏ hẳn.
- Đính chính bản trước: **1 dòng mỗi lỗi**, dạng `Mục: số cũ → số đúng. Hệ quả.`

## Cấu trúc 7 mục

1. **Header** — `<h1>📋 <span class="gradient-text">…</span></h1>`, `div.nav-bar` (NAV, tiền mặt, P&L, ngày/giờ cập nhật), `div.disclaimer`.
2. **Mục 1 — Tin tức**: `h2` → `h3` (Vĩ mô / Việt Nam / Liên quan danh mục) → `ul>li`.
3. **Mục 2 — Thế giới & hàng hoá**: bảng chỉ số + `h3` đánh giá tác động → `ul>li`.
4. **Mục 2b — Vàng Việt Nam**: bảng giá (SJC miếng + nhẫn) và bảng vùng mua/bán dự kiến + phân tích xu hướng, rủi ro dạng `ul>li`.
5. **Mục 3 — Giá & P&L**: ba bảng — danh mục nắm giữ, chiến lược bán & quản trị rủi ro, watchlist & chiến lược mua.
6. **Mục 4 — Cảnh báo**: `div.warn` / `div.info` cho từng mã, gồm cả cảnh báo vàng.
7. **Mục 5 — Tóm tắt**: `div.summary` chứa `ol` 3 điểm chính + `ul` hành động (cho phép `ul` lồng cấp 2).

## Quy tắc class

| Trường hợp | Dùng |
|---|---|
| Số tăng / giảm | `<span class="up">`, `<span class="down">` |
| Cảnh báo stop-loss, rủi ro cao | `<div class="warn"><div class="warn-title">…</div>…</div>` |
| Thông tin trung tính | `<div class="info">` |
| Tóm tắt / hành động | `<div class="summary"><div class="summary-title">…</div>…</div>` |
| Trạng thái mã | `tag-hold` (đang giữ), `tag-strategy` (chiến lược mua), `tag-watch` (watchlist), `tag-gold` (vàng), `tag-buy` (kích hoạt mua) |

- **Mọi `<table>` phải bọc trong `<div class="table-container">`.**
- Dòng tổng: `<tr style="background: #f1f5f9; font-weight: bold;">`.

## Bảng bắt buộc

**Danh mục nắm giữ** — `Mã | SL | Giá vốn | Giá TT | P&L | LNST quý gần nhất (%YoY) | Ngành | Ghi chú`.

**Chiến lược bán & Quản trị rủi ro** — `Mã | Cách stop-loss | Giá TT | Giá vốn | LNST Qx | Stop-loss | Target | Biên kỳ vọng | Chiến lược`.

**Danh sách theo dõi & Chiến lược mua** — `Mã | Trạng thái | FTSE | Giá TT | LNST Qx | Stop | Target | Điều kiện kích hoạt mua`.

- Cột `LNST Qx`: gộp `xxx tỷ (+xx%)` trong một ô; tiêu đề ghi đúng quý thực tế.
- Cột `Stop` / `Target`: giá trị số kèm % so với Giá TT — `xx.xx <span class="up" style="font-size:12px">(+xx.xx%)</span>`; `.up` nếu cao hơn Giá TT, `.down` nếu thấp hơn.
- **Không bao giờ để `n/a` ở cột `Stop` / `Target`.** Mã nào thiếu thì tự lập ngưỡng theo mục "Khi dữ liệu thiếu" trong `SKILL.md`, ghi vào `DANH_MUC.md`, rồi mới điền vào bảng — kèm chú thích ngắn là ngưỡng do skill tự lập.
- Cột `Điều kiện kích hoạt mua` đặt **cuối cùng**, dùng accordion:
  ```html
  <details open><summary>Tiêu đề</summary><ul><li>Tranche 1 …</li></ul></details>
  ```

## Tên file

Luôn là `briefing.html` tại thư mục làm việc, ghi đè bản cũ để đường dẫn không đổi.
