/* SKILLS SCHEMA */
CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    skill_type VARCHAR(100) NOT NULL,
    UNIQUE (skill_name, skill_type)
);

