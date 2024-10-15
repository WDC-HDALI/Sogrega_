tableextension 50008 "WDC Posted Whse. Shipment Line" extends "Posted Whse. Shipment Line"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
        }
    }
}
