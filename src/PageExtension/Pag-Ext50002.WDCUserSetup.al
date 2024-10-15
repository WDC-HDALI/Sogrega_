pageextension 50002 "WDC User Setup" extends "User Setup"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        addafter("Allow Deferral Posting From")
        {
            field("Site Code"; Rec."Site Code")
            {
                ApplicationArea = all;
                TableRelation = "Dimension Value".Code;
            }
            field("Default Sales Location Code"; Rec."Default Sales Location Code")
            {
                ApplicationArea = all;
            }
            field("Default Receipt Location Code"; Rec."Default Receipt Location Code")
            {
                ApplicationArea = all;
            }
            field("Default Shp Location Code"; Rec."Default Shp Location Code")
            {
                ApplicationArea = all;
            }
        }

    }

}
