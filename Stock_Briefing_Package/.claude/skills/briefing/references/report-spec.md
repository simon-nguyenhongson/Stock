# Đặc tả báo cáo `briefing.html`

Xuất phát từ `assets/briefing-template.html`. Giữ nguyên CSS trong template — không đổi màu, font, layout.

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
- Cột `Điều kiện kích hoạt mua` đặt **cuối cùng**, dùng accordion:
  ```html
  <details open><summary>Tiêu đề</summary><ul><li>Tranche 1 …</li></ul></details>
  ```

## Tên file

Luôn là `briefing.html` tại thư mục làm việc, ghi đè bản cũ để đường dẫn không đổi.
