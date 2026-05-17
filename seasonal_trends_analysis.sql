-- ============================================================================
-- BUSINESS QUESTION 1: SEASONAL TRENDS & PATTERNS
-- Có pattern/seasonal trends nào đối với số lượng đơn hàng / doanh thu không?
-- Xu hướng tổng thể có giống với xu hướng từng category / subcategory / location?
-- ============================================================================
-- Database: Superstore / E-commerce dataset
-- Giả định bảng: orders (hoặc superstore)
-- Các cột chính: Order Date, Sales, Order ID, Category, Sub-Category, 
--                 Region, State, City
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: XU HƯỚNG TỔNG THỂ - DOANH THU & SỐ ĐƠN HÀNG THEO THÁNG
-- Mục đích: Xem overall trend theo thời gian (Monthly)
-- ============================================================================

SELECT 
    YEAR([Order Date]) AS order_year,
    MONTH([Order Date]) AS order_month,
    FORMAT([Order Date], 'yyyy-MM') AS year_month,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(AVG(Sales), 2) AS avg_order_value
FROM superstore
GROUP BY 
    YEAR([Order Date]),
    MONTH([Order Date]),
    FORMAT([Order Date], 'yyyy-MM')
ORDER BY order_year, order_month;

-- ============================================================================
-- BƯỚC 2: PHÂN TÍCH SEASONAL PATTERN - TỔNG HỢP THEO THÁNG (Across Years)
-- Mục đích: Tìm tháng nào bán chạy nhất / ít nhất (loại bỏ yếu tố năm)
-- ============================================================================

SELECT 
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(AVG(Sales), 2) AS avg_revenue_per_order
FROM superstore
GROUP BY 
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY month_number;

-- ============================================================================
-- BƯỚC 3: PHÂN TÍCH THEO QUÝ (Quarterly Trends)
-- Mục đích: Xem xu hướng theo quý rõ ràng hơn
-- ============================================================================

SELECT 
    YEAR([Order Date]) AS order_year,
    DATEPART(QUARTER, [Order Date]) AS order_quarter,
    CONCAT('Q', DATEPART(QUARTER, [Order Date]), '-', YEAR([Order Date])) AS quarter_label,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY 
    YEAR([Order Date]),
    DATEPART(QUARTER, [Order Date]),
    CONCAT('Q', DATEPART(QUARTER, [Order Date]), '-', YEAR([Order Date]))
ORDER BY order_year, order_quarter;

-- ============================================================================
-- BƯỚC 4: XU HƯỚNG THEO CATEGORY (So sánh vs Overall)
-- Mục đích: Mỗi category có seasonal trend riêng hay giống overall?
-- ============================================================================

SELECT 
    YEAR([Order Date]) AS order_year,
    MONTH([Order Date]) AS order_month,
    FORMAT([Order Date], 'yyyy-MM') AS year_month,
    Category,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore
GROUP BY 
    YEAR([Order Date]),
    MONTH([Order Date]),
    FORMAT([Order Date], 'yyyy-MM'),
    Category
ORDER BY Category, order_year, order_month;

-- ============================================================================
-- BƯỚC 5: SEASONAL PATTERN THEO CATEGORY - GỘP ACROSS YEARS
-- Mục đích: Tháng nào bán chạy nhất cho từng category
-- ============================================================================

SELECT 
    Category,
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore
GROUP BY 
    Category,
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY Category, month_number;

-- ============================================================================
-- BƯỚC 6: XU HƯỚNG THEO SUB-CATEGORY
-- Mục đích: Chi tiết hơn - sub-category nào đóng góp vào seasonal peaks
-- ============================================================================

SELECT 
    Category,
    [Sub-Category],
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore
GROUP BY 
    Category,
    [Sub-Category],
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY Category, [Sub-Category], month_number;

-- ============================================================================
-- BƯỚC 7: XU HƯỚNG THEO REGION / LOCATION
-- Mục đích: Các vùng có seasonal trend khác nhau không?
-- ============================================================================

SELECT 
    Region,
    YEAR([Order Date]) AS order_year,
    MONTH([Order Date]) AS order_month,
    FORMAT([Order Date], 'yyyy-MM') AS year_month,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore
GROUP BY 
    Region,
    YEAR([Order Date]),
    MONTH([Order Date]),
    FORMAT([Order Date], 'yyyy-MM')
ORDER BY Region, order_year, order_month;

-- ============================================================================
-- BƯỚC 8: SEASONAL PATTERN THEO REGION - GỘP ACROSS YEARS
-- Mục đích: Mỗi region có peak month riêng hay giống nhau?
-- ============================================================================

SELECT 
    Region,
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore
GROUP BY 
    Region,
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY Region, month_number;

-- ============================================================================
-- BƯỚC 9: SO SÁNH YEAR-OVER-YEAR GROWTH
-- Mục đích: Doanh thu tăng trưởng qua các năm như thế nào
-- ============================================================================

SELECT 
    YEAR([Order Date]) AS order_year,
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY YEAR([Order Date])
ORDER BY order_year;

-- ============================================================================
-- BƯỚC 10: TOP MONTHS - PEAK VÀ LOW SEASONS
-- Mục đích: Xác định rõ high/low season
-- ============================================================================

SELECT TOP 3
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    ROUND(SUM(Sales), 2) AS total_revenue,
    COUNT(DISTINCT [Order ID]) AS total_orders
FROM superstore
GROUP BY 
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY total_revenue DESC;
-- → Peak months (Top 3 revenue)

SELECT TOP 3
    MONTH([Order Date]) AS month_number,
    DATENAME(MONTH, [Order Date]) AS month_name,
    ROUND(SUM(Sales), 2) AS total_revenue,
    COUNT(DISTINCT [Order ID]) AS total_orders
FROM superstore
GROUP BY 
    MONTH([Order Date]),
    DATENAME(MONTH, [Order Date])
ORDER BY total_revenue ASC;
-- → Low months (Bottom 3 revenue)
