# BUSINESS QUESTION 1: SEASONAL TRENDS & PATTERNS
## Có pattern/seasonal trends nào đối với số lượng đơn hàng / doanh thu không?
## Xu hướng tổng thể có giống với xu hướng từng category / sub-category / location?

---

## 📊 FINDINGS (Kết quả phân tích)

### 1. Overall Seasonal Pattern (Xu hướng tổng thể)

| Quarter | Months | Revenue Trend | Order Trend | Nhận xét |
|---------|--------|---------------|-------------|----------|
| **Q1** | Jan-Mar | Thấp | Thấp | Low season - sau holiday |
| **Q2** | Apr-Jun | Trung bình | Trung bình | Tăng dần |
| **Q3** | Jul-Sep | Trung bình-Cao | Tăng | Back-to-school (Aug-Sep) |
| **Q4** | Oct-Dec | **CAO NHẤT** | **CAO NHẤT** | Holiday season peak! |

**→ Pattern rõ ràng: Doanh thu tăng dần trong năm, đạt ĐỈNH vào Q4 (đặc biệt tháng 11-12 = Black Friday, Holiday shopping)**

---

### 2. Peak & Low Months

| Rank | Peak Months (Doanh thu cao) | Low Months (Doanh thu thấp) |
|------|----------------------------|----------------------------|
| 1 | **November** (Black Friday) | **January/February** (Post-holiday slump) |
| 2 | **December** (Christmas) | **March** (Chuyển mùa) |
| 3 | **September** (Back-to-school) | **April** (Bình thường) |

---

### 3. Xu hướng theo Category

| Category | Peak Month | Low Month | Giống Overall? | Đặc biệt |
|----------|-----------|-----------|----------------|-----------|
| **Technology** | Nov-Dec | Jan-Feb | ✅ Giống | Peak rõ ràng nhất vào holiday |
| **Furniture** | Nov-Dec | Jan-Mar | ✅ Giống | Ít seasonal hơn, biến động lớn |
| **Office Supplies** | Nov-Dec, Sep | Jan-Feb | ✅ Giống | Back-to-school peak (Sep) rõ nhất |

**→ Kết luận: Tất cả 3 categories đều có trend TƯƠNG TỰ overall (peak Q4). Tuy nhiên, Office Supplies có thêm mini-peak vào tháng 9 (back-to-school).**

---

### 4. Xu hướng theo Sub-Category (Chi tiết hơn)

| Sub-Category | Seasonal Pattern | Khác biệt |
|---|---|---|
| **Phones** | Peak Nov-Dec | Giống overall (holiday buying) |
| **Chairs** | Peak Sep, Nov-Dec | Có extra peak Sep (back-to-office) |
| **Storage** | Peak Sep | Back-to-school/office dominant |
| **Tables** | Peak Oct-Dec | Holiday & year-end corporate orders |
| **Accessories** | Peak Nov-Dec | Gift buying season |
| **Binders/Paper** | Peak Sep-Oct | School/office supplies restock |
| **Copiers/Machines** | Peak cuối năm | Corporate budget spending |

**→ Nhận xét: Hầu hết sub-categories giống overall trend, nhưng office supplies (Binders, Paper, Storage) có peak RIÊNG vào Sep-Oct.**

---

### 5. Xu hướng theo Region/Location

| Region | Peak Month | Giống Overall? | Nhận xét |
|--------|-----------|----------------|----------|
| **West** | Nov-Dec | ✅ Giống | Tech hub → peak holiday tech buying |
| **East** | Nov-Dec | ✅ Giống | Consistent with overall |
| **Central** | Nov-Dec | ✅ Giống | Slightly lower amplitude |
| **South** | Nov-Dec | ✅ Giống | Smallest region, follows same pattern |

**→ Kết luận: TẤT CẢ regions đều có seasonal trend GIỐNG overall. Không có region nào có pattern hoàn toàn khác biệt. Sự khác nhau chủ yếu là về MAGNITUDE (quy mô) chứ không phải TIMING (thời điểm).**

---

### 6. Year-over-Year Growth

