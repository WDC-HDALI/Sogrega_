tableextension 50001 "WDC User Setup" extends "User Setup"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    fields
    {
        field(50000; "Site Code"; Code[20])
        {
            Caption = 'Site Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "Default Sales Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Sales Location Code', FRA = 'Magasin vente par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50002; "Default Receipt Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Receipt Location Code', FRA = 'Magasin réception par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50003; "Default Shp Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Shipemt Location Code', FRA = 'Magasin Expédition par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
    }
    var
        varc: record 36;
}
