using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
// using { CDSViews } from '../db/CDSViews';


service CatalogService @(path: 'CatalogService') {
//mynewchanges
@readonly
    entity EmployeeSet as projection on master.employees;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    entity PurchaseOrderItems as projection on transaction.poitems;
    entity POs @(odata.draft.enabled: true) as projection on transaction.purchaseorder{
        @title : '{i18n>GROSS_AMOUNT}'
        round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
         @title : '{i18n>OVERALL_STATUS}'
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            else 'Open' end as OverallStatus : String(10),
        case OVERALL_STATUS
            when 'P' then 2
            when 'A' then 3
            when 'X' then 1
            else 2 end as Zkas : Integer,
        *,
        Items: redirected to PurchaseOrderItems
    }actions{
        @Common : { SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties: [ 'in/GROSS_AMOUNT',],
        }, }
        action boost() returns POs;
    };

//my new changes
    // entity ItemView as projection on CDSViews.ItemView;
    // entity ProductView as projection on CDSViews.ProductView;
    function getLargestOrder() returns POs;


}
