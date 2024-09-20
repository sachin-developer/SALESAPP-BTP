using { SALESAPP.cds } from '../db/cdsview';
using { salesdb.master as master } from '../db/sales-modal';

service CDSService@(Path: 'CDS Service'){
    entity ProductOrdersSet as projection on cds.cdsview.ProductOrders{
        *, 
        PO_ORDERS
    };

    entity ReadEmployeeSrv as projection on master.Employees;
}