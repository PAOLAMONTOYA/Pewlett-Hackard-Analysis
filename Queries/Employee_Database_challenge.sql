-- Deliverable 1: creating retirement table for different hired dates dates
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	tt.title,
	tt.from_date,
	tt.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Count of employees with most recent job title retiring
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Deliverable 2: employees eligable to participate in mentorship program
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tt.title
INTO mentorship_eligability
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;