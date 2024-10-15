tableextension 50012 WDCSalesReceivablesSetup extends "Sales & Receivables Setup"
{
    //*************Documentation***************************
    //WDC01  CHG 03/09/2024 create this current object

    fields
    {
        field(50000; "Last Shipping Date Filter"; DateFormula)
        {
            CaptionML = ENG = 'Last Shipping Date Filter', FRA = 'Filtre date d''expédition';
            DataClassification = ToBeClassified;
        }
    }
}
