
tableextension 50013 "WDC Item" extends Item
{
    //*************Documentation***************************
    //WDC01  HD  07/10/2024  Create the current object

    fields
    {
        field(50000; "Production Moule Date"; Date)
        {
            CaptionML = ENG = 'Production Moule Date', FRA = 'Date fabrication Moule';
            DataClassification = ToBeClassified;
        }
        field(50001; "Technical Description"; Text[512])
        {
            CaptionML = ENG = 'Technical Description', FRA = 'Description technique';
            DataClassification = ToBeClassified;
        }
    }
}