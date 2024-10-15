tableextension 50010 "WDC Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
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
