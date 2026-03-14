-- SUN: 240161226

/* SKILL SCHEMA */
CREATE TABLE Skill (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    skill_type VARCHAR(100) NOT NULL,
    UNIQUE (skill_name, skill_type)
);

/* CLIENT SCHEMA */
CREATE TABLE Client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    org_name VARCHAR(150),
    first_name VARCHAR(100) NOT NULL,
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
        CHECK (budget IS NULL OR budget >= 0)
);

/* POOLMEMBER SCHEMA */
CREATE TABLE PoolMember (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(30),
    work_address VARCHAR(255),
    home_address VARCHAR(255),
    project_id INT NULL,

    CONSTRAINT fk_poolmember_project
        FOREIGN KEY (project_id)
        REFERENCES Project(project_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

/* POOLMEMBER_SKILL SCHEMA */
CREATE TABLE PoolMemberSkill (
    member_id INT NOT NULL,
    skill_id INT NOT NULL,
    experience_level ENUM('junior', 'mid', 'expert') NOT NULL,

    PRIMARY KEY (member_id, skill_id),

    CONSTRAINT fk_pms_member
        FOREIGN KEY (member_id)
        REFERENCES PoolMember(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_pms_skill
        FOREIGN KEY (skill_id)
        REFERENCES Skill(skill_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* PROJECTSKILL SCHEMA */
CREATE TABLE ProjectSkill (
    project_id INT NOT NULL,
    skill_id INT NOT NULL,

    PRIMARY KEY (project_id, skill_id),

    CONSTRAINT fk_ps_project
        FOREIGN KEY (project_id)
        REFERENCES Project(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_ps_skill
        FOREIGN KEY (skill_id)
        REFERENCES Skill(skill_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE 
);