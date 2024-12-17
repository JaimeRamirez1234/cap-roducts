using {com.alfa02 as A223} from '../db/schema';

service CustomerService {

    entity CustomerSrv as projection on A223.Customer

}
