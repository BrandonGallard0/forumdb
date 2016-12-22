/*
 * Shopping cart
 */

create table paises(
	id int not null primary key generated always as identity,
	nombre varchar(50) not null
);

create table regiones(
	id int not null primary key generated always as identity,
	pais_id int not null,
	nombre varchar(50) not null,
	constraint FK_region_pais foreign key (pais_id) references paises(id)
);

create table comunas(
	id int not null primary key generated always as identity,
	region_id int not null,
	nombre varchar(50) not null,
	constraint FK_comuna_region foreign key (region_id) references regiones(id)
);

create table roles(
	id int not null primary key generated always as identity,
	tipo varchar(20) not null
);


create table clientes(
	id int not null primary key generated always as identity,
	pais_id int not null,
	region_id int not null,
	comuna_id int not null,
	activado smallint not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	run varchar(20) not null,
	password varchar(255) not null,
	edad int not null,
	telefono varchar(20) not null,
	creado_el timestamp not null default current_timestamp,
	actualizado_el date not null,

	/* Foreign keys */

	constraint FK_cliente_pais foreign key (pais_id) references paises(id),
    constraint FK_cliente_region foreign key (region_id) references regiones(id),
    constraint FK_cliente_comuna foreign key (comuna_id) references comunas(id)
);



create table productos (
	id int not null primary key generated always as identity,
	foto varchar(255) not null,
	nombre varchar(50) not null,
	descripcion varchar(255) not null,
	precio int not null,
	stock int not null
);


create table compras(
    id int not null primary key generated always as identity,
    cliente_id int not null,
    producto_id int not null,
    fecha_compra timestamp default current_timestamp,

    /* foreign keys */
    constraint FK_compra_cliente foreign key (cliente_id) references clientes(id),
    constraint FK_compra_producto foreign key (producto_id) references productos(id)
);

create table categorias(
	id int not null primary key generated always as identity,
	alias varchar(50) not null,
	nombre varchar(20) not null
);


/**
 * Forum
 */
create table preguntas(
    
    id int not null primary key generated always as identity,
    categoria_id int not null,
    cliente_id int not null,
    pregunta varchar(255) not null,
    descripcion varchar(255) not null,
    creado_el timestamp not null default current_timestamp,

    /* FOREIGN KEYS */
    /* pregunta --> cliente */
	constraint FK_pregunta_cliente foreign key (cliente_id) references clientes(id),
	constraint FK_pregunta_categoria foreign key (categoria_id) references categorias(id)
    
);

create table respuestas(

    id int not null primary key generated always as identity,
    pregunta_id int not null, 
    cliente_id int not null,
    respuesta varchar(255) not null,
    creado_el timestamp not null default current_timestamp,
	
	constraint FK_respuesta_pregunta foreign key (pregunta_id) references preguntas(id)
	on delete cascade,

	/* respuesta --> cliente */
	constraint FK_respuesta_cliente foreign key (cliente_id) references clientes(id)
);



/* Seeder */


insert into inacap.PAISES(nombre) values('Chile');
insert into inacap.REGIONES(pais_id,nombre) values(1,'Metropolitana');
insert into inacap.COMUNAS(region_id,nombre) values(1,'Santiago');

insert into inacap.ROLES(tipo) values('administrador');
insert into inacap.ROLES(tipo) values('vendedor');
insert into inacap.ROLES(tipo) values('cliente');

	insert into inacap.CATEGORIAS(alias,nombre) values('compras','Compras Internet');
insert into inacap.CATEGORIAS(alias,nombre) values('ventas','Sistema vendedores');
insert into inacap.CATEGORIAS(alias,nombre) values('devoluciones','Devoluciones');

insert into inacap.CLIENTES(pais_id,region_id,comuna_id,activado,nombre,
                            apellido,run,password,edad,telefono,actualizado_el) 
                            values(1,1,1,1,'admin','admin','123456789-1','123456',1,
                                   '9999999','2016-12-05 00:00:00');

insert into inacap.CLIENTES(pais_id,region_id,comuna_id,activado,nombre,
                            apellido,run,password,edad,telefono,actualizado_el) 
                            values(1,1,1,1,'vendedor','vendedor','123456789-0','123456',1,
                                   '9999999','2016-12-05 00:00:00');



insert into inacap.CLIENTES(pais_id,region_id,comuna_id,activado,nombre,
                            apellido,run,password,edad,telefono,actualizado_el) 
                            values(1,1,1,1,'cliente','cliente','123456789-k','123456',1,
                                   '9999999','2016-12-05 00:00:00');

insert into inacap.Productos (foto,nombre,descripcion, precio,  stock) values ('pendrive_16g.png', 'pendrive_1','util para el quehacer diario',4590,3);

insert into inacap.Productos (foto,nombre,descripcion, precio, stock) values ('ventilador_usb.png', 'vent_1','rapido y silencioso',9990,5);

insert into inacap.Productos (foto,nombre,descripcion, precio,stock) values ('intel_i7.png', 'proce_i7','el procesador más rápido',4590,3);

insert into inacap.PREGUNTAS(categoria_id,cliente_id,pregunta,descripcion) values 
(1,1,'¿Como comprar?','Tengo dudas en como funciona el metodo de compras');
insert into inacap.PREGUNTAS(categoria_id,cliente_id,pregunta,descripcion) values 
(1,2,'¿Cada cuanto se actualiza el catalogo de productos?','Quisiera saber cuando habran mas productos disponibles');
insert into inacap.PREGUNTAS(categoria_id,cliente_id,pregunta,descripcion) values 
(3,3,'Devolver producto en mal estado','¿A quien puedo contactar para poder resolver mi problema? 
        mi producto llego en malas condiciones');
insert into inacap.PREGUNTAS(categoria_id,cliente_id,pregunta,descripcion) values 
(1,3,'Metodos de pago','¿cuales son los metodos de pago disponibles?');


insert into inacap.RESPUESTAS(pregunta_id,cliente_id,respuesta) values(1,1,'El proceso es simple, solamente debes dirigirte a tu carro de compras y tendras la opcion.');
insert into inacap.RESPUESTAS(pregunta_id,cliente_id,respuesta) values(2,2,'El catalogo de producto se actualiza semanalmente.');
insert into inacap.RESPUESTAS(pregunta_id,cliente_id,respuesta) values(3,3,'En caso de recibir productos en malas condiciones, puede contactar al telefono general de contacto.');
insert into inacap.RESPUESTAS(pregunta_id,cliente_id,respuesta) values(4,3,'La transacción de pago solo es valida por medio de tarjetas de credito o debito.');