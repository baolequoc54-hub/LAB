-- ============================================================================
-- BUSINESS QUESTION: SEASONAL TRENDS & PATTERNS
-- Có pattern/seasonal trends nào đối với số lượng đơn hàng / doanh thu không?
-- Xu hướng tổng thể có giống với xu hướng từng category/subcategory/location?
-- ============================================================================
-- Database: Retail Sales
-- Bảng: Sales, Products, Stores, Customers, Exchange_Rates
-- Doanh thu (Revenue) = Quantity * [Unit Price USD]
-- Profit = Revenue - Cost = Quantity * ([Unit Price USD] - [Unit Cost USD])
-- ============================================================================

-- ============================================================================
-- BƯỚC 1: XU HƯỚNG TỔNG THỂ - SỐ ĐƠN HÀNG & DOANH THU THEO THÁNG
-- Mục đích: Xem overall monthly trend
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    MONTH(s.[Order Date]) AS order_month,
    FORMAT(s.[Order Date], 'yyyy-MM') AS year_month,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(s.[Order Date]),
    MONTH(s.[Order Date]),
    FORMAT(s.[Order Date], 'yyyy-MM')
ORDER BY order_year, order_month;

-- ============================================================================
-- BƯỚC 2: SEASONAL PATTERN - GỘP THEO THÁNG (Across Years)
-- Mục đích: Tìm tháng peak / low (loại bỏ yếu tố năm để thấy pattern thuần)
-- ============================================================================

SELECT 
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY month_number;

-- ============================================================================
-- BƯỚC 3: PHÂN TÍCH THEO QUÝ (Quarterly Trends)
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    DATEPART(QUARTER, s.[Order Date]) AS order_quarter,
    CONCAT('Q', DATEPART(QUARTER, s.[Order Date]), '-', YEAR(s.[Order Date])) AS quarter_label,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(s.[Order Date]),
    DATEPART(QUARTER, s.[Order Date]),
    CONCAT('Q', DATEPART(QUARTER, s.[Order Date]), '-', YEAR(s.[Order Date]))
ORDER BY order_year, order_quarter;

-- ============================================================================
-- BƯỚC 4: XU HƯỚNG THEO CATEGORY (So sánh vs Overall)
-- Mục đích: Mỗi category có seasonal trend giống overall hay không?
-- ============================================================================

SELECT 
    p.Category,
    YEAR(s.[Order Date]) AS order_year,
    MONTH(s.[Order Date]) AS order_month,
    FORMAT(s.[Order Date], 'yyyy-MM') AS year_month,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    p.Category,
    YEAR(s.[Order Date]),
    MONTH(s.[Order Date]),
    FORMAT(s.[Order Date], 'yyyy-MM')
ORDER BY p.Category, order_year, order_month;

-- ============================================================================
-- BƯỚC 5: SEASONAL PATTERN THEO CATEGORY - GỘP ACROSS YEARS
-- Mục đích: Tháng nào bán chạy nhất cho từng category?
-- ============================================================================

SELECT 
    p.Category,
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    p.Category,
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY p.Category, month_number;

-- ============================================================================
-- BƯỚC 6: XU HƯỚNG THEO SUBCATEGORY
-- Mục đích: Sub-category nào đóng góp vào seasonal peaks?
-- ============================================================================

SELECT 
    p.Category,
    p.Subcategory,
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    p.Category,
    p.Subcategory,
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY p.Category, p.Subcategory, month_number;

-- ============================================================================
-- BƯỚC 7: XU HƯỚNG THEO LOCATION (Store Country)
-- Mục đích: Các quốc gia có seasonal trend khác nhau không?
-- ============================================================================

SELECT 
    st.Country,
    YEAR(s.[Order Date]) AS order_year,
    MONTH(s.[Order Date]) AS order_month,
    FORMAT(s.[Order Date], 'yyyy-MM') AS year_month,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
JOIN Stores st ON s.StoreKey = st.StoreKey
GROUP BY 
    st.Country,
    YEAR(s.[Order Date]),
    MONTH(s.[Order Date]),
    FORMAT(s.[Order Date], 'yyyy-MM')
ORDER BY st.Country, order_year, order_month;

-- ============================================================================
-- BƯỚC 8: SEASONAL PATTERN THEO LOCATION - GỘP ACROSS YEARS
-- Mục đích: Mỗi quốc gia có peak month riêng hay giống?
-- ============================================================================

SELECT 
    st.Country,
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
JOIN Stores st ON s.StoreKey = st.StoreKey
GROUP BY 
    st.Country,
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY st.Country, month_number;

-- ============================================================================
-- BƯỚC 9: YEAR-OVER-YEAR GROWTH
-- Mục đích: Doanh thu tăng trưởng qua năm?
-- ============================================================================

SELECT 
    YEAR(s.[Order Date]) AS order_year,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    SUM(s.Quantity) AS total_quantity,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    ROUND(SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])), 2) AS total_profit,
    ROUND(
        SUM(s.Quantity * (p.[Unit Price USD] - p.[Unit Cost USD])) 
        / SUM(s.Quantity * p.[Unit Price USD]) * 100, 2
    ) AS profit_margin_pct
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY YEAR(s.[Order Date])
ORDER BY order_year;

-- ============================================================================
-- BƯỚC 10: TOP PEAK & LOW MONTHS
-- ============================================================================

-- Peak months (Top 3)
SELECT TOP 3
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    COUNT(DISTINCT s.[Order Number]) AS total_orders
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY total_revenue DESC;

-- Low months (Bottom 3)
SELECT TOP 3
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    ROUND(SUM(s.Quantity * p.[Unit Price USD]), 2) AS total_revenue,
    COUNT(DISTINCT s.[Order Number]) AS total_orders
FROM Sales s
JOIN Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY total_revenue ASC;

-- ============================================================================
-- BƯỚC 11: DELIVERY TIME THEO MÙA
-- Mục đích: Peak season có làm chậm delivery không?
-- ============================================================================

SELECT 
    MONTH(s.[Order Date]) AS month_number,
    DATENAME(MONTH, s.[Order Date]) AS month_name,
    COUNT(DISTINCT s.[Order Number]) AS total_orders,
    ROUND(AVG(CAST(DATEDIFF(DAY, s.[Order Date], s.[Delivery Date]) AS FLOAT)), 1) AS avg_delivery_days
FROM Sales s
GROUP BY 
    MONTH(s.[Order Date]),
    DATENAME(MONTH, s.[Order Date])
ORDER BY month_number;
