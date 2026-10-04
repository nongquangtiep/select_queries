-- =================================================================
-- PHẦN 1: TẠO CƠ SỞ DỮ LIỆU
-- =================================================================
DROP DATABASE IF EXISTS QuanLySinhVien;
CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

-- =================================================================
-- PHẦN 2: TẠO CẤU TRÚC CÁC BẢNG (SCHEMA)
-- =================================================================

-- 1. Bảng Lớp học (Class)
CREATE TABLE Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

-- 2. Bảng Sinh viên (Student)
CREATE TABLE Student (
    StudentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    CONSTRAINT FK_Student_Class FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

-- 3. Bảng Môn học (Subject)
CREATE TABLE Subject (
    SubID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

-- 4. Bảng Điểm số (Mark)
CREATE TABLE Mark (
    MarkID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    CONSTRAINT FK_Mark_Subject FOREIGN KEY (SubId) REFERENCES Subject (SubID),
    CONSTRAINT FK_Mark_Student FOREIGN KEY (StudentId) REFERENCES Student (StudentID)
);

-- =================================================================
-- PHẦN 3: THÊM DỮ LIỆU MẪU (INSERT DATA)
-- =================================================================

-- Chèn dữ liệu vào bảng Class
INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES 
    (1, 'A1', '2008-12-20', 1),
    (2, 'A2', '2008-12-22', 1),
    (3, 'B3', CURRENT_DATE, 0);

-- Chèn dữ liệu vào bảng Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);

INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

-- Chèn dữ liệu vào bảng Subject
INSERT INTO Subject (SubID, SubName, Credit, Status)
VALUES 
    (1, 'CF', 5, 1),
    (2, 'C', 6, 1),
    (3, 'HDJ', 5, 1),
    (4, 'RDBMS', 10, 1);

-- Chèn dữ liệu vào bảng Mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES 
    (1, 1, 8, 1),
    (1, 2, 10, 2),
    (2, 1, 12, 1);

-- =================================================================
-- PHẦN 4: CÁC CÂU LỆNH TRUY VẤN DỮ LIỆU (SELECT QUERIES)
-- =================================================================

-- 1. Hiển thị danh sách tất cả các học viên
SELECT * 
FROM Student;

-- 2. Hiển thị danh sách các học viên đang theo học (Status = true hoặc 1)
SELECT * 
FROM Student 
WHERE Status = true;

-- 3. Hiển thị danh sách các môn học có thời gian học (Credit) nhỏ hơn 10 giờ
SELECT * 
FROM Subject 
WHERE Credit < 10;

-- 4. Hiển thị danh sách học viên lớp A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Hiển thị điểm môn CF của các học viên
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';