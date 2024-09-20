namespace SALESAPP.cds;

using { salesdb.master as master, salesdb.transaction as transaction } from './sales-modal';

context cdsview {
    define view ![POWorklist] as
    select from transaction.Purchaseorder{
        key PO_ID as ![PurchaseOrderNo],
        key Items.PO_ITEM_POS as ![Position],
        PARTNER_GUID as ![vendorID],
        PARTNER_GUID.COMPANY_NAME as ![CompanyName],
        Items.GROSS_AMOUNT as ![GrossAmount],
        Items.NET_AMOUNT as ![NET_AMOUNT],
        Items.TAX_AMOUNT as ![TAX_AMOUNT],
        case OVERALL_STATUS
            when 'N' then 'New' 
            when 'D' then 'Delivered' 
            when 'P' then 'Pending' 
            when 'A' then 'Approved' 
            when 'X' then 'Rejected' 
            end as ![Status],
        Items.PRODUCT_GUID.DESCRIPTION as ![Description],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]    
    };

    define view ![ProductVH] as 
    select from master.Product{
        @EndUserText.label:[
            {
                language:'EN',
                text:'Product ID'
            },
            {
                language:'DE',
                text:'Prodekt ID'
            }
        ]
        PRODUCT_ID as ![ProductID],
        @EndUserText.label:[
            {
                language:'EN',
                text:'Product Name'
            },
            {
                language:'DE',
                text:'Prodekt Name'
            }
        ]
        DESCRIPTION as ![ProductName]

    };

    define view ![ItemView] as 
    select from transaction.Poitems{
        Key PARENT_KEY.PARTNER_GUID.NODE_KEY as ![vendorID],
        PRODUCT_GUID.NODE_KEY as ![ProductID],
        CURRENCY as![CurrencyCode],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NET_AMOUNT],
        TAX_AMOUNT as ![TAX_AMOUNT],
        PARENT_KEY.OVERALL_STATUS as ![Status]
    };

    define view ProductOrders as select from master.Product
    mixin{
       PO_ORDERS: Association[*] to ItemView on PO_ORDERS.ProductID = $projection.ProductKey
    } into {
        NODE_KEY as![ProductId],
        NODE_KEY as ![ProductKey],
        DESCRIPTION as ![ProductName],
        PRICE as ![Price],
        SUPPLIER_GUID.BP_ID as ![SupplierID],
        SUPPLIER_GUID.COMPANY_NAME as ![SupplierName],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        PO_ORDERS
    };

    define view CProductValuesView as
        select from ProductOrders{
            ProductId,
            Country,
            round(sum(PO_ORDERS.GrossAmount),2) as![TotalPurchaseAmount] : Decimal(10,2),
            PO_ORDERS.CurrencyCode as![CurrencyCode]
        } group by ProductId, Country, PO_ORDERS.CurrencyCode;
}