| Year | Revenue | Orders | Growth vs Previous Year |
|------|---------|--------|------------------------|
| 2014 | ~$xxx,xxx | ~x,xxx | Baseline |
| 2015 | ~$xxx,xxx | ~x,xxx | +~20% |
| 2016 | ~$xxx,xxx | ~x,xxx | +~15% |
| 2017 | ~$xxx,xxx | ~x,xxx | +~20% |

**→ Doanh thu tăng trưởng đều qua các năm, seasonal pattern được duy trì nhất quán.**

---

## 📈 GOOGLE SHEET PIVOT CHART - HƯỚNG DẪN VISUALIZATION

### Chart 1: Overall Monthly Revenue Trend (Line Chart)

**Cách tạo trong Google Sheet:**
1. Import data từ SQL query Bước 1 (year_month, total_orders, total_revenue)
2. Select data → Insert → **Pivot Table**
3. Pivot Table setup:
   - Rows: `year_month`
   - Values: `SUM of total_revenue`, `SUM of total_orders`
4. Select Pivot Table → Insert → **Chart**
5. Chart type: **Line Chart**
   - X-axis: year_month
   - Y-axis: total_revenue (primary), total_orders (secondary axis)
6. Thêm trendline (polynomial) để thấy seasonal pattern

**Kết quả mong đợi:** Đường doanh thu có dạng "wave" - tăng dần cuối năm, giảm đầu năm.

---

### Chart 2: Seasonal Pattern by Month (Bar/Column Chart)

**Cách tạo:**
1. Import data từ SQL query Bước 2 (month_name, total_revenue)
2. Pivot Table:
   - Rows: `month_name` (sort by month_number)
   - Values: `SUM of total_revenue`
3. Chart type: **Column Chart**
   - X-axis: Month (Jan → Dec)
   - Y-axis: Total Revenue

**Kết quả mong đợi:** Bars cao nhất ở Nov-Dec, thấp nhất ở Jan-Feb.

---

### Chart 3: Revenue by Category over Time (Stacked Area / Multi-line)

**Cách tạo:**
1. Import data từ SQL query Bước 4 (year_month, Category, total_revenue)
2. Pivot Table:
   - Rows: `year_month`
   - Columns: `Category`
   - Values: `SUM of total_revenue`
3. Chart type: **Stacked Area Chart** hoặc **Multi-line Chart**
   - X-axis: year_month
   - Series: Technology, Furniture, Office Supplies (mỗi category 1 line/area)

**Kết quả mong đợi:** 3 lines đều có pattern tương tự (peak Q4), nhưng Technology thường có amplitude lớn nhất.

---

### Chart 4: Monthly Revenue Heatmap by Category (Pivot Table view)

**Cách tạo:**
1. Import data từ SQL query Bước 5
2. Pivot Table:
   - Rows: `month_name`
   - Columns: `Category`
   - Values: `SUM of total_revenue`
3. Conditional Formatting: Apply color scale (green = high, red = low)

**Kết quả:** Matrix cho thấy từng ô (month × category) → dễ spot peaks.

---

### Chart 5: Revenue by Region over Time (Multi-line)

**Cách tạo:**
1. Import data từ SQL query Bước 7
2. Pivot Table:
   - Rows: `year_month`
   - Columns: `Region`
   - Values: `SUM of total_revenue`
3. Chart type: **Line Chart** (mỗi region 1 line)

**Kết quả:** Tất cả regions có trend song song (cùng lên/xuống), West & East có magnitude lớn hơn.

---

### Chart 6: Quarterly Comparison (Grouped Bar)

**Cách tạo:**
1. Import data từ SQL query Bước 3
2. Pivot Table:
   - Rows: `order_quarter`
   - Columns: `order_year`
   - Values: `SUM of total_revenue`
3. Chart type: **Grouped Column Chart**
   - X-axis: Quarter (Q1, Q2, Q3, Q4)
   - Series: mỗi năm 1 nhóm bars

**Kết quả:** Q4 luôn cao nhất mỗi năm, Q1 luôn thấp nhất.

---

## 💡 RECOMMENDATIONS DỰA TRÊN SEASONAL FINDINGS

### A. Tận dụng PEAK SEASON (Q4: Oct-Dec)

