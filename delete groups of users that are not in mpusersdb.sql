use groupstest;
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

-------------------------------------------------- DELETES -----------------------------------------------
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
-- creo una tabla temporal para guardar los id de los grupos que voy a borrar
use mpusersdb;
-- CREATE TABLE TemporaryUnreg (group_id varchar(128));
INSERT INTO TemporaryUnreg (group_id)
SELECT DISTINCT un.group_id AS gid FROM groupstest.unreg_user_x_group un
WHERE un.user_id NOT IN (
	SELECT cid FROM (
		SELECT DISTINCT uu.contact_id AS cid FROM mpusersdb.unregistered_user uu
	) AS c
);
-- SELECT * FROM TemporaryUnreg;
DELETE FROM groupstest.unreg_user_x_group
WHERE group_id IN (
	SELECT gid FROM (
		SELECT te.group_id AS gid FROM mpusersdb.TemporaryUnreg te
	) AS g
);
DELETE FROM TemporaryUnreg;
-- DROP TABLE TemporaryUnreg;

-- despues de estos usar el que te elimina los grupos vacios
SET SQL_SAFE_UPDATES = 1;
