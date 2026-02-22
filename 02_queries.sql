USE shop_staff_db;

-- 1) Извличане на всички смени за даден служител
SELECT e.emp_id, e.first_name, e.last_name, s.shift_date, s.start_time, s.end_time, s.status
FROM attendance a
JOIN employees e ON e.emp_id = a.emp_id
JOIN shifts s ON s.shift_id = a.shift_id
WHERE e.emp_id = 2
ORDER BY s.shift_date, s.start_time;

-- 2) Оборот за последния месец
SELECT
  SUM(CASE WHEN sale_type='sale' THEN amount ELSE -amount END) AS turnover_last_month
FROM sales
WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 3) Списък на продажби над определена стойност
SELECT sale_id, receipt_no, sale_date, sale_time, amount, payment_method, sale_type
FROM sales
WHERE amount > 50.00
ORDER BY amount DESC;

-- 4) Служители с ниска ставка - аналог на "ниска наличност"
SELECT emp_id, first_name, last_name, hourly_rate
FROM employees
WHERE hourly_rate < 9.20
ORDER BY hourly_rate ASC;

-- 5) Топ 5 служители по изчислено възнаграждение за последните 7 дни
SELECT e.emp_id, e.first_name, e.last_name,
       ROUND(SUM((TIMESTAMPDIFF(MINUTE, a.check_in, a.check_out) - a.break_minutes)/60) * e.hourly_rate, 2) AS pay_amount
FROM attendance a
JOIN employees e ON e.emp_id = a.emp_id
JOIN shifts s ON s.shift_id = a.shift_id
WHERE s.shift_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY e.emp_id
ORDER BY pay_amount DESC
LIMIT 5;

-- 6) Най-натоварена смяна
SELECT s.shift_id, s.shift_date, COUNT(*) AS receipts_count
FROM sales sa
JOIN shifts s ON s.shift_id = sa.shift_id
GROUP BY s.shift_id, s.shift_date
ORDER BY receipts_count DESC
LIMIT 1;

-- 7) Често работещи заедно служители
SELECT a1.emp_id AS emp1, a2.emp_id AS emp2, COUNT(*) AS times_together
FROM attendance a1
JOIN attendance a2
  ON a1.shift_id = a2.shift_id AND a1.emp_id < a2.emp_id
GROUP BY emp1, emp2
ORDER BY times_together DESC
LIMIT 10;

-- 8) Добавяне/корекция на продажба
INSERT INTO sales (shift_id, receipt_no, sale_date, sale_time, amount, payment_method, sale_type)
VALUES (9, 'R1204', '2026-01-12', '15:20:00', 21.90, 'card', 'sale');

-- 9) Анулиране на продажба
UPDATE sales
SET sale_type='refund'
WHERE receipt_no='R1202' AND sale_date='2026-01-12';

-- Проверка
SELECT sale_id, receipt_no, sale_type
FROM sales
WHERE receipt_no='R1202' AND sale_date='2026-01-12';

-- 10) Текущи смени, които очакват затваряне
SELECT shift_id, shift_date, start_time, end_time, status, manager_emp_id
FROM shifts
WHERE status IN ('planned','open')
ORDER BY shift_date, start_time;