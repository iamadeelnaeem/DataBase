--Drop First ALL Previous Tables

Drop table invoice_details
Drop table invoice
Drop table customer
Drop table product
Drop table vendor
Drop table shipment

--Create New Table

create table customer (
    c_no number(5),
    c_name varchar2(25) not null,
    city varchar2(30) not null,
    cnic char(16),
    phone varchar2(15) unique,
    constraint cust_c_no_pk primary key(c_no),
    constraint cust_cnic_uk unique(cnic)
);

create table invoice(
    inv_no number(5),
    inv_date date default sysdate,
    c_no number(5),
    payment char(12),
    constraint inv_inv_no_pk primary key(inv_no),
    constraint inv_c_no_fk foreign key(c_no) references customer(c_no),
    constraint inv_payment_ck check(payment in('Cash', 'Cheque', 'Credit Card'))
);

create table Product(
    p_no number(5),
    p_name varchar2(30) not null,
    cost_price number(5),
    qty_in_hand number(5),
    constraint prod_cost_price_ck check(cost_price >= 10),
    constraint prod_p_no_pk primary key(p_no)
);

create table invoice_details(
    inv_no number(5),
    p_no number(5),
    qty number(4),
    sale_price number(5),
    constraint inv_d_qty_ck check(qty between 1 and 500),
    constraint inv_d_p_no_fk foreign key(p_no) references product(p_no),
    constraint inv_d_inv_no_fk foreign key(inv_no) references invoice(inv_no)
);

create table vendor(
    v_code char(10),
    v_name varchar2(15) not null,
    v_addr varchar2(20),
);

create table shipment (
    s_no number(5),
    s_date date default sysdate,
    p_no number(5),
    v_code char(10),
    qty_delivered number(4),
);
