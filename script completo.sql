-- ELIMINO GRUPOS SIN NOMBRE
use groupstest;
SET SQL_SAFE_UPDATES = 0;
DELETE un FROM groupstest.unreg_user_x_group un
INNER JOIN groupstest.group gr ON un.group_id=gr.id
WHERE gr.name IS NULL OR gr.name = '';
DELETE re FROM groupstest.reg_user_x_group re
INNER JOIN groupstest.group gr ON re.group_id=gr.id
WHERE gr.name IS NULL OR gr.name = '';
DELETE gr FROM groupstest.group gr WHERE gr.name IS NULL OR gr.name = '';
SET SQL_SAFE_UPDATES = 1;

-- ELIMINO GRUPOS QUE CONTIENEN USUARIOS QUE NO ESTAN EN MPUSERSDB
use mpusersdb;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE TemporaryUnreg (group_id varchar(128));
INSERT INTO TemporaryUnreg (group_id)
SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
WHERE un.user_id NOT IN (
	SELECT cid FROM (
		SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
	) AS c
);
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT te.group_id AS gid FROM mpusersdb.TemporaryUnreg te
	) AS g
);
DELETE FROM TemporaryUnreg;
-- DROP TABLE TemporaryUnreg;
SET SQL_SAFE_UPDATES = 1;

-- ELIMINO GRUPOS QUE CONTIENEN MENOS DE 2 PARTICIPANTES
use groupstest;
SET SQL_SAFE_UPDATES = 0;
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
SET SQL_SAFE_UPDATES = 1;