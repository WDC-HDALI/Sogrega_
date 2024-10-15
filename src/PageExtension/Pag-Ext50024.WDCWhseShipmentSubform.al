pageextension 50024 "WDC Whse. Shipment Subform" extends "Whse. Shipment Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        addafter(Quantity)
        {
            field(Matricule; Rec.Matricule)
            {
                ApplicationArea = all;
            }
        }
    }
}