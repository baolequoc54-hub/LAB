-- ============================================================================
-- AIRLINE SATISFACTION ANALYSIS - THEO FLIGHT DISTANCE
-- Segment khách hàng theo khoảng cách bay, phân tích mức độ hài lòng
-- từng yếu tố dịch vụ cho mỗi segment
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: SEGMENT KHÁCH HÀNG THEO FLIGHT DISTANCE
-- Phân nhóm:
--   Short-haul: < 500 miles (chuyến bay ngắn, nội địa gần)
--   Medium-haul: 500 - 1500 miles (nội địa xa / khu vực)
--   Long-haul: 1500 - 3000 miles (liên vùng)
--   Ultra long-haul: > 3000 miles (xuyên lục địa)
-- Mục đích: Xác định tỷ lệ hài lòng theo từng segment distance
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END AS distance_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_count,
    SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1 ELSE 0 END) AS dissatisfied_count,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END
ORDER BY distance_segment;

-- ============================================================================
-- BƯỚC 2: ĐIỂM TRUNG BÌNH RATING TỪNG YẾU TỐ THEO DISTANCE SEGMENT
-- Mục đích: Xem khách hàng từng segment đánh giá dịch vụ nào cao/thấp
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END AS distance_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_wifi_service,
    ROUND(AVG(CAST([Departure/Arrival time convenient] AS FLOAT)), 2) AS avg_time_convenient,
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2) AS avg_online_booking,
    ROUND(AVG(CAST([Gate location] AS FLOAT)), 2) AS avg_gate_location,
    ROUND(AVG(CAST([Food and drink] AS FLOAT)), 2) AS avg_food_drink,
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2) AS avg_online_boarding,
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2) AS avg_seat_comfort,
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2) AS avg_inflight_entertainment,
    ROUND(AVG(CAST([On-board service] AS FLOAT)), 2) AS avg_onboard_service,
    ROUND(AVG(CAST([Leg room service] AS FLOAT)), 2) AS avg_legroom,
    ROUND(AVG(CAST([Baggage handling] AS FLOAT)), 2) AS avg_baggage_handling,
    ROUND(AVG(CAST([Checkin service] AS FLOAT)), 2) AS avg_checkin_service,
    ROUND(AVG(CAST([Inflight service] AS FLOAT)), 2) AS avg_inflight_service,
    ROUND(AVG(CAST([Cleanliness] AS FLOAT)), 2) AS avg_cleanliness
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END
ORDER BY distance_segment;

-- ============================================================================
-- BƯỚC 3: SO SÁNH RATING TỪNG YẾU TỐ - SHORT-HAUL vs LONG-HAUL
-- Mục đích: Tìm ra yếu tố nào có gap lớn nhất giữa chuyến ngắn và dài
-- ============================================================================

SELECT 
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS short_haul_avg,
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS medium_haul_avg,
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS long_haul_avg,
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS ultra_long_avg
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Departure/Arrival time convenient',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Ease of Online booking',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Ease of Online booking] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Gate location',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Gate location] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Food and drink',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Food and drink] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Online boarding',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Online boarding] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Seat comfort',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Seat comfort] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight entertainment',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Inflight entertainment] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'On-board service',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([On-board service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Leg room service',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Leg room service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Baggage handling',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Baggage handling] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Checkin service',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Checkin service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Inflight service',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Inflight wifi service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Inflight service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 'Cleanliness',
    ROUND(AVG(CASE WHEN [Flight Distance] < 500 THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN [Flight Distance] > 3000 THEN CAST([Cleanliness] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction;

-- ============================================================================
-- BƯỚC 4: PHÂN TÍCH DISTANCE SEGMENT + CLASS
-- Mục đích: Trong từng segment distance, class nào hài lòng hơn
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END AS distance_segment,
    Class,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END,
    Class
ORDER BY distance_segment, satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 5: PHÂN TÍCH DISTANCE SEGMENT + TYPE OF TRAVEL
-- Mục đích: Khách Business vs Personal hài lòng thế nào ở từng distance
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END AS distance_segment,
    [Type of Travel],
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END,
    [Type of Travel]
ORDER BY distance_segment, satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 6: PHÂN TÍCH DELAY IMPACT THEO DISTANCE SEGMENT
-- Mục đích: Delay ảnh hưởng khác nhau thế nào theo khoảng cách bay
-- ============================================================================

SELECT 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END AS distance_segment,
    ROUND(AVG(CAST([Departure Delay in Minutes] AS FLOAT)), 2) AS avg_departure_delay,
    ROUND(AVG(CAST([Arrival Delay in Minutes] AS FLOAT)), 2) AS avg_arrival_delay,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY 
    CASE 
        WHEN [Flight Distance] < 500 THEN '1. Short-haul (<500 miles)'
        WHEN [Flight Distance] BETWEEN 500 AND 1500 THEN '2. Medium-haul (500-1500 miles)'
        WHEN [Flight Distance] BETWEEN 1501 AND 3000 THEN '3. Long-haul (1501-3000 miles)'
        ELSE '4. Ultra long-haul (>3000 miles)'
    END
ORDER BY distance_segment;

-- ============================================================================
-- BƯỚC 7: XÁC ĐỊNH TOP DỊCH VỤ HÀI LÒNG / KHÔNG HÀI LÒNG CHO TỪNG SEGMENT
-- Mục đích: Team vận hành biết chính xác cần focus dịch vụ nào
-- (Dùng UNPIVOT logic với UNION ALL)
-- ============================================================================

-- Short-haul: Xếp hạng yếu tố từ thấp → cao
SELECT 'Short-haul (<500 miles)' AS distance_segment,
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CAST([Inflight wifi service] AS FLOAT)), 2) AS avg_rating
FROM airline_passenger_satisfaction
WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Online boarding',
    ROUND(AVG(CAST([Online boarding] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Ease of Online booking',
    ROUND(AVG(CAST([Ease of Online booking] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Seat comfort',
    ROUND(AVG(CAST([Seat comfort] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Inflight entertainment',
    ROUND(AVG(CAST([Inflight entertainment] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Food and drink',
    ROUND(AVG(CAST([Food and drink] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'On-board service',
    ROUND(AVG(CAST([On-board service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Leg room service',
    ROUND(AVG(CAST([Leg room service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Baggage handling',
    ROUND(AVG(CAST([Baggage handling] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Checkin service',
    ROUND(AVG(CAST([Checkin service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Inflight service',
    ROUND(AVG(CAST([Inflight service] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Cleanliness',
    ROUND(AVG(CAST([Cleanliness] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Gate location',
    ROUND(AVG(CAST([Gate location] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
UNION ALL
SELECT 'Short-haul (<500 miles)', 'Departure/Arrival time convenient',
    ROUND(AVG(CAST([Departure/Arrival time convenient] AS FLOAT)), 2)
FROM airline_passenger_satisfaction WHERE [Flight Distance] < 500
ORDER BY distance_segment, avg_rating ASC;
