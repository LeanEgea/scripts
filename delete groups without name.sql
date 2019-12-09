use groupstest;
SELECT * FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.name IS NULL;
SELECT * FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
where gr.name IS NULL;
SELECT * FROM groupstest.group WHERE name IS NULL;

/*SET SQL_SAFE_UPDATES = 0;
DELETE un FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.name IS NULL;
DELETE re FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.name IS NULL;
DELETE gr FROM groupstest.group gr WHERE gr.name IS NULL;
SET SQL_SAFE_UPDATES = 1;*/