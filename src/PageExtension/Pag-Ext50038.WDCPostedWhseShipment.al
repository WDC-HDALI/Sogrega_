
pageextension 50038 "WDC Posted Whse. Shipment" extends "Posted Whse. Shipment"
{
    //*************Documentation***************************
    //WDC01  HD  30/08/2024  Create this current object

    layout
    {
        addLast(General)
        {
            field("Gross_Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Number of Packages"; Rec."Number of Packages")
            {
                ApplicationArea = all;
            }
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = all;
            }

        }
    }

}
