sh import_db.sh & PIDIOS=$!
sh start_mysql.sh & PIDMIX=$!
wait $PIDIOS
wait $PIDMIX