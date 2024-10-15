pageextension 50001 "WDC Sales Order List" extends "Sales Order List"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        addbefore("Location Code")
        {
            field("Shortcut Dimension 1 Code1"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                Editable = Rec.Status <> Rec.Status::Released;
            }
        }

    }

}
