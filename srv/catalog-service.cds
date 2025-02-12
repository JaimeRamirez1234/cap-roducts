using com.alfa02 as alfa02 from '../db/schema';
using com.training as training from '../db/training';

// service CatalogService {
//     entity Products      as projection on alfa02.materials.Products;
  //     entity Suppliers     as projection on alfa02.sales.Suppliers;
//     entity Currency      as projection on alfa02.materials.Currencies;
//     entity DimensionUnit as projection on alfa02.materials.DimensionUnits;
//     entity Category      as projection on alfa02.materials.Categories;
//     entity SalesData     as projection on alfa02.sales.SalesData;
//     entity Reviews       as projection on alfa02.materials.ProductReview;
//     entity UnitOfMeasure as projection on alfa02.materials.UnitOfMeasures;
//     entity Months        as projection on alfa02.sales.Months;
//     entity Order         as projection on alfa02.sales.Orders;
//     entity OrderItems    as projection on alfa02.sales.OrderItems;
// }

define service CatalogService {

    entity Products          as
        select from alfa02.reports.Products {
            ID,
            Name           as ProductName     @mandatory,
            Description                       @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                             @mandatory,
            Height,
            Width,
            Depth,
            Quantity                          @(
                mandatory,
                assert.range : [
                    0.00,
                    20
                ]
            ),
            UnitOfMeasure  as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category       as ToCategory      @mandatory,
            Category.ID   as CategoryId,
            Category.Name  as Category        @readonly,
            DimensionUnits as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailibilty
        };

    @readonly
    entity Suppliers         as
        select from alfa02.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    @readonly
    entity Reviews           as
        select from alfa02.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct
        }

    @readonly
    entity SalesData         as
        select from alfa02.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            DeliveryMoth.ID          as DeliveryMothID,
            DeliveryMoth.Description as DeliveryMoth,
            Product                  as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from alfa02.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from alfa02.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from alfa02.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure          as
        select from alfa02.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        }

    @readonly
    entity VH_DimensionUnit  as
        select
            ID          as Code,
            Description as Text
        from alfa02.materials.DimensionUnits;
}

define service MyService {

    entity SuppliersProduct as
        select from alfa02.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;


    entity SuppliersToSales as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from alfa02.materials.Products;

    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from alfa02.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin       as
        select Phone from alfa02.materials.Products
        left join alfa02.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';

}

define service Reports {

    entity AverageRating as projection on alfa02.reports.AverageRating;

    entity EntityCasting as 
            select
                cast ( Price as Integer ) as Price,
                Price as Price2 : Integer
            from alfa02.materials.Products;

    entity EntityExists as
            select from alfa02.materials.Products {
                Name
            } where exists Supplier[Name = 'Exotic Liquids'];

}
