
codeunit 50000 "WDC Sales Subscribers"
//*************Documentation***************************
//WDC01  CHG  22/08/2024  Create this current object

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        lSalesLine: record "Sales Line";
        Err01: TextConst FRA = 'Code magasin %1 doit commencer par une valeur similaire au site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
    begin
        SalesHeader.TestField("Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", OnBeforeValidateLocationCode, '', false, false)]

    local procedure OnBeforeValidateLocationCode(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
        lSalesLine: Record "Sales Line";
    begin
        if SalesHeader."Location Code" <> '' then
            if (CopyStr(SalesHeader."Location Code", 1, 2) <> SalesHeader."Shortcut Dimension 1 Code") then
                Error(Err01, SalesHeader."Location Code", SalesHeader."Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", OnBeforeValidateShortcutDimCode, '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        if lsalesLine.get(SalesHeader."Document Type", SalesHeader."No.") then
            lsalesLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnCodeOnAfterCheck, '', false, false)]
    local procedure OnCodeOnAfterCheck(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var LinesWereModified: Boolean)
    var
        Err01: TextConst FRA = 'Code magasin dans ligne commande  %1 doit commencer par une valeur similaire au site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
        Err02: TextConst FRA = 'Code magasin dans ligne commande  %1 doit avoir la même valeur que code magasin dans l''entête  %2', ENU = 'Location Code %1 have similar  value to the Header';
        Err03: TextConst FRA = 'Site Code doit avoir la même valeur pour les lignes et l''entete. ', ENU = 'Site code should include the same value for the lines and the header.';

    begin
        if SalesLine."Shortcut Dimension 1 Code" <> SalesHeader."Shortcut Dimension 1 Code" then
            Error(Err03);
        if SalesLine."Location Code" <> '' then begin
            if (CopyStr(SalesLine."Location Code", 1, 2) <> SalesLine."Shortcut Dimension 1 Code") OR (CopyStr(SalesLine."Location Code", 1, 2) <> SalesHeader."Shortcut Dimension 1 Code") then
                Error(Err01, SalesLine."Location Code", SalesHeader."Shortcut Dimension 1 Code");
            if SalesHeader."Location Code" <> '' then
                if SalesLine."Location Code" <> SalesHeader."Location Code" then
                    Error(Err02, SalesLine."Location Code", SalesHeader."Location Code");
        end;
    end;
}