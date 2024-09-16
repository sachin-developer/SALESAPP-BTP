namespace reuse.commons;

using {Currency} from '@sap/cds/common';

type Guid    : String(32);

type Gender  : String(1) enum {
    male        = 'M';
    female      = 'F';
    undisclosed = 'U';
};

type AmountT : Decimal(10, 2) @(
    Semantic.amount.currencyCode: 'CURRENCY_code',
    sap.unit                    : 'CURRENCY_code'
);

aspect Amount {
    CURRENCY     : Currency;
    GROSS_AMOUNT : AmountT @(title: 'Gross Amount');
    NET_AMOUNT   : AmountT @(title: 'Net Amount');
    TAX_AMOUNT   : AmountT @(title: 'Tax Amount');
}

type PhoneNumber : String(30) @assert.format : '^\(?([2-9][0-9]{2})\)?[-.●\s]?([2-9][0-9]{2})[-.●\s]?([0-9]{4})$';
type EmailAddress : String(30) @assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

aspect address {
    HOUSENO : Int16;
    STREET  : String(32);
    CITY    : String(80);
    COUNTRY : String(3);
}
