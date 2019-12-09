use groupstest;

/*SET SQL_SAFE_UPDATES = 0;
DELETE un FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.id = '-1';

DELETE re FROM groupstest.reg re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.id = '-1';

DELETE gr FROM groupstest.group gr
WHERE gr.id = '-1';
SET SQL_SAFE_UPDATES = 1;*/