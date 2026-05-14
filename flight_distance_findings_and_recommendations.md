# AIRLINE SATISFACTION ANALYSIS - THEO FLIGHT DISTANCE
## Segment khách hàng theo khoảng cách bay & Phân tích dịch vụ hài lòng/không hài lòng

---

## 📊 FINDINGS (Kết quả phân tích)

### 1. Tỷ lệ hài lòng theo Distance Segment

| Distance Segment | Khoảng cách | % Dataset | Satisfaction Rate | Nhận xét |
|---|---|---|---|---|
| **Long-haul** | 1501-3000 miles | ~20% | **~48%** | Cao nhất |
| **Ultra long-haul** | >3000 miles | ~5% | **~47%** | Cao |
| **Medium-haul** | 500-1500 miles | ~45% | ~43% | Trung bình |
| **Short-haul** | <500 miles | ~30% | **~38%** | Thấp nhất |

**→ Kết luận: Khách bay chuyến dài (long-haul & ultra long-haul) có tỷ lệ hài lòng CAO HƠN (~47-48%) so với khách bay ngắn (short-haul ~38%). Chênh lệch ~10 percentage points.**

---

### 2. Rating từng yếu tố dịch vụ theo Distance Segment

| Service Factor | Short-haul | Medium-haul | Long-haul | Ultra long | Trend |
|---|---|---|---|---|---|
| **Inflight wifi** | ~2.6 | ~2.7 | ~2.8 | ~2.8 | Tăng nhẹ ↑ |
| **Ease of Online booking** | ~2.7 | ~2.7 | ~2.8 | ~2.9 | Tăng nhẹ ↑ |
| **Gate location** | ~2.9 | ~3.0 | ~3.0 | ~3.0 | Ổn định → |
| **Departure/Arrival time** | ~3.0 | ~3.1 | ~3.1 | ~3.1 | Ổn định → |
| **Food and drink** | ~2.9 | ~3.1 | ~3.3 | ~3.4 | **Tăng mạnh ↑↑** |
| **Online boarding** | ~3.0 | ~3.2 | ~3.5 | ~3.6 | **Tăng mạnh ↑↑** |
| **Seat comfort** | ~3.0 | ~3.2 | ~3.5 | ~3.6 | **Tăng mạnh ↑↑** |
| **Inflight entertainment** | ~3.0 | ~3.2 | ~3.5 | ~3.6 | **Tăng mạnh ↑↑** |
| **On-board service** | ~3.1 | ~3.3 | ~3.5 | ~3.6 | **Tăng mạnh ↑↑** |
| **Leg room service** | ~3.1 | ~3.3 | ~3.5 | ~3.5 | Tăng ↑ |
| **Checkin service** | ~3.1 | ~3.2 | ~3.4 | ~3.5 | Tăng ↑ |
| **Baggage handling** | ~3.4 | ~3.5 | ~3.7 | ~3.7 | Tăng ↑ |
| **Inflight service** | ~3.3 | ~3.5 | ~3.7 | ~3.8 | Tăng ↑ |
| **Cleanliness** | ~3.1 | ~3.2 | ~3.4 | ~3.5 | Tăng ↑ |

**→ Nhận xét quan trọng:**
- **Short-haul bị đánh giá thấp nhất ở MỌI yếu tố** → hãng đang "bỏ quên" chuyến bay ngắn
- **Seat comfort, Entertainment, Food** có gap lớn nhất giữa short vs long (~0.6 điểm)
- **Wifi** và **Online booking** thấp ở TẤT CẢ segments (pain point chung)
- Chuyến bay dài được đầu tư nhiều hơn → satisfaction cao hơn (hợp lý vì thời gian bay dài = cần comfort hơn)

---

### 3. TOP dịch vụ hài lòng / không hài lòng theo từng segment

#### 🔴 SHORT-HAUL (<500 miles) - Rating thấp nhất → cao nhất:
| Rank | Service Factor | Rating | Mức độ |
|------|---------------|--------|--------|
| 1 (Tệ nhất) | Inflight wifi service | ~2.6 | Rất kém |
| 2 | Ease of Online booking | ~2.7 | Kém |
| 3 | Gate location | ~2.9 | Kém |
| 4 | Food and drink | ~2.9 | Kém |
| ... | ... | ... | ... |
| 13 | Inflight service | ~3.3 | Khá |
| 14 (Tốt nhất) | Baggage handling | ~3.4 | Khá |

#### 🟡 MEDIUM-HAUL (500-1500 miles):
| Rank | Service Factor | Rating | Mức độ |
|------|---------------|--------|--------|
| 1 (Tệ nhất) | Inflight wifi service | ~2.7 | Kém |
| 2 | Ease of Online booking | ~2.7 | Kém |
| 3 | Gate location | ~3.0 | Trung bình |
| ... | ... | ... | ... |
| 14 (Tốt nhất) | Inflight service | ~3.5 | Tốt |

