tableextension 50009 "WDC Sales Invoice Line" extends "Sales Invoice Line"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create this current object

    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
        }

    }

}
