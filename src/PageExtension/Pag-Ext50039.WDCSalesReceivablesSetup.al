pageextension 50039 "WDC Sales & Receivables Setup " extends "Sales & Receivables Setup"
{
    //*************Documentation***************************
    //WDC01  CHG 03/09/2024 create this current object

    layout
    {
        addlast(General)
        {
            field("Last Shipping Filter"; Rec."Last Shipping Date Filter")
            {
                ApplicationArea = all;
            }
        }
    }
}