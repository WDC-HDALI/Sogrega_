tableextension 50003 "WDC Purchase Header" extends "Purchase Header"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    fields
    {

    }
    trigger OnAfterInsert()
    var
        lPurchHeader: Record "purchase Header";
    begin
        if lPurchHeader.get(rec."Document Type", rec."No.") Then begin
            if rec."Vendor Posting Group" = 'F-ETRANGER' Then begin
                lPurchHeader."Shortcut Dimension 1 Code" := 'BA';
                lPurchHeader.Modify();
            End else begin
                if UserSetup.get(UserId) then
                    If UserSetup."Site Code" <> '' then begin
                        lPurchHeader.Validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                        lPurchHeader.Modify();
                    end;
            end;
        end;
    end;

    trigger OnAfterModify()
    var
        lPurchHeader: Record "purchase Header";
    begin
        if lPurchHeader.get(rec."Document Type", rec."No.") Then begin
            if rec."Vendor Posting Group" = 'F-ETRANGER' Then begin
                lPurchHeader.Validate("Shortcut Dimension 1 Code", 'BA');
                lPurchHeader.Modify();
            End else begin
                if UserSetup.get(UserId) then
                    If UserSetup."Site Code" <> '' then begin
                        lPurchHeader."Shortcut Dimension 1 Code" := UserSetup."Site Code";
                        lPurchHeader.Modify();
                    end;
            end;
        end;
    end;

    var
        UserSetup: record "User Setup";
}
