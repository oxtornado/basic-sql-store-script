--creacion del esquema
create database ejercicio_tres;

--nombramos el esquema para comenzar la creacion de las tablas
use ejercicio_tres;

--creacion de clientes
create table if not exists clientes(
idClient int auto_increment not null,
nameClient varchar(45) not null,
email varchar(45) not null,
phoneNum varchar(45) not null,
primary key (idClient)
);

--creacion de categorias
create table if not exists categorias(
idCategories int auto_increment not null,
nameCat varchar(45) not null,
primary key (idCategories)
);

--creacion de productos
create table if not exists productos(
idProducts int auto_increment not null,
idCategories int not null,
namePro varchar(45) not null,
price decimal(10, 3) not null,
descriptionPro varchar(45) not null,
country varchar(45) not null,
primary key (idProducts),
constraint productosxcategorias foreign key (idCategories) references categorias(idCategories)
);

-- creacion tabla de proveedores
create table if not exists proveedores(
idSuppliers int auto_increment not null,
idProducts int not null,
nameSupp varchar(45) not null,
phoneNum varchar(45) not null,
addresSup varchar(45) not null,
emailSup varchar(45) not null,
primary key (idSuppliers),
constraint proveedoresxproductos foreign key (idProducts) references productos(idProducts)
);

-- creacion tabla de metodosPago
create table if not exists metodosPago(
idPayMet int auto_increment not null,
primary key (idPayMet)
);

-- creacion tabla de direcciones
create table if not exists direcciones(
idAdd int auto_increment not null,
idClient int not null,
primary key (idAdd),
constraint direccionesxclientes foreign key(idClient) references clientes(idClient)
);

-- creacion tabla de pedidos
create table if not exists pedidos(
idOrder int not null auto_increment,
idPayMet int not null,
idClient int not null,
primary key (idOrder),
constraint pedidosxclientes foreign key(idClient) references clientes(idClient),
constraint pedidosxmetodosPago foreign key(idPayMet) references metodosPago(idPayMet)
);

-- creacion tabla de detallePedido
create table if not exists detallePedido(
idOrderDetail int auto_increment not null,
idOrder int not null,
idProducts int not null,
orderDate datetime not null,
idPayMet int not null,
amount int not null,
unitPrice decimal(10, 3) not null,
primary key (idOrderDetail),
constraint detallePedidoxpedidos foreign key(idOrder) references pedidos(idOrder),
constraint detallePedidoxproductos foreign key(idProducts) references productos(idProducts),
constraint detallePedidoxmetodosPago foreign key (idPayMet) references metodosPago(idPayMet)
);

-- creacion tabla de carritos
create table if not exists carritos(
idCart int auto_increment not null,
idOrderDetail int not null,
primary key (idCart),
constraint carritoxdetallePedido foreign key(idOrderDetail) references detallePedido(idOrderDetail)
);

-- creacion tabla de envios
create table if not exists envios(
idShip int auto_increment not null,
idPayMet int not null,
idOrder int not null,
primary key (idShip),
constraint enviosxpedidos foreign key (idOrder) references pedidos(idOrder),
constraint enviosxmetodosPago foreign key (idPayMet) references metodosPago(idPayMet)
);

-- creacion tabla de pagos
create table if not exists pagos(
idPay int auto_increment not null,
idShip int not null, -- the client will know when it's order coming  
idOrder int not null,
idPayMet int not null, 
primary key (idPay),
constraint pagosxenvios foreign key (idShip) references envios(idShip),
constraint pagosxpedidos foreign key (idOrder) references pedidos(idOrder),
constraint pagosxmetodosPago foreign key (idPayMet) references metodosPago(idPayMet)
);

-- creacion tabla de opiniones
create table if not exists opiniones(
idOpi int auto_increment not null,
idProducts int not null,
idClient int not null,
opinion varchar(45) not null, 
primary key (idOpi),
constraint opinionesxproductos foreign key (idProducts) references productos(idProducts),
constraint opinionesxclientes foreign key (idClient) references clientes(idClient)
);