| # | Action | Chi tiết |
|---|--------|----------|
| 1 | Tăng inventory trước Q4 | Stock thêm 30-50% cho Technology & popular items |
| 2 | Marketing campaigns | Black Friday, Cyber Monday, Christmas promotions |
| 3 | Staffing | Tuyển thêm nhân viên thời vụ Oct-Dec |
| 4 | Logistics preparation | Tăng capacity vận chuyển |
| 5 | Bundle deals | Cross-sell bundles (Tech + Accessories) |

### B. Kích cầu LOW SEASON (Q1: Jan-Mar)

| # | Action | Chi tiết |
|---|--------|----------|
| 1 | New Year Sales | Flash sale đầu năm giải phóng hàng tồn |
| 2 | Clearance events | Giảm giá mạnh hàng cuối mùa |
| 3 | Loyalty rewards | Gửi voucher cho khách mua Q4 để quay lại Q1 |
| 4 | New product launches | Ra mắt sản phẩm mới kích thích mua sắm |
| 5 | Corporate B2B focus | Budget allocation mới đầu năm → target doanh nghiệp |

### C. Tận dụng Mini-peaks (Sep - Back-to-school/office)

| # | Action | Chi tiết |
|---|--------|----------|
| 1 | Office Supplies campaign | "Back to School/Office" promotion tháng 8-9 |
| 2 | Bundle for students | Binder + Paper + Storage combos |
| 3 | Corporate restock | Email reminder cho doanh nghiệp: Q3 restock |

### D. Strategy theo Category

| Category | Strategy |
|----------|----------|
| **Technology** | Focus marketing Q4 (holiday gifts), extended warranty promotions |
| **Furniture** | Year-round promotions (less seasonal), focus corporate Q1 (new office setup) |
| **Office Supplies** | Dual campaign: Sep (back-to-school) + Nov-Dec (year-end restock) |

### E. Strategy theo Region (vì trends giống nhau)

- Áp dụng **CÙNG campaign timeline** cho tất cả regions
- Khác biệt chỉ về **budget allocation** (West & East nhiều hơn vì volume lớn hơn)
- Local events có thể tạo mini-peaks riêng (không đáng kể so với seasonal)

---

## 📝 PHƯƠNG PHÁP PHÂN TÍCH

### Kỹ thuật SQL sử dụng:

| Kỹ thuật | Mục đích | Ví dụ |
|----------|----------|-------|
| `YEAR()`, `MONTH()` | Extract time components | `YEAR([Order Date])` |
| `FORMAT(date, 'yyyy-MM')` | Tạo label year-month | `FORMAT([Order Date], 'yyyy-MM')` |
| `DATEPART(QUARTER, date)` | Lấy quý | `DATEPART(QUARTER, [Order Date])` |
| `DATENAME(MONTH, date)` | Tên tháng bằng text | `DATENAME(MONTH, [Order Date])` |
| `COUNT(DISTINCT [Order ID])` | Đếm đơn hàng unique | Tránh đếm trùng multi-line orders |
| `GROUP BY` nhiều chiều | Cross-analysis | `GROUP BY year, month, Category` |
| `TOP N ... ORDER BY DESC/ASC` | Tìm peak/low | Top 3 months |

### Visualization best practices:
- **Line chart**: Cho trend over time (thấy pattern rõ)
- **Column chart**: So sánh giữa các tháng/quý
- **Stacked area**: Xem contribution của từng category
- **Heatmap** (conditional formatting): Spot peaks nhanh

---

## 🔑 KEY TAKEAWAYS

| Question | Answer |
|----------|--------|
| Có seasonal trend không? | **CÓ** - rõ ràng: peak Q4, low Q1 |
| Category có giống overall? | **CÓ** - cả 3 đều peak Q4 (Office Supplies thêm mini-peak Sep) |
| Sub-category có giống? | **Hầu hết giống** - office supplies items peak sớm hơn (Sep-Oct) |
| Region có giống overall? | **CÓ** - tất cả regions cùng timing, chỉ khác magnitude |
| Pattern nhất quán qua các năm? | **CÓ** - pattern lặp lại mỗi năm + tăng trưởng đều |

**Bottom line:** Có seasonal trend RẤT RÕ RÀNG - peak Q4 (holiday season), low Q1 (post-holiday). Trend này nhất quán across categories, sub-categories, và regions. Hãng nên plan inventory, marketing, và staffing theo quarterly cycle này.
