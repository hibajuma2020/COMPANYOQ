SELECT SUSER_SNAME() AS who_am_i;
SELECT IS_SRVROLEMEMBER('sysadmin') AS am_i_sysadmin;
SELECT IS_SRVROLEMEMBER('dbcreator') AS am_i_dbcreator;