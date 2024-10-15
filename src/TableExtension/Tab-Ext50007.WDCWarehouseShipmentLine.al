tableextension 50007 "WDC Warehouse Shipment Line" extends "Warehouse Shipment Line"
{

    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                lWhseShipHeader: Record "Warehouse Shipment Header";
                Err01: TextConst FRA = 'Vous ne pouvez pas modifier le matricule le statut doit être ouvert', ENU = 'You cannot change the Matricul. The status must be open.';

            begin
                if lWhseShipHeader.Get(rec."No.") then
                    if lWhseShipHeader.Status = lWhseShipHeader.Status::Released then
                        Error(Err01);
            end;
        }

    }
}
