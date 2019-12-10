use groupstest;
SELECT * FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.creator_user_id = -1;
SELECT * FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.creator_user_id = -1;
SELECT * FROM groupstest.group WHERE creator_user_id = -1;
SELECT * FROM groupstest.reg_user_x_group re WHERE re.user_id=-1;

/*SET SQL_SAFE_UPDATES = 0;
-- Borro donde es collector
DELETE un FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.creator_user_id = -1;

DELETE re FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.creator_user_id = -1;

DELETE gr FROM groupstest.group gr WHERE gr.creator_user_id = -1;

-- Borro donde es participante
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.reg_user_x_group re ON gr.id=re.user_id
        WHERE re.user_id = -1 
		GROUP BY gr.id
	) AS g
);

DELETE FROM groupstest.reg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.reg_user_x_group re ON gr.id=re.user_id
        WHERE re.user_id = -1 
		GROUP BY gr.id
	) AS g
);

DELETE FROM groupstest.group
WHERE id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.reg_user_x_group re ON gr.id=re.user_id
        WHERE re.user_id = -1 
		GROUP BY gr.id
	) AS g
);
SET SQL_SAFE_UPDATES = 1;*/