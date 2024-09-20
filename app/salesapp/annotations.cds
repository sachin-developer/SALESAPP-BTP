using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields:[
        PO_ID, 
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT
    ],
    UI.LineItem:[
        {
            $Type:'UI.DataField',
            Value: PO_ID
        },
        {
            $Type:'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type:'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type:'UI.DataFieldForAction',
            Action:'CatalogService.increaseAmt',
            Label: 'Increase Amount',
            Inline:true
        },

        {
            $Type:'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type:'UI.DataField',
            Value: OverallStatus,
            Criticality: ColorCoding
        }
    ],
    UI.HeaderInfo:{
        TypeName:'Purchase Order',
        TypeNamePlural:'Purchase Orders',
        Title:{
            $Type:'UI.DataField',
            Value:PO_ID,
        },
        Description:{
            $Type:'UI.DataField',
            Value:PARTNER_GUID.COMPANY_NAME,
        },
        ImageUrl:'https://codeandclap.com/static/img/logo_small.png'
    },
    UI.Facets:[
        {
            $Type:'UI.CollectionFacet',
            Label:'More Info',
            Facets:[
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.Identification'
                },
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#FG_Price_Group'
                },
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#FG_Status'
                },
            ]
        },
        {
            $Type:'UI.ReferenceFacet',
            Target:'Items/@UI.LineItem#PO_Items'
        }
    ],

    UI.Identification:[
        {
            $Type:'UI.DataField',
            Value:PO_ID
        },
        {
            $Type:'UI.DataField',
            Label:'Vendor',
            Value:PARTNER_GUID_NODE_KEY
        },
        {
            $Type:'UI.DataField',
            Value:OVERALL_STATUS
        },
        ],
    UI.FieldGroup #FG_Price_Group:{
        Label:'Price Data',
        Data:[
            {
                $Type:'UI.DataField',
                Value:GROSS_AMOUNT
            },
            {
                $Type:'UI.DataField',
                Value:NET_AMOUNT
            },
            {
                $Type:'UI.DataField',
                Value:TAX_AMOUNT
            },
        ]
    },
    UI.FieldGroup #FG_Status:{
        Label:'Status',
        Data:[
            {
                $Type:'UI.DataField',
                Value:CURRENCY_code
            },
            {
                $Type:'UI.DataField',
                Value:OVERALL_STATUS
            },
            {
                $Type:'UI.DataField',
                Label:'Lifecycle Status',
                Value:LIFECYCLE_STATUS
            },
        ]
    }
) ;

annotate service.POItems with@(
    UI.LineItem #PO_Items:[
        {
            $Type:'UI.DataField',
            Value:PO_ITEM_POS
        },
        {
            $Type:'UI.DataField',
            Value:PRODUCT_GUID_NODE_KEY
        },
        {
            $Type:'UI.DataField',
            Value:PO_ITEM_POS
        },
        {
            $Type:'UI.DataField',
            Value:CURRENCY_code
        },
    ],
    UI.HeaderInfo:{
        TypeName:'PO Item',
        TypeNamePlural:'PO Items',
        Title:{
            $Type:'UI.DataField',
            Value:PO_ITEM_POS
        },
        Description:{
            $Type:'UI.DataField',
            Value:PRODUCT_GUID.DESCRIPTION
        },
        ImageUrl:'https://codeandclap.com/static/img/logo_small.png'
    },
    UI.Facets:[
        {
            $Type:'UI.CollectionFacet',
            Label:'Item Info',
            Facets:[
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#ItemDetail'
                },
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#Pricing'
                },
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#Product'
                }
            ]
        }
    ],
    UI.FieldGroup #ItemDetail:{
        Data:[
            {
                $Type:'UI.DataField',
                Value:PO_ITEM_POS
            },
            {
                $Type:'UI.DataField',
                Value:PRODUCT_GUID_NODE_KEY
            },
            {
                $Type:'UI.DataField',
                Value:CURRENCY_code
            },
        ],
    },
    UI.FieldGroup #Pricing:{
        Data:[
            {
                $Type:'UI.DataField',
                Value:GROSS_AMOUNT
            },
            {
                $Type:'UI.DataField',
                Value:NET_AMOUNT
            },
            {
                $Type:'UI.DataField',
                Value:TAX_AMOUNT
            },
        ]
    },
    UI.FieldGroup #Product:{
        Data:[
            {
                $Type:'UI.DataField',
                Value:PRODUCT_GUID.DESCRIPTION
            },
            {
                $Type:'UI.DataField',
                Value:PRODUCT_GUID.CATEGORY
            },
            {
                $Type:'UI.DataField',
                Value:PRODUCT_GUID.PRICE
            },
        ]
    }
);

annotate service.POs with {
    PARTNER_GUID@(
        Common.Text:PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity: service.BusinessPartnerSet
    );
};

annotate service.POItems with {
    PRODUCT_GUID@(
        Common.Text:PRODUCT_GUID.DESCRIPTION,
        Common.ValueList.entity: service.ProductSet
    );
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[
        {
            $Type:'UI.DataField',
            Value:COMPANY_NAME
        }
    ]
) ;

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[
        {
            $Type:'UI.DataField',
            Value:DESCRIPTION
        }
    ]
) ;


