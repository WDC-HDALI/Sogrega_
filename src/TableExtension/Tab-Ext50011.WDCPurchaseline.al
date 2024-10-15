
tableextension 50011 "WDC Purchase line" extends "Purchase line"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if UserSetup.get(UserId) then begin
                    If UserSetup."Site Code" <> '' then
                        rec.Validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                end;
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
                lPurchHeader: record "Purchase Header";
            begin
                if lPurchHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Location Code" <> '') AND (rec."Shortcut Dimension 1 Code" <> '') then
                        if (CopyStr(rec."Location Code", 1, 2) <> rec."Shortcut Dimension 1 Code") OR (CopyStr(rec."Location Code", 1, 2) <> lPurchHeader."Shortcut Dimension 1 Code") then
                            Error(Err01, rec."Location Code", lPurchHeader."Shortcut Dimension 1 Code");
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {


            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'site code %1 doit avoir une valeur similaire à %2 ', ENU = 'site code %1 must have a value similar to %2';
                lPurshHeader: record "Purchase Header";
            begin
                if lPurshHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Shortcut Dimension 1 Code" <> CopyStr(rec."Location Code", 1, 2)) OR (rec."Shortcut Dimension 1 Code" <> CopyStr(lPurshHeader."Location Code", 1, 2)) then
                        Error(Err01, rec."Shortcut Dimension 1 Code", CopyStr(rec."Location Code", 1, 2));
            end;
        }

    }

    var
        UserSetup: record "User Setup";
}