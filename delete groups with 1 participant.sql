use groupstest;

-- todos los grupos donde hay 0 o 1 usuario
SELECT DISTINCT gr.id, COUNT(un.user_id) + COUNT(re.user_id) FROM groupstest.group gr
LEFT JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
LEFT JOIN groupstest.reg_user_x_group re ON gr.id=re.group_id
GROUP BY gr.id
HAVING (COUNT(un.user_id) + COUNT(re.user_id)) < 2;

/*SET SQL_SAFE_UPDATES = 0;
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		LEFT JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
		LEFT JOIN groupstest.reg_user_x_group re ON gr.id=re.group_id
		GROUP BY gr.id
		HAVING (COUNT(un.user_id) + COUNT(re.user_id)) < 2
	) AS g
);
DELETE FROM groupstest.reg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		LEFT JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
		LEFT JOIN groupstest.reg_user_x_group re ON gr.id=re.group_id
		GROUP BY gr.id
		HAVING (COUNT(un.user_id) + COUNT(re.user_id)) < 2
	) AS g
);
DELETE FROM groupstest.group
WHERE id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		LEFT JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
		LEFT JOIN groupstest.reg_user_x_group re ON gr.id=re.group_id
		GROUP BY gr.id
		HAVING (COUNT(un.user_id) + COUNT(re.user_id)) < 2
	) AS g
);
SET SQL_SAFE_UPDATES = 1;*/