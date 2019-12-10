-- con esta query obtengo todos los grupos donde hay usuarios que no estan en mpusersdb
SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
WHERE un.user_id NOT IN (
	SELECT cid FROM (
		SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
	) AS c
);
-- usando query anterior obtengo los usuarios registrados y no registrados que estan en esos grupos
SELECT re.user_id, re.group_id FROM groupstest.reg_user_x_group re
WHERE re.group_id IN (
	SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
	WHERE un.user_id NOT IN (
		SELECT cid FROM (
			SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
		) AS c
    )
);
SELECT unr.user_id, unr.group_id FROM groupstest.unreg_user_x_group unr
WHERE unr.group_id IN (
	SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
	WHERE un.user_id NOT IN (
		SELECT cid FROM (
			SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
		) AS c
    )
);
SELECT unr.user_id, unr.group_id FROM groupstest.unreg_user_x_group unr
INNER JOIN groupstest.unreg_user_x_group un ON unr.user_id=un.user_id AND unr.group_id = un.group_id
WHERE un.group_id IN (
	SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
	WHERE un.user_id NOT IN (
		SELECT cid FROM (
			SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
		) AS c
    )
);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM groupstest.reg_user_x_group
WHERE group_id IN (
	SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
	WHERE un.user_id NOT IN (
		SELECT cid FROM (
			SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
		) AS c
    )
);
-- ESTA NO ANDA
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
	WHERE un.user_id NOT IN (
		SELECT cid FROM (
			SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
		) AS c
    )
);
-- despues de estos usar el que te elimina los grupos vacios

-- NO usar esta, borra los usuarios que no estan en mpusersdb, pero no sus grupos
-- crea inconsistencias
/*DELETE un FROM groupstest.unreg_user_x_group un
WHERE un.user_id NOT IN (
	SELECT cid FROM (
		SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
	) AS c
);*/
SET SQL_SAFE_UPDATES = 1;
