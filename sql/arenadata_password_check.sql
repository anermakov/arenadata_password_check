-- Load the extension to enable the tests
LOAD 'arenadata_password_check';

-- Restrictive policy
SET arenadata_password_check.minimum_length TO 8;
SET arenadata_password_check.maximum_length TO 15;
SET arenadata_password_check.special_chars TO '%$?@';
SET arenadata_password_check.restrict_lower TO true;
SET arenadata_password_check.restrict_upper TO true;
SET arenadata_password_check.restrict_numbers TO true;

-- Check password policy in place
-- Password too short
CREATE ROLE regress_pwd_foo PASSWORD '01234';
-- Password too long
CREATE ROLE regress_pwd_foo PASSWORD '01234567890123456';
-- Invalid characters
CREATE ROLE regress_pwd_foo PASSWORD '```````````````';

-- Three categories missing
-- Lower-case, upper-case, special character missing
CREATE ROLE regress_pwd_foo PASSWORD '012345678901234';
-- Number, upper-case, special character missing
CREATE ROLE regress_pwd_foo PASSWORD 'abcdefghijklmno';
-- Number, lower-case, special character missing
CREATE ROLE regress_pwd_foo PASSWORD 'ABCDEFGHIJKLMNO';
-- Number, lower-case, upper-case character missing
CREATE ROLE regress_pwd_foo PASSWORD '%%%%%%%%%%%%%%%';

-- Two categories missing
-- Number, special character missing
CREATE ROLE regress_pwd_foo PASSWORD 'abcdefghijklmnA';
-- Upper-case character, special character missing
CREATE ROLE regress_pwd_foo PASSWORD '01234567890123a';
-- Lower-case character, special character missing
CREATE ROLE regress_pwd_foo PASSWORD '01234567890123A';
-- Number, upper case missing
CREATE ROLE regress_pwd_foo PASSWORD 'abcdefghijklmn%';
-- Number, lower-case missing
CREATE ROLE regress_pwd_foo PASSWORD 'ABCDEFGHIJKLMN%';
-- Upper-case, lower-case missing
CREATE ROLE regress_pwd_foo PASSWORD '01234567890123%';

-- One category missing
-- Special character missing
CREATE ROLE regress_pwd_foo PASSWORD '0123456789012aA';
-- Upper-case missing
CREATE ROLE regress_pwd_foo PASSWORD '0123456789012a%';
-- Lower-case missing
CREATE ROLE regress_pwd_foo PASSWORD '0123456789012A%';
-- Number missing
CREATE ROLE regress_pwd_foo PASSWORD 'ABCDEFGHIJKLMa%';

-- Valid password
CREATE ROLE regress_pwd_foo PASSWORD '012345678901Aa%';
DROP ROLE regress_pwd_foo;

-- Policy less restrictive
SET arenadata_password_check.restrict_lower TO false;
SET arenadata_password_check.restrict_upper TO false;
SET arenadata_password_check.restrict_numbers TO false;
SET arenadata_password_check.minimum_length TO 1;
SET arenadata_password_check.maximum_length TO 100;

-- Special character missing
CREATE ROLE regress_pwd_foo PASSWORD '012345678901Aa';
-- Valid password
CREATE ROLE regress_pwd_foo PASSWORD '@%';
DROP ROLE regress_pwd_foo;

-- Even less restrictive policy
SET arenadata_password_check.restrict_special TO false;
-- Valid password
CREATE ROLE regress_pwd_foo PASSWORD 'A';
DROP ROLE regress_pwd_foo;
