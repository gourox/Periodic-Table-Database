
#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Check if an argument is provided
if [ -z "$1" ]; then
        echo "Please provide an element as an argument."

#Check if the input is a number
elif [[ $1 =~ ^-?[0-9]+$ ]]; then

        #Query element's atomic number
        ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")"

        #if not found
        if [ -z "$ATOMIC_NUMBER" ]; then
                #echo not found
                echo "I could not find that element in the database."

        #else query name, symbol, type, mass, melting point, and boiling point
        else
                NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$1;")"
		SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1;")"
                TYPE="$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$1;")"
                if [[ $TYPE -eq 1 ]]; then
                         TYPE="nonmetal"
                elif [[ $TYPE -eq 2 ]]; then
                         TYPE="metal"
                else
                         TYPE="metalloid"
                 fi
		ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1;")"
		MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1;")"
		BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1;")"
		
		#output result
		echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

	fi

#Check if input is a symbol
elif [[ ${#1} -le 2 ]]; then
#Query element's atomic number
        ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")"

        #if not found
        if [ -z "$ATOMIC_NUMBER" ]; then
                #echo not found
                echo "I could not find that element in the database."

        #else query name, symbol, type, mass, melting point, and boiling point
        else
                NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number='$ATOMIC_NUMBER';")"
                SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ATOMIC_NUMBER';")"
                TYPE="$($PSQL "SELECT type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                if [[ $TYPE -eq 1 ]]; then
                         TYPE="nonmetal"
                elif [[ $TYPE -eq 2 ]]; then
                         TYPE="metal"
                else
                         TYPE="metalloid"
                 fi
                ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"

                #output result
		echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

        fi
#Input is a name
else
 #Query element's atomic number
        ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")"

        #if not found
        if [ -z "$ATOMIC_NUMBER" ]; then
                #echo not found
                echo "I could not find that element in the database."

        #else query name, symbol, type, mass, melting point, and boiling point
        else
                NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number='$ATOMIC_NUMBER';")"
                SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ATOMIC_NUMBER';")"
                TYPE="$($PSQL "SELECT type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                if [[ $TYPE -eq 1 ]]; then
                         TYPE="nonmetal"
                elif [[ $TYPE -eq 2 ]]; then
                         TYPE="metal"
                else
                         TYPE="metalloid"
                 fi
                ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"
                BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number='$ATOMIC_NUMBER';")"

                #output result
		echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        fi
fi
