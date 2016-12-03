/*
 * Shopping cart
 */

create table paises(
	id int not null generated always as identity,
	nombre varchar(50) not null
);

create table regiones(
	id int not null generated always as identity,
	pais_id int not null,
	nombre varchar(50) not null	
);

create table comunas(
	id int not null generated always as identity,
	region_id int not null,
	nombre varchar(50) not null
);

create table roles(
	id int not null generated always as identity,
	tipo varchar(20) not null,
);

create table role_cliente(
	id int not null generated always as identity,
	role_id int not null,
	cliente_id int not null
);

create table clientes(
	id int not null generated always as identity,
	pais_id int not null,
	region_id int not null,
	comuna_id int not null,
	rol_id int not null,
	activado smallint not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	run varchar(20) not null,
	password varchar(255) not null,
	edad int not null,
	telefono varchar(20) not null,
	creado_el date not null current_timestamp,
	actualizado_el date not null
);

create table productos (
	id int not null generated always as identity,
	foto varchar(255) not null,
	nombre varchar(50) not null,
	descripcion varchar(255) not null,
	precio int not null,
	stock int not null
);


/* CLIENTE --> ROL */

alter table role_cliente add constraint foreign key role_cliente(role_id) references roles(id);
alter table role_cliente add constraint foreign key role_cliente(cliente_id) references clientes(id);


/* REGION --> PAIS */
alter table regiones add constraint "FK_region_pais" foreign key regiones(pais_id) references paises(id);

/* COMUNA --> REGION */
alter table comunas add constraint "FK_comuna_region" foreign key comunas(region_id) references regiones(id);


/* CLIENTE --> PAIS, REGION, COMUNA */

alter table clientes add constraint "FK_cliente_pais" foreign key clientes(pais_id) references paises(id);
alter table clientes add constraint "FK_cliente_region" foreign key clientes(region_id) references regiones(id);
alter table clientes add constraint "FK_cliente_comuna" foreign key clientes(comuna_id) references comunas(id);
alter table clientes add constraint "FK_cliente_rol" foreign key clientes(rol_id) references roles(id);


/**
 * Forum
 */
create table preguntas(
    
    id int not null primary key generated always as identity,
    cliente_id int not null,
    pregunta varchar(255) not null,
    creado_el date not null current_timestamp
    
);

create table respuestas(

    id int not null primary key generated always as identity,
    pregunta_id int not null, 
    cliente_id int not null,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     _id int not null,
    respuesta varchar(255) not null,
    creado_el date not null current_timestamp

);

/* pregunta --> cliente */
alter table add constraint "FK_pregunta_cliente"
foreign key preguntas(cliente_id) references clientes(id);

/* respuesta --> pregunta */
alter table add constraint "FK_respuesta_pregunta"
foreign key respuestas(pregunta_id) references preguntas(id);

/* respuesta --> cliente */
alter table respuestas add constraint "FK_respuesta_cliente"
foreign key respuestas(cliente_id) references clientes(id);
