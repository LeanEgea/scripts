use groupstest;

SELECT DISTINCT gr.id FROM groupstest.group gr
INNER JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
WHERE un.user_id = '-1'
GROUP BY gr.id;

/*SET SQL_SAFE_UPDATES = 0;
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
        WHERE un.user_id = '-1' 
		GROUP BY gr.id
	) AS g
);

DELETE FROM groupstest.reg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
        WHERE un.user_id = '-1' 
		GROUP BY gr.id
	) AS g
);

DELETE FROM groupstest.group
WHERE id IN (
	SELECT gid FROM (
		SELECT DISTINCT gr.id AS gid FROM groupstest.group gr
		INNER JOIN groupstest.unreg_user_x_group un ON gr.id=un.group_id
        WHERE un.user_id = '-1' 
		GROUP BY gr.id
	) AS g
);
SET SQL_SAFE_UPDATES = 1;*/