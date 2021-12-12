create table if not exists supplier
(
    id           int generated always as identity primary key,
    name         character(30)  not null,
    begin_date   timestamptz,
    end_date     timestamptz,
    reason_end   character(280),
    bank_details character(280) not null,
    contacts     character(280) not null,
    address      character(280) not null,
    constraint end_date_check check ( supplier.end_date > supplier.begin_date )
);

create table if not exists product_type
(
    id            int generated always as identity primary key,
    name          character(30)  not null unique,
    specification character(290) not null
);

create table if not exists product
(
    barcode         character(13) primary key,
    product_type_id int references product_type,
    name            character(50)  not null,
    description     character(280) not null,
    shelf_life      interval       not null
);

create table if not exists supply
(
    id              int generated always as identity primary key,
    supplier_id     int references supplier,
    product_barcode character(13) references product,
    trade_price     money       not null,
    min_size        int         not null,
    max_size        int         not null,
    production_date timestamptz not null,
    constraint trade_price_positive check ( supply.trade_price > 0::money ),
    constraint max_size_more_min_size check ( supply.max_size > supply.min_size )
);

create table if not exists outlet_type
(
    id            int generated always as identity primary key,
    name          character(30)  not null unique,
    specification character(290) not null
);

create table if not exists outlet
(
    id             int generated always as identity primary key,
    outlet_type_id int references outlet_type,
    address        character(280) not null unique,
    open_date      timestamptz    not null,
    close_date     timestamptz,
    constraint open_date_less_close_date check (
        outlet.open_date < outlet.close_date
        )
);

create table if not exists position
(
    id           int generated always as identity primary key,
    name         character(50) not null unique,
    access_level int           not null,
    min_salary   money         not null,
    max_salary   money         not null,
    constraint nim_salary_less_then_max_salary check (
        position.min_salary > position.max_salary
        ),
    constraint access_level_non_negative check (
        position.access_level >= 0
        ),
    constraint min_salary_non_negative check (
        position.min_salary >= 0::money
        ),
    constraint max_salary_non_negative check (
        position.max_salary >= 0::money
        )
);

create table if not exists employee
(
    id            int generated always as identity primary key,
    outlet_id     int references outlet,
    position_id   int references position,
    fullname      character(100) not null,
    personal_data character(50)  not null unique,
    date          timestamptz    not null,
    salary        money          not null,
    begin_date    timestamptz    not null,
    end_date      timestamptz,
    constraint fire_date_more_begin_date check (
        employee.end_date > employee.begin_date
        )
);

create table if not exists orders
(
    id            int generated always as identity primary key,
    employee_id   int references employee,
    creation_date timestamptz not null default now()
);

create table if not exists order_item
(
    id        int generated always as identity primary key,
    order_id  int references orders,
    supply_id int references supply,
    amount    int not null,
    constraint amount_positive check ( order_item.amount > 0 )
);

create table if not exists application
(
    id                   int generated always as identity primary key,
    employee_id          int references employee,
    status               character(20) not null,
    creation_date        timestamptz   not null default now(),
    changing_status_date timestamptz   not null
);

create table if not exists application_item
(
    id              int generated always as identity primary key,
    application_id  int references application,
    product_barcode character(13) references product,
    amount          int not null,
    constraint unique (application_id, product_barcode, amount),
    constraint amount_is_positive check ( application_item.amount > 0 )
);

create table if not exists client
(
    id                   int generated always as identity primary key,
    card_number          character(20)  not null unique,
    fullname             character(100) not null,
    birth_date           timestamptz    not null,
    creation_card_date   timestamptz    not null default now(),
    activation_card_date timestamptz,
    card_shelf_life      interval       not null,
    constraint activation_card_date_more_than_creation_card_date check (
        client.activation_card_date > client.creation_card_date
        )
);

create table if not exists price
(
    id         int generated always as identity primary key,
    price      money       not null,
    begin_date timestamptz not null,
    end_date   timestamptz,
    constraint price_positive check (
        price.price > 0::money
        ),
    constraint begin_date_more_end_date check (
        price.begin_date > price.end_date
        )
);

create table if not exists coming
(
    id              int generated always as identity primary key,
    outlet_id       int references outlet,
    product_barcode character(13) references product,
    price_id        int references price,
    coming_date     timestamptz not null,
    amount          int         not null,
    constraint amount_non_negative check ( amount >= 0 )
);



create table if not exists selling
(
    id              int generated always as identity primary key,
    outlet_id       int references outlet,
    product_barcode character(13) references product,
    employee_id     int references employee,
    client_id       int references client,
    price           money       not null,
    amount          int         not null,
    sale_datetime   timestamptz not null,
    constraint price_positive check (
        selling.price > 0::money
        ),
    constraint amount_positive check (
        selling.amount > 0
        )
);

create table if not exists warehouse
(
    id         int generated always as identity primary key,
    address    character(290) not null unique,
    area       int            not null,
    open_date  timestamptz    not null,
    close_date timestamptz,
    constraint area_positive check (
        warehouse.area > 0
        ),
    constraint open_date_more_close_date check (
        warehouse.open_date > warehouse.close_date
        )
);

create table if not exists distribution
(
    id            int generated always as identity primary key,
    supply_id     int references supply,
    warehouse_id  int references warehouse,
    delivery_date timestamptz,
    amount        int,
    constraint amount_positive check (
        distribution.amount > 0
        )
);

create table if not exists payment_type
(
    id            int generated always as identity primary key,
    name          character(30)  not null unique,
    specification character(290) not null
);

create table if not exists payment
(
    id              int generated always as identity primary key,
    outlet_id       int references outlet,
    payment_type_id int references payment_type,
    datetime        timestamptz not null,
    amount          int,
    constraint amount_positive check (
        payment.amount > 0
        )
);