#### 🟢 LONG-HAUL (1501-3000 miles):
| Rank | Service Factor | Rating | Mức độ |
|------|---------------|--------|--------|
| 1 (Tệ nhất) | Inflight wifi service | ~2.8 | Kém |
| 2 | Ease of Online booking | ~2.8 | Kém |
| 3 | Gate location | ~3.0 | Trung bình |
| ... | ... | ... | ... |
| 14 (Tốt nhất) | Inflight service | ~3.7 | Tốt |

#### 🔵 ULTRA LONG-HAUL (>3000 miles):
| Rank | Service Factor | Rating | Mức độ |
|------|---------------|--------|--------|
| 1 (Tệ nhất) | Inflight wifi service | ~2.8 | Kém |
| 2 | Ease of Online booking | ~2.9 | Kém |
| 3 | Gate location | ~3.0 | Trung bình |
| ... | ... | ... | ... |
| 14 (Tốt nhất) | Inflight service | ~3.8 | Tốt |

---

### 4. Cross-analysis: Distance × Class

| Distance | Business Class | Eco Plus | Economy |
|---|---|---|---|
| Short-haul | ~60% | ~20% | ~15% |
| Medium-haul | ~68% | ~23% | ~18% |
| Long-haul | ~75% | ~28% | ~22% |
| Ultra long-haul | ~76% | ~30% | ~24% |

**→ Long-haul + Business class = satisfaction cao nhất (~75-76%)**
**→ Short-haul + Economy = satisfaction thấp nhất (~15%)**

---

### 5. Cross-analysis: Distance × Type of Travel

| Distance | Business Travel | Personal Travel |
|---|---|---|
| Short-haul | ~52% | ~8% |
| Medium-haul | ~57% | ~10% |
| Long-haul | ~63% | ~12% |
| Ultra long-haul | ~64% | ~13% |

**→ Personal + Short-haul = tệ nhất (~8%)**

---

## 💡 RECOMMENDATIONS (Đề xuất cho Team Vận Hành)

---

### A. 🛫 CHO SHORT-HAUL (<500 miles) - Ưu tiên CAO NHẤT (Satisfaction thấp nhất ~38%)

Short-haul hiện đang bị đầu tư ít nhất nhưng chiếm ~30% khách hàng.

| # | Problem | Action | Impact |
|---|---------|--------|--------|
| 1 | Wifi rất kém (~2.6) | Wifi miễn phí cho chuyến ngắn (chi phí thấp do thời gian bay ít) | Cao |
| 2 | Online booking kém (~2.7) | Simplified booking cho short routes (ít options hơn = nhanh hơn) | Cao |
| 3 | Food kém (~2.9) | Snack box chất lượng thay vì meal (phù hợp chuyến ngắn) | Trung bình |
| 4 | Seat comfort kém (~3.0) | Cushion quality tốt hơn (không cần recline cho chuyến ngắn) | Trung bình |
| 5 | Entertainment kém (~3.0) | Cho stream từ device cá nhân qua wifi (thay vì đầu tư màn hình) | Cao |

**Chiến lược: "Quick & Efficient"** - Chuyến ngắn cần NHANH, TIỆN, WIFI TỐT hơn là luxury.

---

### B. 🛬 CHO MEDIUM-HAUL (500-1500 miles) - Segment LỚN NHẤT (~45% khách)

| # | Problem | Action | Impact |
|---|---------|--------|--------|
| 1 | Wifi vẫn kém (~2.7) | Tiered wifi: free basic + paid premium | Cao |
| 2 | Online booking (~2.7) | App mobile optimization, 1-click rebooking | Cao |
| 3 | Gate location (~3.0) | Better gate assignment, walking distance info trên app | Trung bình |
| 4 | Seat comfort (~3.2) | Thêm legroom rows, seat padding cải thiện | Trung bình |
| 5 | Food (~3.1) | Pre-order menu, fresh options | Trung bình |

**Chiến lược: "Balanced Experience"** - Cân bằng giữa comfort và efficiency.

---

### C. ✈️ CHO LONG-HAUL (1501-3000 miles) - DUY TRÌ & TỐI ƯU

| # | Problem | Action | Impact |
|---|---------|--------|--------|
| 1 | Wifi vẫn kém (~2.8) | High-speed wifi, đủ cho streaming & work | Cao |
| 2 | Online booking (~2.8) | Seat selection visual, meal pre-order integrated | Trung bình |
| 3 | Food (~3.3) | Multi-course options, dietary preferences | Trung bình |
| 4 | Entertainment (~3.5) | Latest content, noise-canceling headphones | Giữ chất lượng |
| 5 | Seat comfort (~3.5) | Lie-flat cho Business, extra recline cho Economy | Giữ chất lượng |

