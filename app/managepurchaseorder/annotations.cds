using CatalogService as service from '../../srv/CatalogService';
annotate service.POs with @(
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS

    ],
UI.LineItem:[
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
        
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.COMPANY_NAME,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
    },
    {
        $Type : 'UI.DataField',
        Value : GROSS_AMOUNT,
    },
    {
        $Type : 'UI.DataFieldForAction',
        Label:'Boost',
        Inline : true,
        Action : 'CatalogService.boost',
    },
    {
        $Type : 'UI.DataField',
        Value : OverallStatus,
        Criticality: Zkas
    },

],
UI.HeaderInfo:{
TypeName: 'Purchase Order',
TypeNamePlural: 'Purchase Orders',
Title: {Value: PO_ID,},
Description: {Value: GROSS_AMOUNT}
},

UI.Facets:[
{$Type: 'UI.CollectionFacet',
 Label: 'Detailed Information',
 Facets:[
    {$Type: 'UI.ReferenceFacet',
    Target: '@UI.Identification'},
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#SuperMan',
    },
    {
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#Batman',
    },

 ]},
 
    {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Items',
            Target : 'Items/@UI.LineItem',
        },




],
UI.Identification:[ 
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY,

    },
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY,
    },
],
UI.FieldGroup#SuperMan:{
Label: 'Price Info',
    Data:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
{
    $Type : 'UI.DataField',
    Value : CURRENCY_code,

},
{
    $Type : 'UI.DataField',
    Value : GROSS_AMOUNT,
},
{
    $Type : 'UI.DataField',
    Value : TAX_AMOUNT,
},
{
    $Type : 'UI.DataField',
    Value : NET_AMOUNT,
},

    ]

},
UI.FieldGroup#Batman: {
Label: 'Status info',
Data: [
{
    $Type : 'UI.DataField',
    Value : OverallStatus,
},

{
    $Type : 'UI.DataField',
    Value : LIFECYCLE_STATUS,
},

]

}
    


);

annotate service.PurchaseOrderItems with @(
    UI.HeaderInfo: {
        TypeName: 'PO Item',
        TypeNamePlural: 'PO Items',
        Title: {Label : 'Item Pos', Value: PO_ITEM_POS},
        Description: {Label: 'Product', Value: PRODUCT_GUID.DESCRIPTION}
    },

    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Details',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ]



);
annotate service.POs with {
    PARTNER_GUID@(
        Common : {
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};


annotate service.PurchaseOrderItems with {
    PRODUCT_GUID@(
        Common : {
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};




@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);


@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);




