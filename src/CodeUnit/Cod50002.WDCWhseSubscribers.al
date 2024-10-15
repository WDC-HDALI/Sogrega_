
codeunit 50002 "WDC Whse Subscribers"

//*************Documentation***************************
//WDC01  HD  26/08/2024 copy Matricule in sales document during the whse shp post 
//WDC02  CHG  13/09/2024  test fields lors de lancement d'expédition 

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforeSalesLineModify, '', false, false)]
    local procedure OnBeforeSalesLineModify(var SalesLine: Record "Sales Line"; var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var ModifyLine: Boolean; Invoice: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        SalesLine.Matricule := WarehouseShipmentLine.Matricule;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostedWhseShptHeaderInsert, '', false, false)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        PostedWhseShipmentHeader."Packing Type" := WarehouseShipmentHeader."Packing Type";
        PostedWhseShipmentHeader."Gross Weight" := WarehouseShipmentHeader."Gross Weight";
        PostedWhseShipmentHeader."Net Weight" := WarehouseShipmentHeader."Net Weight";
        PostedWhseShipmentHeader."Number of Packages" := WarehouseShipmentHeader."Number of Packages";
    end;

    [EventSubscriber(ObjectType::Table, database::"Warehouse Shipment Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var xWarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.get(UserId) then
            If UserSetup."Default shp Location Code" <> '' then
                WarehouseShipmentHeader."Location Code" := UserSetup."Default Shp Location Code";
    end;

    [EventSubscriber(ObjectType::Table, database::"Warehouse Receipt Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsertRcpt(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var xWarehouseReceiptHeader: Record "Warehouse Receipt Header"; Location: Record Location)
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.get(UserId) then
            If UserSetup."Default receipt Location Code" <> '' then
                WarehouseReceiptHeader."Location Code" := UserSetup."Default receipt Location Code";
    end;


    //<<WDC02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", OnBeforeCheckWhseShptLinesNotEmpty, '', false, false)]
    local procedure OnBeforeCheckWhseShptLinesNotEmpty(WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var IsHandled: Boolean)
    begin
        WarehouseShipmentHeader.TestField("Gross Weight");
        WarehouseShipmentHeader.TestField("Net Weight");
        WarehouseShipmentHeader.TestField("Number of Packages");
        WarehouseShipmentHeader.TestField("Packing Type");

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", OnAfterTestWhseShptLine, '', false, false)]
    local procedure OnAfterTestWhseShptLine(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        WarehouseShipmentLine.TestField(Matricule);
    end;
    //>>WDC02


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment (Yes/No)", OnBeforeConfirmWhseShipmentPost, '', false, false)]

    local procedure OnBeforeConfirmWhseShipmentPost(var WhseShptLine: Record "Warehouse Shipment Line"; var HideDialog: Boolean; var Invoice: Boolean; var IsPosted: Boolean; var Selection: Integer)
    var
        lWarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if lWarehouseShipmentHeader.Get(WhseShptLine."No.") then begin
            lWarehouseShipmentHeader.TestField("Gross Weight");
            lWarehouseShipmentHeader.TestField("Net Weight");
            lWarehouseShipmentHeader.TestField("Number of Packages");
            lWarehouseShipmentHeader.TestField("Packing Type");

        end;
        WhseShptLine.TestField(Matricule);

    end;

}