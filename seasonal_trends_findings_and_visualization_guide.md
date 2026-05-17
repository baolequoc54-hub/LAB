# BUSINESS QUESTION: SEASONAL TRENDS & PATTERNS
## Database: Retail Sales (Sales, Products, Stores, Customers, Exchange_Rates)

---

## 📊 FINDINGS (Kết quả phân tích)

### 1. Overall Seasonal Pattern

| Quarter | Months | Revenue Trend | Nhận xét |
|---------|--------|---------------|----------|
| **Q4** | Oct-Dec | **CAO NHẤT** | Holiday season (Black Friday, Christmas) |
| **Q3** | Jul-Sep | Trung bình-Cao | Back-to-school |
| **Q2** | Apr-Jun | Trung bình | Tăng dần |
| **Q1** | Jan-Mar | **Thấp nhất** | Post-holiday slump |

**→ Pattern rõ ràng: Peak Q4, Low Q1. Lặp lại hàng năm.**

---

### 2. Peak & Low Months

| Rank | Peak Months | Low Months |
|------|-------------|------------|
| 1 | **December** (Christmas) | **January** (Post-holiday) |
| 2 | **November** (Black Friday) | **February** |
| 3 | **September** (Back-to-school) | **March** |

---

### 3. Xu hướng theo Category - Có giống Overall không?

| Category | Peak Period | Giống Overall? | Đặc biệt |
|----------|-----------|----------------|-----------|
| Computers | Nov-Dec | ✅ Giống | Gift buying, year-end upgrades |
| Cell Phones | Nov-Dec | ✅ Giống | Holiday promotions |
| Home Appliances | Nov-Dec + Jun | ⚠️ Gần giống | Thêm mini-peak mùa hè (moving season) |
| Music, Movies, Audiobooks | Nov-Dec | ✅ Giống | Gift season dominant |
| TV and Video | Nov-Dec | ✅ Giống | Black Friday deals |
| Cameras and camcorders | Nov-Dec | ✅ Giống | Holiday/travel season |
| Games and Toys | **Nov-Dec rất mạnh** | ✅ Giống | Christmas gift peak rõ nhất |

**→ Kết luận: Hầu hết categories follow overall trend (peak Q4). Một số categories có mini-peaks riêng nhưng không đáng kể.**

---

### 4. Xu hướng theo Subcategory

| Subcategory | Pattern riêng | Nhận xét |
|-------------|--------------|----------|
| Desktops, Laptops | Peak Nov-Dec | Year-end corporate purchasing + gifts |
| Smartphones | Peak Nov-Dec | Flagship releases + holiday |
| Washing Machines, Refrigerators | Peak Jun + Nov | Moving season (Jun) + Black Friday |
| Movie DVD, Music | Peak Dec | Christmas gift |
| Televisions | Peak Nov | Black Friday dominant |
| Lamps, Projectors | Flat/ít seasonal | Nhu cầu đều quanh năm |

---

### 5. Xu hướng theo Location (Country)

| Observation | Chi tiết |
|-------------|----------|
| Xu hướng chung | Hầu hết countries peak Q4 (Nov-Dec) |
| Northern Hemisphere | Rõ ràng holiday peak Q4 |
| Australia (Southern) | Có thể khác chút vì mùa ngược |
| Khác biệt chính | Về magnitude (quy mô) chứ không phải timing |

**→ Kết luận: Locations có seasonal trend TƯƠNG TỰ overall. Khác biệt chủ yếu do quy mô thị trường.**

---

## 📈 GOOGLE SHEET PIVOT CHART - HƯỚNG DẪN

### Chart 1: Line Chart - Overall Monthly Revenue Trend

**Dữ liệu:** Kết quả Bước 1 (year_month, total_revenue, total_orders)

**Tạo Pivot Table:**
```
Rows:     year_month
Values:   SUM of total_revenue
          SUM of total_orders
```

**Chart:** Line Chart
- X-axis: year_month
- Y-axis (trái): total_revenue
- Y-axis (phải): total_orders (secondary axis)
- Thêm Trendline → thấy growth + seasonal wave

---

### Chart 2: Column Chart - Seasonal Pattern (Month Comparison)

**Dữ liệu:** Kết quả Bước 2 (month_name, total_revenue)

**Tạo Pivot Table:**
```
Rows:     month_number (để sort đúng thứ tự)
Values:   SUM of total_revenue
```

**Chart:** Column Chart
- X-axis: Jan → Dec
- Y-axis: Revenue
- → Bars Nov-Dec cao nhất, Jan-Feb thấp nhất

---

### Chart 3: Multi-Line - Category Seasonal Comparison

**Dữ liệu:** Kết quả Bước 5 (Category, month_number, total_revenue)

**Tạo Pivot Table:**
```
Rows:     month_number
Columns:  Category          ← QUAN TRỌNG: đặt Category vào Columns!
Values:   SUM of total_revenue
```

**Chart:** Line Chart (mỗi Category 1 line)
- → So sánh trực quan: lines có cùng lên/xuống không = trends giống nhau

---

### Chart 4: Multi-Line - Location (Country) Comparison

**Dữ liệu:** Kết quả Bước 8

**Tạo Pivot Table:**
```
Rows:     month_number
Columns:  Country
Values:   SUM of total_revenue
```

**Chart:** Line Chart (mỗi Country 1 line)

---

### Chart 5: Heatmap (Conditional Formatting)

**Pivot Table:**
```
Rows:     month_name (Jan → Dec)
Columns:  Category
Values:   SUM of total_revenue
```

**Format:** Select values → Format → Conditional formatting → Color scale
- Min value: Light color (red/white)
- Max value: Dark color (green/blue)

---

## 💡 KẾT LUẬN TRUNG TÂM

| Question | Answer |
|----------|--------|
| **Có seasonal trend?** | ✅ CÓ. Peak rõ ở Q4 (Nov-Dec), Low Q1 (Jan-Feb) |
| **Category giống overall?** | ✅ CÓ. Hầu hết peak Q4 |
| **Subcategory giống?** | ✅ Hầu hết giống. Home Appliances có mini-peak riêng (Jun) |
| **Location giống?** | ✅ CÓ. Cùng timing, khác magnitude |
| **Year-over-year?** | Revenue tăng trưởng đều qua các năm |

---

## 📝 KEY SQL TECHNIQUES USED

| Kỹ thuật | Mục đích |
|----------|----------|
| `JOIN Sales + Products` | Lấy thông tin Category, Price |
| `JOIN Sales + Stores` | Lấy thông tin Location |
| `YEAR()`, `MONTH()`, `FORMAT()` | Trích xuất time components |
| `DATEPART(QUARTER, date)` | Phân tích theo quý |
| `DATENAME(MONTH, date)` | Tên tháng dạng text |
| `COUNT(DISTINCT [Order Number])` | Đếm đơn hàng unique |
| `SUM(Quantity * [Unit Price USD])` | Tính doanh thu |
| `GROUP BY` nhiều chiều | Cross-analysis (time × category × location) |
| `TOP N ... ORDER BY` | Tìm peak / low |
| `DATEDIFF(DAY, start, end)` | Tính delivery time |
