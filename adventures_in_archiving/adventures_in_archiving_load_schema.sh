#!/bin/bash
echo "Dropping adventures_in_archiving; creating adventures_in_archiving and loading data"
mysql -e 'drop schema if exists adventures_in_archiving; create schema adventures_in_archiving;'
mysql adventures_in_archiving < adventures_in_archiving_schema.sql
if [ -f "./adventures_in_archiving_data.sql" ]; then
  time mysql adventures_in_archiving < adventures_in_archiving_data.sql
else
  echo "Running adventures_in_archiving_data_gen.sh to regenerate adventures_in_archiving_data.sql"
  echo "Go grab a coffee or five, this will take a while ..."
  time bash ./adventures_in_archiving_data_gen.sh
  time mysql adventures_in_archiving < adventures_in_archiving_data.sql
fi
