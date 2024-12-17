#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Welcome Message
echo -e "\n~~~ Sameer's Salon ~~~\n"

# Displaying Services
SHOW_SERVICES() {
  # Error Message
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Welcome to my salon. What service would you like?"
  
  # Showing all services
  AVAILABLE_SERVICES=$($PSQL "SELECT * FROM services ORDER BY service_id")
  echo "$AVAILABLE_SERVICES" | while read ID BAR SERVICE
  do
    echo "$ID) $SERVICE"
  done

  # Reading input from user and going to specific function based on input
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    [1-5]) APPOINTMENT_SCHEDULE $SERVICE_ID_SELECTED ;;
    6) EXIT ;;
    *) SHOW_SERVICES "That service is not available." ;;
  esac
}

# Making Appointment with Chosen Service
APPOINTMENT_SCHEDULE() {
  # Asking for phone number
  echo -e "\nPlease enter your phone number (Example 555-555-5555):"
  read CUSTOMER_PHONE

  # Checking if user already an existing customer
  GET_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $GET_NAME ]]
  # Creating new customer if name NOT found
  then
    echo -e "\nOur records show you are not yet a customer.\nPlease enter your name:"
    read CUSTOMER_NAME
    NEW_CUSTOMER_INSERT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    GET_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi
  # Formatting Name
  NAME=$(echo $GET_NAME | sed 's/ //g')
  echo -e "\nHello, $NAME!"

  # Finalizing Appointment
  echo -e "\nLet's schedule an appointment.\nPlease enter the time you would like to show up:"
  read SERVICE_TIME
  # Grabbing customer_id to make the appointment entry
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $1, '$SERVICE_TIME')")
  
  # Formatting service for final output
  GET_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$1")
  SERVICE=$(echo $GET_SERVICE | sed 's/ //g')
  echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $NAME."
  
  EXIT 
}

# Exiting Salon
EXIT() {
  echo -e "\nHave a nice day!"
}

SHOW_SERVICES
