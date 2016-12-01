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
