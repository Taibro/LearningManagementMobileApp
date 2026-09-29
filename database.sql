-- =====================================================================
-- HỆ THỐNG ĐÁNH GIÁ CHẤT LƯỢNG HOẠT ĐỘNG TRƯỜNG ĐẠI HỌC
-- Database: MySQL 8.0+
-- Dùng cho Laragon
-- =====================================================================

-- Xóa database cũ nếu muốn tạo lại từ đầu
DROP DATABASE IF EXISTS quality_eval_db;

-- Tạo database
CREATE DATABASE quality_eval_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Sử dụng database
USE quality_eval_db;


-- =====================================================================
-- 1. PHÂN QUYỀN NGƯỜI DÙNG
-- =====================================================================

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_code VARCHAR(30) NOT NULL UNIQUE,
    role_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Dữ liệu quyền người dùng
INSERT INTO roles (role_code, role_name, description) VALUES
('ADMIN', 'Quản trị hệ thống', 'Toàn quyền quản trị hệ thống'),
('MANAGER', 'Cán bộ quản lý', 'Quản lý tiêu chí, khảo sát, báo cáo'),
('LECTURER', 'Giảng viên', 'Tham gia khảo sát và xem báo cáo liên quan'),
('STUDENT', 'Sinh viên', 'Tham gia khảo sát đánh giá');


-- =====================================================================
-- BẢNG NGƯỜI DÙNG
-- =====================================================================

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(50) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    full_name VARCHAR(150) NOT NULL,

    email VARCHAR(150) UNIQUE,

    phone VARCHAR(20),

    role_id INT NOT NULL,

    department VARCHAR(150),

    student_code VARCHAR(30),

    staff_code VARCHAR(30),

    status TINYINT NOT NULL DEFAULT 1,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Tài khoản Admin
-- username: admin
-- password: Admin@123

INSERT INTO users
(
    username,
    password_hash,
    full_name,
    email,
    role_id,
    status
)
VALUES
(
    'admin',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Quản trị viên',
    'admin@huit.edu.vn',
    1,
    1
);


-- =====================================================================
-- 2. QUẢN LÝ NHÓM TIÊU CHÍ
-- =====================================================================

