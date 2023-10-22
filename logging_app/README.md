# README

Сделал Тепляков Антон Андреевич
Для запуска соберите образ командой docker-compose build и запустите его командой docker-compose up
Примеры обращения к Api методам:
1) Для входа на мероприятие используйте localhost:3000/enter?id_ticket=1&category=VIP
2) Для выхода с мероприятия используйте localhost:3000/exit?id_ticket=1&category=VIP
3) Для блокировки билета используйте localhost:3000/block?id_ticket=1&doc_num=22
4) Для просмотра логов используйте localhost:3000/logs
5) Логи можно фильтровать указывая конкретные параметры (по одиночке или вместе), например localhost:3007/logs?name=Anton&type=exit&result=true&date=2023-10-23
