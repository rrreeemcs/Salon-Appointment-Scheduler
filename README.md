# Salon Appointment Scheduler - FreeCodeCamp Relational Database Certification

### Description
The aim of this project is to simulate scheduling appointments for a salon through the use of PostgreSQL and Bash scripting. Customization for this project was to my discretion, however, I had to meet the following requirements below.

### Requirements
- Create a database named **salon**
- Create 3 tables inside **salon** named: *customers*, *appointments*, *services*
- Each table should have a primary key that automatically increments (**SERIAL** datatype), while following a specific naming scheme
- The *appointments* table should have a foreign key referencing the primary keys of *customers* and *services*
- Display the available services as *#) service_name* and display them again if user does **NOT** choose an available service
- Insert a **new entry** into the *customers* table if a customer is new to the salon (no name is registered for their phone number)
- Output a final message once appointment has been successfully scheduled
