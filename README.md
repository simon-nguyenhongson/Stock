# Stock — Skill briefing sáng chứng khoán & vàng Việt Nam

Skill `/briefing` cho [Claude Code](https://claude.com/claude-code), viết theo chuẩn **Agent Skills** của Anthropic: đọc danh mục từ `DANH_MUC.md`, thu thập tin tức + giá thị trường + giá vàng, lấy BCTC quý gần nhất từ 24HMoney, tính P&L và khoảng cách stop-loss/target, rồi sinh báo cáo `briefing.html`.

## Cài đặt

1. Copy `.claude/` và `CLAUDE.md` vào thư mục làm việc.
2. Điền danh mục của bạn vào `Stock_Briefing_Package/DANH_MUC_TEMPLATE.md`, đổi tên thành `DANH_MUC.md`, đặt cùng thư mục.
3. Mở session Claude Code mới rồi gõ `/briefing`.

Hướng dẫn đầy đủ (kèm cách dùng với Claude.ai Projects, Antigravity, Cursor, Windsurf): [Stock_Briefing_Package/HUONG_DAN_CAI_DAT_VA_SU_DUNG.md](Stock_Briefing_Package/HUONG_DAN_CAI_DAT_VA_SU_DUNG.md).

## Cấu trúc skill

```text
.claude/skills/briefing/
├── SKILL.md                        # Quy trình 6 bước
├── references/data-sources.md      # Quy tắc tra giá, BCTC 24HMoney, vàng, công thức P&L
├── references/report-spec.md       # Cấu trúc 7 mục HTML, quy tắc class & bảng
└── assets/briefing-template.html   # Template báo cáo kèm design system
```

## Miễn trừ trách nhiệm

Báo cáo do skill sinh ra là **thông tin tham khảo cá nhân, không phải khuyến nghị đầu tư**. Số liệu tổng hợp từ nguồn công khai và có thể sai lệch so với sàn. Dữ liệu danh mục trong repo này là của cá nhân chủ repo, không liên quan tới bất kỳ tổ chức nào.