CREATE TABLE criteria_groups (

    group_id INT AUTO_INCREMENT PRIMARY KEY,

    group_code VARCHAR(30) NOT NULL UNIQUE,

    group_name VARCHAR(200) NOT NULL,

    description VARCHAR(500),

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- BẢNG TIÊU CHÍ / KPI
-- =====================================================================

CREATE TABLE criteria (

    criteria_id INT AUTO_INCREMENT PRIMARY KEY,

    group_id INT NOT NULL,

    criteria_code VARCHAR(30) NOT NULL UNIQUE,

    criteria_name VARCHAR(255) NOT NULL,

    description VARCHAR(500),

    weight DECIMAL(6,4) NOT NULL DEFAULT 1.0000,

    scale_min DECIMAL(6,2) NOT NULL DEFAULT 1.00,

    scale_max DECIMAL(6,2) NOT NULL DEFAULT 5.00,

    is_active TINYINT NOT NULL DEFAULT 1,

    created_by INT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_criteria_group
        FOREIGN KEY (group_id)
        REFERENCES criteria_groups(group_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_criteria_creator
        FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- 3. QUẢN LÝ KHẢO SÁT
-- =====================================================================

CREATE TABLE surveys (

    survey_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    description TEXT,

    target_role VARCHAR(30),

    start_date DATETIME,

    end_date DATETIME,

    status VARCHAR(20) NOT NULL DEFAULT 'DRAFT',

    created_by INT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_survey_creator
        FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- CÂU HỎI KHẢO SÁT
-- =====================================================================

CREATE TABLE survey_questions (

    question_id INT AUTO_INCREMENT PRIMARY KEY,

    survey_id INT NOT NULL,

    criteria_id INT NULL,

    question_text VARCHAR(500) NOT NULL,

    question_type VARCHAR(20) NOT NULL DEFAULT 'SCALE',

    options_json JSON NULL,

    order_no INT NOT NULL DEFAULT 1,

    CONSTRAINT fk_question_survey
        FOREIGN KEY (survey_id)
        REFERENCES surveys(survey_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_question_criteria
        FOREIGN KEY (criteria_id)
        REFERENCES criteria(criteria_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- PHIẾU TRẢ LỜI KHẢO SÁT
-- =====================================================================

CREATE TABLE survey_responses (

    response_id INT AUTO_INCREMENT PRIMARY KEY,

    survey_id INT NOT NULL,

    user_id INT NULL,

    submitted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_response_survey
        FOREIGN KEY (survey_id)
        REFERENCES surveys(survey_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_response_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- CÂU TRẢ LỜI KHẢO SÁT
-- =====================================================================

CREATE TABLE survey_answers (

    answer_id INT AUTO_INCREMENT PRIMARY KEY,

    response_id INT NOT NULL,

    question_id INT NOT NULL,

    answer_value VARCHAR(500),

    answer_text TEXT,

    CONSTRAINT fk_answer_response
        FOREIGN KEY (response_id)
        REFERENCES survey_responses(response_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_answer_question
        FOREIGN KEY (question_id)
        REFERENCES survey_questions(question_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- 4. KỲ ĐÁNH GIÁ
-- =====================================================================

CREATE TABLE evaluation_periods (

    period_id INT AUTO_INCREMENT PRIMARY KEY,

    period_name VARCHAR(150) NOT NULL,

    start_date DATE,

    end_date DATE,

    status VARCHAR(20) NOT NULL DEFAULT 'OPEN'

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- ĐỐI TƯỢNG ĐÁNH GIÁ
-- =====================================================================

CREATE TABLE evaluation_targets (

    target_id INT AUTO_INCREMENT PRIMARY KEY,

    target_type VARCHAR(30) NOT NULL,

    target_name VARCHAR(255) NOT NULL,

    ref_id INT NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- ĐIỂM ĐÁNH GIÁ
-- =====================================================================

CREATE TABLE evaluation_scores (

    score_id INT AUTO_INCREMENT PRIMARY KEY,

    period_id INT NOT NULL,

    target_id INT NOT NULL,

    criteria_id INT NOT NULL,

    raw_score DECIMAL(8,4) NOT NULL,

    weighted_score DECIMAL(8,4) NOT NULL,

    method VARCHAR(30) NOT NULL DEFAULT 'AVERAGE',

    computed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_score_period
        FOREIGN KEY (period_id)
        REFERENCES evaluation_periods(period_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_score_target
        FOREIGN KEY (target_id)
        REFERENCES evaluation_targets(target_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_score_criteria
        FOREIGN KEY (criteria_id)
        REFERENCES criteria(criteria_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- MA TRẬN AHP
-- =====================================================================

CREATE TABLE ahp_matrices (

    matrix_id INT AUTO_INCREMENT PRIMARY KEY,

    group_id INT NOT NULL,

    criteria_a_id INT NOT NULL,

    criteria_b_id INT NOT NULL,

    comparison_value DECIMAL(6,3) NOT NULL,

    created_by INT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ahp_group
        FOREIGN KEY (group_id)
        REFERENCES criteria_groups(group_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_ahp_criteria_a
        FOREIGN KEY (criteria_a_id)
        REFERENCES criteria(criteria_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_ahp_criteria_b
        FOREIGN KEY (criteria_b_id)
        REFERENCES criteria(criteria_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_ahp_creator
        FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- 5. XẾP HẠNG CHẤT LƯỢNG
-- =====================================================================

CREATE TABLE quality_rankings (

    ranking_id INT AUTO_INCREMENT PRIMARY KEY,

    period_id INT NOT NULL,

    target_id INT NOT NULL,

    total_score DECIMAL(8,4) NOT NULL,

    rank_no INT,

    rank_label VARCHAR(30),

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rank_period
        FOREIGN KEY (period_id)
        REFERENCES evaluation_periods(period_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_rank_target
        FOREIGN KEY (target_id)
        REFERENCES evaluation_targets(target_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- BÁO CÁO
-- =====================================================================

CREATE TABLE reports (

    report_id INT AUTO_INCREMENT PRIMARY KEY,

    period_id INT NOT NULL,

    title VARCHAR(255) NOT NULL,

    file_path VARCHAR(500),

    generated_by INT NULL,

    generated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_report_period
        FOREIGN KEY (period_id)
        REFERENCES evaluation_periods(period_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_report_user
        FOREIGN KEY (generated_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- 6. NHẬT KÝ HỆ THỐNG
-- =====================================================================

CREATE TABLE login_logs (

    log_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    action VARCHAR(30) NOT NULL,

    ip_address VARCHAR(50),

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================================
-- 7. DỮ LIỆU MẪU - NHÓM TIÊU CHÍ
-- =====================================================================

INSERT INTO criteria_groups
(
    group_code,
    group_name,
    description
)
VALUES
(
    'DT',
    'Đào tạo',
    'Chất lượng chương trình và hoạt động giảng dạy'
),
(
    'NCKH',
    'Nghiên cứu khoa học',
    'Hoạt động nghiên cứu và công bố khoa học'
),
(
    'CSVC',
    'Cơ sở vật chất',
    'Phòng học, thư viện và trang thiết bị'
),
(
    'DVSV',
    'Dịch vụ sinh viên',
    'Hỗ trợ, tư vấn và hoạt động dành cho sinh viên'
);


-- =====================================================================
-- 8. DỮ LIỆU MẪU - TIÊU CHÍ ĐÁNH GIÁ
-- =====================================================================

INSERT INTO criteria
(
    group_id,
    criteria_code,
    criteria_name,
    weight,
    scale_min,
    scale_max
)
VALUES
(
    1,
    'DT01',
    'Nội dung chương trình đào tạo phù hợp với thực tiễn',
    0.3000,
    1,
    5
),
(
    1,
    'DT02',
    'Phương pháp giảng dạy của giảng viên',
    0.3000,
    1,
    5
),
(
    1,
    'DT03',
    'Tài liệu học tập đầy đủ và được cập nhật',
    0.2000,
    1,
    5
),
(
    2,
    'NC01',
    'Số lượng đề tài và công bố khoa học',
    0.5000,
    1,
    5
),
(
    3,
    'CS01',
    'Chất lượng phòng học và trang thiết bị',
    0.4000,
    1,
    5
),
(
    4,
    'DV01',
    'Chất lượng tư vấn và hỗ trợ sinh viên',
    0.4000,
    1,
    5
);


-- =====================================================================
-- 9. DỮ LIỆU MẪU - KỲ ĐÁNH GIÁ
-- =====================================================================

INSERT INTO evaluation_periods
(
    period_name,
    start_date,
    end_date,
    status
)
VALUES
(
    'Học kỳ 1 - Năm học 2026-2027',
    '2026-09-01',
    '2027-01-15',
    'OPEN'
);

-- =====================================================================
-- 10. THÊM DỮ LIỆU MẪU
-- Mỗi bảng nghiệp vụ có khoảng 10 dữ liệu
-- =====================================================================


-- =====================================================================
-- 10.1 THÊM NGƯỜI DÙNG
-- =====================================================================

INSERT INTO users
(
    username,
    password_hash,
    full_name,
    email,
    phone,
    role_id,
    department,
    student_code,
    staff_code,
    status
)
VALUES

(
    'manager01',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Nguyễn Văn Minh',
    'minh.manager@huit.edu.vn',
    '0901000001',
    2,
    'Phòng Đảm bảo chất lượng',
    NULL,
    'CB001',
    1
),

(
    'manager02',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Trần Thị Lan',
    'lan.manager@huit.edu.vn',
    '0901000002',
    2,
    'Phòng Đào tạo',
    NULL,
    'CB002',
    1
),

(
    'lecturer01',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Lê Hoàng Nam',
    'nam.lecturer@huit.edu.vn',
    '0901000003',
    3,
    'Khoa Công nghệ Thông tin',
    NULL,
    'GV001',
    1
),

(
    'lecturer02',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Phạm Thị Hương',
    'huong.lecturer@huit.edu.vn',
    '0901000004',
    3,
    'Khoa Công nghệ Thông tin',
    NULL,
    'GV002',
    1
),

(
    'lecturer03',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Võ Quốc Anh',
    'anh.lecturer@huit.edu.vn',
    '0901000005',
    3,
    'Khoa Quản trị Kinh doanh',
    NULL,
    'GV003',
    1
),

(
    'student01',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Nguyễn Thị Mai',
    'mai.student@huit.edu.vn',
    '0901000006',
    4,
    'Khoa Công nghệ Thông tin',
    '2001234567',
    NULL,
    1
),

(
    'student02',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Trần Quốc Bảo',
    'bao.student@huit.edu.vn',
    '0901000007',
    4,
    'Khoa Công nghệ Thông tin',
    '2001234568',
    NULL,
    1
),

(
    'student03',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Lê Minh Khang',
    'khang.student@huit.edu.vn',
    '0901000008',
    4,
    'Khoa Công nghệ Thông tin',
    '2001234569',
    NULL,
    1
),

(
    'student04',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Phạm Ngọc Anh',
    'ngocanh.student@huit.edu.vn',
    '0901000009',
    4,
    'Khoa Quản trị Kinh doanh',
    '2001234570',
    NULL,
    1
),

(
    'student05',
    '$2b$11$Qy3V.Z1K38uDgsktegoOsuyGlqEstlp9rqyDybaR/Lw6MY9N2GLdy',
    'Hoàng Gia Huy',
    'huy.student@huit.edu.vn',
    '0901000010',
    4,
    'Khoa Công nghệ Thông tin',
    '2001234571',
    NULL,
    1
);


-- =====================================================================
-- 10.2 THÊM NHÓM TIÊU CHÍ
-- =====================================================================

INSERT INTO criteria_groups
(
    group_code,
    group_name,
    description
)
VALUES

(
    'QLCL',
    'Quản lý chất lượng',
    'Đánh giá hoạt động quản lý và đảm bảo chất lượng'
),

(
    'GV',
    'Đội ngũ giảng viên',
    'Đánh giá năng lực và chất lượng giảng viên'
),

(
    'CTDT',
    'Chương trình đào tạo',
    'Đánh giá nội dung và cấu trúc chương trình đào tạo'
),

(
    'HTSV',
    'Hỗ trợ sinh viên',
    'Đánh giá hoạt động hỗ trợ sinh viên'
),

(
    'CNTT',
    'Công nghệ thông tin',
    'Đánh giá hệ thống công nghệ thông tin'
),

(
    'TV',
    'Thư viện',
    'Đánh giá chất lượng thư viện'
);


-- =====================================================================
-- 10.3 THÊM TIÊU CHÍ ĐÁNH GIÁ
-- =====================================================================

INSERT INTO criteria
(
    group_id,
    criteria_code,
    criteria_name,
    description,
    weight,
    scale_min,
    scale_max,
    is_active,
    created_by
)
VALUES

(
    1,
    'DT04',
    'Chương trình đào tạo được cập nhật thường xuyên',
    'Đánh giá mức độ cập nhật chương trình đào tạo',
    0.2000,
    1,
    5,
    1,
    1
),

(
    1,
    'DT05',
    'Mức độ đáp ứng nhu cầu doanh nghiệp',
    'Đánh giá khả năng đáp ứng yêu cầu thực tế',
    0.2000,
    1,
    5,
    1,
    1
),

(
    2,
    'NC02',
    'Chất lượng công bố khoa học',
    'Đánh giá chất lượng nghiên cứu khoa học',
    0.3000,
    1,
    5,
    1,
    1
),

(
    3,
    'CS02',
    'Chất lượng hệ thống máy tính',
    'Đánh giá trang thiết bị máy tính phục vụ học tập',
    0.3000,
    1,
    5,
    1,
    1
),

(
    4,
    'DV02',
    'Tốc độ giải quyết yêu cầu sinh viên',
    'Đánh giá thời gian phản hồi và hỗ trợ',
    0.3000,
    1,
    5,
    1,
    1
),

(
    5,
    'QL01',
    'Hiệu quả quản lý chất lượng',
    'Đánh giá hoạt động đảm bảo chất lượng',
    0.4000,
    1,
    5,
    1,
    1
),

(
    6,
    'GV01',
    'Năng lực chuyên môn của giảng viên',
    'Đánh giá kiến thức chuyên môn',
    0.5000,
    1,
    5,
    1,
    1
),

(
    7,
    'CT01',
    'Cấu trúc chương trình đào tạo hợp lý',
    'Đánh giá cấu trúc các học phần',
    0.4000,
    1,
    5,
    1,
    1
),

(
    8,
    'HT01',
    'Chất lượng tư vấn học tập',
    'Đánh giá hoạt động tư vấn sinh viên',
    0.4000,
    1,
    5,
    1,
    1
),

(
    9,
    'IT01',
    'Chất lượng hệ thống học trực tuyến',
    'Đánh giá hệ thống LMS',
    0.5000,
    1,
    5,
    1,
    1
);


-- =====================================================================
-- 10.4 THÊM KHẢO SÁT
-- =====================================================================

INSERT INTO surveys
(
    title,
    description,
    target_role,
    start_date,
    end_date,
    status,
    created_by
)
VALUES

(
    'Khảo sát chất lượng giảng dạy học kỳ 1',
    'Khảo sát ý kiến sinh viên về chất lượng giảng dạy',
    'STUDENT',
    '2026-09-05 08:00:00',
    '2026-10-05 23:59:59',
    'OPEN',
    2
),

(
    'Khảo sát cơ sở vật chất',
    'Đánh giá chất lượng phòng học và thiết bị',
    'STUDENT',
    '2026-09-10 08:00:00',
    '2026-10-10 23:59:59',
    'OPEN',
    2
),

(
    'Khảo sát dịch vụ sinh viên',
    'Đánh giá chất lượng hỗ trợ sinh viên',
    'STUDENT',
    '2026-09-15 08:00:00',
    '2026-10-15 23:59:59',
    'OPEN',
    2
),

(
    'Khảo sát hoạt động nghiên cứu khoa học',
    'Đánh giá hoạt động nghiên cứu khoa học',
    'LECTURER',
    '2026-09-20 08:00:00',
    '2026-10-20 23:59:59',
    'OPEN',
    2
),

(
    'Khảo sát chất lượng giảng viên',
    'Đánh giá chất lượng giảng viên',
    'STUDENT',
    '2026-10-01 08:00:00',
    '2026-10-30 23:59:59',
    'DRAFT',
    2
),

(
    'Khảo sát hệ thống công nghệ thông tin',
    'Đánh giá hệ thống CNTT của trường',
    'ALL',
    '2026-10-05 08:00:00',
    '2026-11-05 23:59:59',
    'DRAFT',
    2
),

(
    'Khảo sát thư viện',
    'Đánh giá chất lượng dịch vụ thư viện',
    'STUDENT',
    '2026-10-10 08:00:00',
    '2026-11-10 23:59:59',
    'DRAFT',
    2
),

(
    'Khảo sát chương trình đào tạo',
    'Đánh giá nội dung chương trình đào tạo',
    'STUDENT',
    '2026-10-15 08:00:00',
    '2026-11-15 23:59:59',
    'DRAFT',
    2
),

(
    'Khảo sát quản lý chất lượng',
    'Đánh giá hoạt động quản lý chất lượng',
    'LECTURER',
    '2026-10-20 08:00:00',
    '2026-11-20 23:59:59',
    'DRAFT',
    2
),

(
    'Khảo sát tổng thể chất lượng trường',
    'Khảo sát tổng thể chất lượng hoạt động',
    'ALL',
    '2026-11-01 08:00:00',
    '2026-12-01 23:59:59',
    'DRAFT',
    2
);


-- =====================================================================
-- 10.5 THÊM CÂU HỎI KHẢO SÁT
-- =====================================================================

INSERT INTO survey_questions
(
    survey_id,
    criteria_id,
    question_text,
    question_type,
    options_json,
    order_no
)
VALUES

(1, 1, 'Bạn đánh giá nội dung chương trình đào tạo như thế nào?', 'SCALE', NULL, 1),

(1, 2, 'Bạn đánh giá phương pháp giảng dạy của giảng viên như thế nào?', 'SCALE', NULL, 2),

(1, 3, 'Tài liệu học tập có đầy đủ và cập nhật không?', 'SCALE', NULL, 3),

(2, 5, 'Bạn đánh giá chất lượng phòng học như thế nào?', 'SCALE', NULL, 1),

(2, 10, 'Bạn đánh giá chất lượng hệ thống máy tính như thế nào?', 'SCALE', NULL, 2),

(3, 6, 'Bạn đánh giá chất lượng tư vấn sinh viên như thế nào?', 'SCALE', NULL, 1),

(4, 4, 'Bạn đánh giá hoạt động nghiên cứu khoa học như thế nào?', 'SCALE', NULL, 1),

(5, 12, 'Bạn đánh giá năng lực chuyên môn của giảng viên?', 'SCALE', NULL, 1),

(6, 15, 'Bạn đánh giá hệ thống học trực tuyến?', 'SCALE', NULL, 1),

(7, NULL, 'Bạn hài lòng với dịch vụ thư viện không?', 'SINGLE_CHOICE',
JSON_ARRAY('Rất hài lòng', 'Hài lòng', 'Bình thường', 'Không hài lòng'),
1);


-- =====================================================================
-- 10.6 THÊM PHIẾU KHẢO SÁT
-- =====================================================================

INSERT INTO survey_responses
(
    survey_id,
    user_id,
    submitted_at
)
VALUES

(1, 7, '2026-09-06 09:00:00'),
(1, 8, '2026-09-06 10:00:00'),
(1, 9, '2026-09-07 08:30:00'),
(2, 7, '2026-09-11 09:15:00'),
(2, 8, '2026-09-12 10:30:00'),
(3, 9, '2026-09-16 14:00:00'),
(3, 10, '2026-09-17 15:00:00'),
(4, 4, '2026-09-21 08:00:00'),
(4, 5, '2026-09-22 09:00:00'),
(5, 11, '2026-10-02 10:00:00');


-- =====================================================================
-- 10.7 THÊM CÂU TRẢ LỜI KHẢO SÁT
-- =====================================================================

INSERT INTO survey_answers
(
    response_id,
    question_id,
    answer_value,
    answer_text
)
VALUES

(1, 1, '5', 'Chương trình đào tạo khá phù hợp'),

(2, 1, '4', 'Nội dung chương trình tương đối tốt'),

(3, 2, '5', 'Giảng viên giảng dạy dễ hiểu'),

(4, 4, '4', 'Phòng học đáp ứng nhu cầu học tập'),

(5, 5, '4', 'Máy tính hoạt động ổn định'),

(6, 6, '5', 'Nhân viên hỗ trợ nhiệt tình'),

(7, 6, '4', 'Thời gian phản hồi khá nhanh'),

(8, 7, '4', 'Hoạt động nghiên cứu khoa học tốt'),

(9, 7, '5', 'Cần tiếp tục phát triển nghiên cứu'),

(10, 8, '5', 'Giảng viên có chuyên môn tốt');


-- =====================================================================
-- 10.8 THÊM KỲ ĐÁNH GIÁ
-- =====================================================================

INSERT INTO evaluation_periods
(
    period_name,
    start_date,
    end_date,
    status
)
VALUES

('Học kỳ 2 - Năm học 2025-2026', '2026-02-01', '2026-06-30', 'CLOSED'),

('Học kỳ 1 - Năm học 2025-2026', '2025-09-01', '2026-01-15', 'CLOSED'),

('Học kỳ hè - Năm học 2025-2026', '2026-07-01', '2026-08-15', 'CLOSED'),

('Đánh giá năm học 2024-2025', '2024-09-01', '2025-06-30', 'CLOSED'),

('Học kỳ 2 - Năm học 2024-2025', '2025-02-01', '2025-06-30', 'CLOSED'),

('Học kỳ 1 - Năm học 2024-2025', '2024-09-01', '2025-01-15', 'CLOSED'),

('Đánh giá giữa năm 2026', '2026-01-01', '2026-06-30', 'CLOSED'),

('Đánh giá cuối năm 2026', '2026-07-01', '2026-12-31', 'OPEN'),

('Đánh giá tổng kết năm 2026', '2026-01-01', '2026-12-31', 'OPEN'),

('Đánh giá chất lượng quý 3 năm 2026', '2026-07-01', '2026-09-30', 'OPEN');


-- =====================================================================
-- 10.9 THÊM ĐỐI TƯỢNG ĐÁNH GIÁ
-- =====================================================================

INSERT INTO evaluation_targets
(
    target_type,
    target_name,
    ref_id
)
VALUES

('DEPARTMENT', 'Khoa Công nghệ Thông tin', NULL),

('DEPARTMENT', 'Khoa Quản trị Kinh doanh', NULL),

('LECTURER', 'Giảng viên Lê Hoàng Nam', 4),

('LECTURER', 'Giảng viên Phạm Thị Hương', 5),

('LECTURER', 'Giảng viên Võ Quốc Anh', 6),

('COURSE', 'Lập trình hướng đối tượng', NULL),

('COURSE', 'Cơ sở dữ liệu', NULL),

('SERVICE', 'Phòng Công tác Sinh viên', NULL),

('SERVICE', 'Thư viện trường', NULL),

('SERVICE', 'Hệ thống học trực tuyến LMS', NULL);


-- =====================================================================
-- 10.10 THÊM ĐIỂM ĐÁNH GIÁ
-- =====================================================================

INSERT INTO evaluation_scores
(
    period_id,
    target_id,
    criteria_id,
    raw_score,
    weighted_score,
    method
)
VALUES

(1, 1, 1, 4.5000, 1.3500, 'AVERAGE'),

(1, 1, 2, 4.7000, 1.4100, 'AVERAGE'),

(1, 2, 1, 4.2000, 1.2600, 'AVERAGE'),

(1, 3, 2, 4.8000, 1.4400, 'AVERAGE'),

(1, 4, 2, 4.6000, 1.3800, 'AVERAGE'),

(1, 5, 12, 4.7000, 2.3500, 'AVERAGE'),

(1, 6, 3, 4.3000, 0.8600, 'AVERAGE'),

(1, 7, 4, 4.1000, 2.0500, 'AVERAGE'),

(1, 8, 6, 4.6000, 1.8400, 'AVERAGE'),

(1, 10, 15, 4.5000, 2.2500, 'AVERAGE');


-- =====================================================================
-- 10.11 THÊM MA TRẬN AHP
-- =====================================================================

INSERT INTO ahp_matrices
(
    group_id,
    criteria_a_id,
    criteria_b_id,
    comparison_value,
    created_by
)
VALUES

(1, 1, 2, 1.000, 1),

(1, 1, 3, 3.000, 1),

(1, 2, 3, 2.000, 1),

(2, 4, 11, 2.000, 1),

(3, 5, 10, 3.000, 1),

(4, 6, 13, 2.000, 1),

(5, 11, 11, 1.000, 1),

(6, 12, 12, 1.000, 1),

(7, 13, 13, 1.000, 1),

(9, 15, 15, 1.000, 1);


-- =====================================================================
-- 10.12 THÊM XẾP HẠNG CHẤT LƯỢNG
-- =====================================================================

INSERT INTO quality_rankings
(
    period_id,
    target_id,
    total_score,
    rank_no,
    rank_label
)
VALUES

(1, 3, 4.8500, 1, 'Xuất sắc'),

(1, 4, 4.7500, 2, 'Xuất sắc'),

(1, 5, 4.7000, 3, 'Xuất sắc'),

(1, 1, 4.6500, 4, 'Tốt'),

(1, 2, 4.5000, 5, 'Tốt'),

(1, 6, 4.4000, 6, 'Tốt'),

(1, 7, 4.3000, 7, 'Khá'),

(1, 8, 4.2000, 8, 'Khá'),

(1, 9, 4.1000, 9, 'Khá'),

(1, 10, 4.0000, 10, 'Khá');


-- =====================================================================
-- 10.13 THÊM BÁO CÁO
-- =====================================================================

INSERT INTO reports
(
    period_id,
    title,
    file_path,
    generated_by,
    generated_at
)
VALUES

(1, 'Báo cáo chất lượng tổng thể học kỳ 1', '/reports/report_01.pdf', 2, NOW()),

(1, 'Báo cáo chất lượng giảng dạy', '/reports/report_02.pdf', 2, NOW()),

(1, 'Báo cáo cơ sở vật chất', '/reports/report_03.pdf', 2, NOW()),

(1, 'Báo cáo dịch vụ sinh viên', '/reports/report_04.pdf', 2, NOW()),

(1, 'Báo cáo nghiên cứu khoa học', '/reports/report_05.pdf', 2, NOW()),

(1, 'Báo cáo chất lượng giảng viên', '/reports/report_06.pdf', 2, NOW()),

(1, 'Báo cáo chương trình đào tạo', '/reports/report_07.pdf', 2, NOW()),

(1, 'Báo cáo hệ thống công nghệ thông tin', '/reports/report_08.pdf', 2, NOW()),

(1, 'Báo cáo chất lượng thư viện', '/reports/report_09.pdf', 2, NOW()),

(1, 'Báo cáo xếp hạng chất lượng', '/reports/report_10.pdf', 2, NOW());


-- =====================================================================
-- 10.14 THÊM NHẬT KÝ ĐĂNG NHẬP
-- =====================================================================

INSERT INTO login_logs
(
    user_id,
    action,
    ip_address,
    created_at
)
VALUES

(1, 'LOGIN', '127.0.0.1', NOW()),

(2, 'LOGIN', '127.0.0.1', NOW()),

(3, 'LOGIN', '127.0.0.1', NOW()),

(4, 'LOGIN', '127.0.0.1', NOW()),

(7, 'LOGIN', '127.0.0.1', NOW()),

(8, 'LOGIN', '127.0.0.1', NOW()),

(1, 'CHANGE_PASSWORD', '127.0.0.1', NOW()),

(2, 'LOGOUT', '127.0.0.1', NOW()),

(4, 'LOGOUT', '127.0.0.1', NOW()),

(1, 'LOGOUT', '127.0.0.1', NOW());


-- =====================================================================
-- KIỂM TRA TOÀN BỘ DỮ LIỆU
-- =====================================================================

SELECT * FROM roles;

SELECT * FROM users;

SELECT * FROM criteria_groups;

SELECT * FROM criteria;

SELECT * FROM surveys;

SELECT * FROM survey_questions;

SELECT * FROM survey_responses;

SELECT * FROM survey_answers;

SELECT * FROM evaluation_periods;

SELECT * FROM evaluation_targets;

SELECT * FROM evaluation_scores;

SELECT * FROM ahp_matrices;

SELECT * FROM quality_rankings;

SELECT * FROM reports;

SELECT * FROM login_logs;


-- =====================================================================
-- KIỂM TRA DỮ LIỆU
-- =====================================================================

SELECT * FROM roles;

SELECT * FROM users;

SELECT * FROM criteria_groups;

SELECT * FROM criteria;

SELECT * FROM evaluation_periods;

SHOW TABLES;