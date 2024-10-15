
tableextension 50004 "WDC Warehouse Shipment Header" extends "Warehouse Shipment Header"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    fields
    {
        field(50000; "Gross Weight"; Decimal)
        {
            CaptionML = ENG = 'Gross Weight(Kg)', FRA = 'Poid brut(Kg)';
            DataClassification = ToBeClassified;
        }
        field(50001; "Net Weight"; Decimal)
        {
            CaptionML = ENG = 'Net Weight(Kg)', FRA = 'Poid net(Kg)';
            DataClassification = ToBeClassified;
        }
        field(50002; "Number of Packages"; Integer)
        {
            CaptionML = ENG = 'Number of Packages', FRA = 'Nombre des colis';
            DataClassification = ToBeClassified;
        }
        field(50003; "Packing Type"; Enum "WDC Packing Type")
        {
            CaptionML = ENU = 'Packing Type', FRA = 'Type de colisage';
        }

    }

    trigger OnAfterModify()
    var
        lPurchHeader: Record "purchase Header";
    begin
    end;

}