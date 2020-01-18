CREATE TABLE registeredserviceimpl ( 
    id bigint NOT NULL, 
    allowedtoproxy bit NOT NULL, 
    anonymousaccess bit NOT NULL, 
    description varchar(255), 
    enabled bit NOT NULL, 
    evaluation_order int NOT NULL, 
    ignoreattributes bit NOT NULL, 
    name varchar(255), 
    serviceid varchar(255), 
    ssoenabled bit NOT NULL, 
    theme varchar(255) 
); 
CREATE TABLE rs_attributes ( 
    registeredserviceimpl_id bigint NOT NULL, 
    a_name varchar(255) NOT NULL, 
    a_id int NOT NULL 
); 
CREATE TABLE serviceticket ( 
    id varchar(255) NOT NULL, 
    number_of_times_used int, 
    creation_time bigint, 
    expiration_policy varbinary(max) NOT NULL, 
    last_time_used bigint, 
    previous_last_time_used bigint, 
    from_new_login bit NOT NULL, 
    ticket_already_granted bit NOT NULL, 
    service varbinary(max) NOT NULL, 
    ticketgrantingticket_id varchar(255) 
); 
CREATE TABLE ticketgrantingticket ( 
    id varchar(255) NOT NULL, 
    number_of_times_used int, 
    creation_time bigint, 
    expiration_policy varbinary(max) NOT NULL, 
    last_time_used bigint, 
    previous_last_time_used bigint, 
    authentication varbinary(max) NOT NULL, 
    expired bit NOT NULL, 
    services_granted_access_to varbinary(max) NOT NULL, 
    ticketgrantingticket_id varchar(255) 
);

ALTER TABLE  registeredserviceimpl 
    ADD CONSTRAINT registeredserviceimpl_pkey PRIMARY KEY (id); 
ALTER TABLE  rs_attributes 
    ADD CONSTRAINT rs_attributes_pkey PRIMARY KEY 
(registeredserviceimpl_id, a_id); 
ALTER TABLE  serviceticket 
    ADD CONSTRAINT serviceticket_pkey PRIMARY KEY (id); 
ALTER TABLE  ticketgrantingticket 
    ADD CONSTRAINT ticketgrantingticket_pkey PRIMARY KEY (id);