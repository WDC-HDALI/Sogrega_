pageextension 50025 "WDC Posted Whse. Shipment Sub" extends "Posted Whse. Shipment Subform"
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
                ShowMandatory = true;

            }
        }
    }
}