namespace demodb;
using { reuse.commons as commons } from './commons';
using { temporal, cuid, managed } from '@sap/cds/common';

context master{

    entity student : commons.address{
        Key ID: commons.Guid;
        NAME: String(80);
        CLASS: Association to one standards;
        GENDER: String(1);
    }

    entity standards{
        key ID: commons.Guid;
        CLASSNAME: String(10);
        SECTIONS: Int16;
        CLASSTEACHER: String(80);
    }

    entity books{
        key ID: commons.Guid;
        BOOKNAME: String(30);
        AUTHOR: String(80);
    }
}

context trans {
    
    entity rentals: cuid, temporal, managed{
        key ID: UUID;
        student: Association to one master.student;
        book: Association to one master.books;
    }
    
}