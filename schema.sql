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

/* PROJECT SCHEMA */
CREATE TABLE Project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    budget DECIMAL(10,2) NULL,
    description TEXT NULL,
    phase ENUM('design', 'development', 'testing', 'deployment', 'complete') NOT NULL DEFAULT 'design',

    CONSTRAINT fk_project_client
        FOREIGN KEY (client_id) REFERENCES Client(client_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_project_dates
        CHECK (end_date IS NULL OR end_date >= start_date),

    CONSTRAINT chk_project_budget
        check (budget IS NULL OR budget >= 0)
);