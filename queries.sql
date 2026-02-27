/* INSERT SKILLS */
INSERT INTO Skill (skill_name, skill_type) VALUES
('PHP', 'Backend'),
('Python', 'Backend'),
('JavaScript', 'Frontend'),
('Postman', 'Testing'),
('MySQL', 'Database'),
('Figma', 'Design');

/* INSERT CLIENTS */
INSERT INTO Client
(org_name, first_name, last_name, email, address, contact_preference)
VALUES
('Something Solutions Ltd', 'Sarah', 'Khan', 'sarah.khan@somethingsolutions.co.uk',
'12 Burlington St, Birmingham, B12 4AJ', 'email'),

('Haaris Ali Welfare', 'Haaris', 'Ali', 'haaris.ali@haarisaliwelfare.co.uk',
'31 Broad St, Reading, RG21 7ET', 'post');

/* INSERT POOL MEMBERS */
INSERT INTO PoolMember
(first_name, last_name, email, phone, work_address, home_address, project_id)
VALUES
('Hasnain', 'Amir', 'info@hasnainamir.com', '07111 222333',
'10 Jennens Road, Birmingham, B4 7ET', '17 Mill Lane, Birmingham, B24 4LT', NULL),

('Komal', 'Zareen', 'komal.zareen@romans.com', '07123 456789',
'37 Silverdale Road, Reading, RG6 4BV', '203 Wokingham Road, Reading, RG6 6EN', NULL);

/* INSERT PROJECT */
INSERT INTO Project
(client_id, title, start_date, end_date, budget, description, phase)
VALUES
(
    (SELECT client_id FROM Client WHERE org_name = 'Something Solutions Ltd' LIMIT 1),
    'Client Portal Redesign',
    '2026-02-27',
    NULL,
    7500.00,
    'Redesign and rebuild of the client portal with improved user experience and testing coverage',
    'design'
);

/* LINK PROJECT */
INSERT INTO ProjectSkill (project_id, skill_id)
VALUES
(
    (SELECT project_id FROM Project WHERE title = 'Client Portal Redesign' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'JavaScript' LIMIT 1)
),
(
    (SELECT project_id FROM Project WHERE title = 'Client Portal Redesign' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'Figma' LIMIT 1)
);

/* ASSIGN SKILLS */
INSERT INTO PoolMemberSkill (member_id, skill_id, experience_level)
VALUES
(
    (SELECT member_id FROM PoolMember WHERE email = 'info@hasnainamir.com' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'MySQL' LIMIT 1),
    'expert'
),
(
    (SELECT member_id FROM PoolMember WHERE email = 'info@hasnainamir.com' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'Python' LIMIT 1),
    'mid'
),
(
    (SELECT member_id FROM PoolMember WHERE email = 'komal.zareen@romans.com' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'JavaScript' LIMIT 1),
    'junior'
),
(
    (SELECT member_id FROM PoolMember WHERE email = 'komal.zareen@romans.com' LIMIT 1),
    (SELECT skill_id FROM Skill WHERE skill_name = 'Figma' LIMIT 1),
    'mid'
);

/* SELECT: Find pool members matching project skill requirements */
SELECT pm.member_id, pm.first_name, pm.last_name
FROM PoolMember pm
JOIN PoolMemberSkill pms ON pm.member_id = pms.member_id
JOIN ProjectSkill ps ON pms.skill_id = ps.skill_id
WHERE ps.project_id = (
    SELECT project_id FROM Project
    WHERE title = 'Client Portal Redesign' LIMIT 1
)
GROUP BY pm.member_id, pm.first_name, pm.last_name
HAVING COUNT(DISTINCT pms.skill_id) = (
    SELECT COUNT(DISTINCT skill_id)
    FROM ProjectSkill
    WHERE project_id = (
        SELECT project_id FROM Project
        WHERE title = 'Client Portal Redesign' LIMIT 1
    )
);

/* UPDATE POOL MEMBERS: assign to the project */
UPDATE PoolMember pm
SET pm.project_id = (
    SELECT project_id FROM Project
    WHERE title = 'Client Portal Redesign' LIMIT 1
)
WHERE pm.member_id IN (
    SELECT member_id FROM (
        SELECT pms.member_id
        FROM PoolMemberSkill pms
        JOIN ProjectSkill ps ON ps.skill_id = pms.skill_id
        WHERE ps.project_id = (
            SELECT project_id FROM Project
            WHERE title = 'Client Portal Redesign' LIMIT 1
        )
        GROUP BY pms.member_id
        HAVING COUNT(DISTINCT ps.skill_id) = (
            SELECT COUNT(DISTINCT skill_id) FROM ProjectSkill
            WHERE project_id = (
                SELECT project_id FROM Project
                WHERE title = 'Client Portal Redesign' LIMIT 1
            )
        ) 
    ) AS matched_members
);

/* REPORT: All pool members and their skills with experience levels */
SELECT
    pm.member_id,
    pm.first_name,
    pm.last_name,
    pm.email,
    s.skill_name,
    s.skill_type,
    pms.experience_level
FROM PoolMember pm
LEFT JOIN PoolMemberSkill pms
    ON pm.member_id = pms.member_id
LEFT JOIN Skill s
    ON pms.skill_id = s.skill_id
ORDER BY
    pm.member_id,
    s.skill_type,
    s.skill_name;

/* REPORT: All projects and their assigned members */
SELECT
    p.project_id,
    p.title,
    c.org_name AS client,
    pm.member_id,
    pm.first_name,
    pm.last_name,
    pm.email
FROM Project p
JOIN Client c
    ON p.client_id = c.client_id
LEFT JOIN PoolMember pm
    ON p.project_id = pm.project_id
ORDER BY p.project_id, pm.member_id;

/* REPORT: Skills grouped by type */
SELECT
    skill_type,
    skill_name
FROM Skill
ORDER BY skill_type, skill_name;