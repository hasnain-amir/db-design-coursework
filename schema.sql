/* SKILLS SCHEMA */
CREATE TABLE Skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    skill_type VARCHAR(100) NOT NULL,
    UNIQUE (skill_name, skill_type)
);

/* CLIENT SCHEMA */
CREATE TABLE Client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    org_name VARCHAR(150),
    first_name varchar(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    address VARCHAR(255),
    contact_preference ENUM('post', 'email') NOT NULL
);