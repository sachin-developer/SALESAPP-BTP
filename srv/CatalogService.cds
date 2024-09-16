using { salesdb.master as master, salesdb.transaction as transaction  } from '../db/sales-modal';

service CatalogService@(title : 'CatalogService'){
    entity BusinessPartnerSet as projection on master.Businesspartner;
    entity AddressSet as projection on master.Address;
    entity EmployeeSet as projection on master.Employees;
    entity ProductSet as projection on master.Product;
    entity POs as projection on transaction.Purchaseorder;
    entity POItems as projection on transaction.Poitems;
}