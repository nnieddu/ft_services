CREATE DATABASE gra_db;
CREATE USER 'gra_user' IDENTIFIED BY 'nini';
GRANT ALL PRIVILEGES ON gra_db.* TO 'gra_user';
FLUSH PRIVILEGES;