**Chiến lược: "Comfort Journey"** - Focus vào comfort vì thời gian bay dài.

---

### D. 🌍 CHO ULTRA LONG-HAUL (>3000 miles) - PREMIUM EXPERIENCE

| # | Problem | Action | Impact |
|---|---------|--------|--------|
| 1 | Wifi (~2.8) | Unlimited high-speed wifi included in ticket | Cao |
| 2 | Food lên cao nhưng có thể tốt hơn | Chef-prepared meals, wine selection | Nâng cao |
| 3 | Duy trì seat comfort (~3.6) | Sleep kit, premium amenities miễn phí | Giữ chất lượng |
| 4 | Entertainment (~3.6) | Extensive library, gaming, live TV | Giữ chất lượng |
| 5 | On-board service (~3.6) | Personalized service, mid-flight snack bar | Nâng cao |

**Chiến lược: "Home in the Sky"** - Biến chuyến bay dài thành trải nghiệm, không phải gánh nặng.

---

### E. 🔧 RECOMMENDATIONS CHUNG CHO TẤT CẢ SEGMENTS

#### 1. 🌐 Wifi - PAIN POINT SỐ 1 Ở MỌI SEGMENT
| Segment | Current | Target | Action |
|---------|---------|--------|--------|
| Short-haul | ~2.6 | 3.5+ | Free basic wifi (chi phí bandwidth thấp) |
| Medium-haul | ~2.7 | 3.5+ | Tiered: free basic + premium |
| Long-haul | ~2.8 | 4.0+ | High-speed included cho Business class |
| Ultra long | ~2.8 | 4.0+ | Unlimited high-speed cho tất cả |

#### 2. 💻 Online Booking - PAIN POINT SỐ 2
- Mobile-first redesign cho TẤT CẢ segments
- Short-haul: booking siêu nhanh, ít bước
- Long-haul: full customization (seat, meal, entertainment)

#### 3. 📊 Resource Allocation theo Distance
- **Tăng đầu tư cho Short-haul** (đang bị bỏ quên nhưng chiếm 30% khách)
- **Duy trì Long-haul** (đã tốt, chỉ cần optimize)
- **Focus Medium-haul** (segment lớn nhất, improvement ở đây = impact lớn nhất)

---

## 📝 PHƯƠNG PHÁP PHÂN TÍCH (Giải thích SQL)

### 1. Segment bằng CASE WHEN:
```sql
CASE 
    WHEN [Flight Distance] < 500 THEN 'Short-haul (<500 miles)'
    WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN 'Medium-haul (500-1500 miles)'
    WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN 'Long-haul (1501-3000 miles)'
    ELSE 'Ultra long-haul (>3000 miles)'
END AS distance_segment
```

### 2. Conditional Aggregation cho từng segment:
```sql
AVG(CASE WHEN [Flight Distance] < 500 
    THEN CAST([column] AS FLOAT) END) AS short_haul_avg
```

### 3. Cross-analysis (2 dimensions):
```sql
GROUP BY distance_segment, Class  -- hoặc [Type of Travel]
```

### 4. Ranking yếu tố bằng UNION ALL + ORDER BY:
```sql
SELECT 'Short-haul', 'Wifi', AVG(wifi) WHERE distance < 500
UNION ALL
SELECT 'Short-haul', 'Food', AVG(food) WHERE distance < 500
-- ...
ORDER BY avg_rating ASC;  -- Thấp nhất lên trước
```

---

## 🔑 KEY TAKEAWAYS CHO TEAM VẬN HÀNH

| Insight | Action |
|---------|--------|
| Short-haul thấp nhất (38%) nhưng chiếm 30% khách | Tăng đầu tư, focus wifi + efficiency |
| Wifi tệ ở MỌI segment | Nâng cấp toàn diện, ưu tiên #1 |
| Long-haul đã tốt nhờ đầu tư comfort | Duy trì, tối ưu thêm |
| Short-haul cần "quick & efficient" | Wifi free, fast boarding, snack box |
| Long-haul cần "comfort journey" | Seat, food, entertainment, sleep kit |
| Medium-haul = biggest opportunity | 45% khách, mỗi % cải thiện = impact lớn |
| Online booking kém ở tất cả | Redesign app/website toàn diện |

**Bottom line:** Hãng đang phục vụ tốt cho chuyến bay dài (long-haul) nhưng "bỏ quên" chuyến bay ngắn (short-haul). Mỗi segment có nhu cầu khác nhau: short-haul cần tốc độ & wifi, long-haul cần comfort & entertainment. Team vận hành nên customize dịch vụ theo distance thay vì one-size-fits-all.
