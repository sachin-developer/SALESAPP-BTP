using { demodb.master as master, demodb.trans as trans } from '../db/demo';

service BookService {

    entity StudentSet as projection on master.student;
    entity BookSet as projection on master.books;
    entity StandardSet as projection on master.standards;
    entity BookRentalSet as projection on trans.rentals;

}
