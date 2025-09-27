USAGE:

Восстановить базу из дампа: для memorial_db_backtwo.sql
pg_restore -U <пользователь> -h <хост> -p <порт> -d <имя_новой_бд> -v backup.dump
Пример:
createdb -U postgres newdb
pg_restore -U postgres -h localhost -p 5432 -d newdb -v mydb_full.dump

или для memorial_db_backtwo.sql
psql -U postgres -h localhost -p 5432 -d newdb -f mydb_full.sql

0. 	up database
1.	npm install
2.	node server.js 