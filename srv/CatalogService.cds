using { salesdb.master as master, salesdb.transaction as transaction  } from '../db/sales-modal';

service CatalogService@(path : 'CatalogService'){
    entity BusinessPartnerSet as projection on master.Businesspartner;
    entity AddressSet as projection on master.Address;
    entity EmployeeSet as projection on master.Employees;
    entity ProductSet as projection on master.Product;
    function getOrderStatus() returns POs;
    entity POs @(
        odata.draft.enabled:true,
        Common.DefaultValuesFunction:'getOrderStatus'
        ) as projection on transaction.Purchaseorder{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'A' then 'Approved'
            when 'P' then 'Pending'
            when 'X' then 'Rejected'
            when 'D' then 'Delivered'
            end as OverallStatus: String(10) ,
         case OVERALL_STATUS
            when 'N' then 0
            when 'A' then 1
            when 'P' then 0
            when 'X' then 2
            when 'D' then 3
            end as ColorCoding: Integer ,
            Items
    }
        actions{
            @cds.odata.bindingparameter.name:'_grossamount'
            @Common.SideEffects:{
                TargetProperties:['_grossamount/GROSS_AMOUNT']
            }
            action increaseAmt() returns POs; 
            function getLargestOrder() returns POs;
        };
    entity POItems as projection on transaction.Poitems;
}