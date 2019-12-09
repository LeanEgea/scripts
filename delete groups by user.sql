use groupstest;
SELECT * FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.creator_user_id = 209915215;
SELECT * FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.creator_user_id = 209915215;
SELECT * FROM groupstest.group WHERE creator_user_id = 209915215;
SELECT * FROM groupstest.reg_user_x_group re WHERE re.user_id=209915215;

/*SET SQL_SAFE_UPDATES = 0;
DELETE un FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.creator_user_id = -1;
DELETE re FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.creator_user_id = -1;
DELETE gr FROM groupstest.group gr WHERE gr.creator_user_id = -1;
DELETE re FROM groupstest.reg_user_x_group re WHERE re.user_id= -1;
SET SQL_SAFE_UPDATES = 1;*/