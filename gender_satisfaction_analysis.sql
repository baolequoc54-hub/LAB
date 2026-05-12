-- ============================================================================
-- AIRLINE SATISFACTION ANALYSIS - THEO GENDER
-- So sánh tỷ lệ hài lòng giữa các nhóm giới tính (Male vs Female)
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: TỶ LỆ HÀI LÒNG THEO GENDER (Conditional Aggregation)
-- Mục đích: Xác định nhóm gender nào có tỷ lệ hài lòng cao hơn
-- ============================================================================

SELECT 
    Gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN satisfaction = 'satisfied' THEN 1 ELSE 0 END) AS satisfied_count,
    SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1 ELSE 0 END) AS dissatisfied_count,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct,
    ROUND(
        SUM(CASE WHEN satisfaction = 'neutral or dissatisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS dissatisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY Gender;

-- ============================================================================
-- BƯỚC 2: ĐIỂM TRUNG BÌNH RATING TỪNG YẾU TỐ DỊCH VỤ THEO GENDER
-- Mục đích: Xem nhóm nào đánh giá cao/thấp ở yếu tố nào
-- ============================================================================

SELECT 
    Gender,
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
GROUP BY Gender;

-- ============================================================================
-- BƯỚC 3: SO SÁNH CHI TIẾT - CHÊNH LỆCH RATING GIỮA MALE VÀ FEMALE
-- Mục đích: Tìm ra yếu tố nào có gap lớn nhất giữa 2 giới
-- ============================================================================

SELECT 
    'Inflight wifi service' AS service_factor,
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS female_avg,
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS male_avg,
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight wifi service] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight wifi service] AS FLOAT) END), 2) AS diff_female_minus_male
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Departure/Arrival time convenient',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Departure/Arrival time convenient] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Ease of Online booking',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Ease of Online booking] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Ease of Online booking] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Ease of Online booking] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Gate location',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Gate location] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Gate location] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Gate location] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Food and drink',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Food and drink] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Food and drink] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Food and drink] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Online boarding',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Online boarding] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Online boarding] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Online boarding] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Seat comfort',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Seat comfort] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Seat comfort] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Seat comfort] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Inflight entertainment',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight entertainment] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight entertainment] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight entertainment] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'On-board service',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([On-board service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([On-board service] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([On-board service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Leg room service',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Leg room service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Leg room service] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Leg room service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Baggage handling',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Baggage handling] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Baggage handling] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Baggage handling] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Checkin service',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Checkin service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Checkin service] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Checkin service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Inflight service',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight service] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Inflight service] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Inflight service] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

UNION ALL

SELECT 
    'Cleanliness',
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Male' THEN CAST([Cleanliness] AS FLOAT) END), 2),
    ROUND(AVG(CASE WHEN Gender = 'Female' THEN CAST([Cleanliness] AS FLOAT) END) 
        - AVG(CASE WHEN Gender = 'Male' THEN CAST([Cleanliness] AS FLOAT) END), 2)
FROM airline_passenger_satisfaction

ORDER BY diff_female_minus_male DESC;

-- ============================================================================
-- BƯỚC 4: PHÂN TÍCH THÊM - TỶ LỆ HÀI LÒNG THEO GENDER + CLASS
-- Mục đích: Xem trong từng class, gender nào hài lòng hơn
-- ============================================================================

SELECT 
    Gender,
    Class,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY Gender, Class
ORDER BY Class, satisfaction_rate_pct DESC;

-- ============================================================================
-- BƯỚC 5: PHÂN TÍCH THÊM - TỶ LỆ HÀI LÒNG THEO GENDER + TYPE OF TRAVEL
-- Mục đích: Xem mục đích chuyến bay ảnh hưởng thế nào đến sự hài lòng theo giới
-- ============================================================================

SELECT 
    Gender,
    [Type of Travel],
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN satisfaction = 'satisfied' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS satisfaction_rate_pct
FROM airline_passenger_satisfaction
GROUP BY Gender, [Type of Travel]
ORDER BY [Type of Travel], satisfaction_rate_pct DESC;
