namespace com.training;

using { 
    cuid,
    Country
 } from '@sap/cds/common';


entity Course : cuid {
    //key ID : UUID;
    Student : Association to many StudentCourse
                  on Student.Course = $self;

}

entity Student : cuid {
    //key ID : UUID;
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    //key ID      : UUID;
    Student : Association to Student;
    Course  : Association to Course;
}

entity Orders {

    key ClientEmail : String(65);
    FirstName : String(30);
    LastName : String(30);
    CreatedOn : Date;
    Reviewed : Boolean;
    Approved : Boolean;
    Country : Country;
    Status : String(1);

}


// type EmailsAddresses_01 : many {
//     kind  : String;
//     email : String;
// }

// type EmailsAddresses_02 {
//     kind  : String;
//     email : String;
// }

// entity Emails {
//     email_01 :      EmailsAddresses_01;
//     email_02 : many EmailsAddresses_02;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     }
// }

// type Gender      : String enum {
//     male;
//     female;
// };

// entity Order {
//     clientgender : Gender;
//     status       : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped   = 3;
//         cancel    = -1;
//     };
//     priority     : String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// };

// entity Car {
//     key ID : UUID;
//         Name : String;
//         virtual Discount_1 : Decimal;
//         @Core.Computed: false
//         virtual Discount_2 : Decimal;
// }



