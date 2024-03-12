#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi
  if [[ $1 =~ ^[1-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where atomic_number = '$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      SYMBOL=$($PSQL "select symbol from elements where atomic_number = $ATOMIC_NUMBER")
      NAME=$($PSQL "select name from elements where atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "select type from types inner join properties using(type_id) where properties.atomic_number = $ATOMIC_NUMBER")
      MASS=$($PSQL "select atomic_mass from properties where atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
    
  else
    ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name = '$1' or symbol = '$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      SYMBOL=$($PSQL "select symbol from elements where atomic_number = $ATOMIC_NUMBER")
      NAME=$($PSQL "select name from elements where atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "select type from types inner join properties using(type_id) where properties.atomic_number = $ATOMIC_NUMBER")
      MASS=$($PSQL "select atomic_mass from properties where atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  fi