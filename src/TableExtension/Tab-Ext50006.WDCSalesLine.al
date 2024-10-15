
tableextension 50006 "WDC Sales Line" extends "Sales Line"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create the current object
    //WDC02  CHG 30/08/2024  add new field
    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
        }
        //<<WDC02
        field(50001; "Status"; Enum "Sales Document Status")
        {
            CaptionML = ENG = 'Status', FRA = 'Status';
            CalcFormula = lookup("sales Header".Status where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        //>>WDC02
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if rec.Type = rec.Type::Item then begin
                    if UserSetup.get(UserId) then
                        If UserSetup."Default Sales Location Code" <> '' then
                            rec.Validate("Location Code", UserSetup."Default Sales Location Code");
                end;
            end;

        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
                lSalesHeader: record "Sales Header";
            begin
                if lSalesHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Location Code" <> '') AND (rec."Shortcut Dimension 1 Code" <> '') then
                        if (CopyStr(rec."Location Code", 1, 2) <> rec."Shortcut Dimension 1 Code") OR (CopyStr(rec."Location Code", 1, 2) <> lSalesHeader."Shortcut Dimension 1 Code") then
                            Error(Err01, rec."Location Code", lSalesHeader."Shortcut Dimension 1 Code");
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {


            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'site code %1 doit avoir une valeur similaire à %2 ', ENU = 'site code %1 must have a value similar to %2';
                lSalesHeader: record "Sales Header";
            begin
                if lSalesHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Shortcut Dimension 1 Code" <> CopyStr(rec."Location Code", 1, 2)) OR (rec."Shortcut Dimension 1 Code" <> CopyStr(lsalesheader."Location Code", 1, 2)) then
                        Error(Err01, rec."Shortcut Dimension 1 Code", CopyStr(rec."Location Code", 1, 2));
            end;
        }
    }


    var
        UserSetup: record "User Setup";
}