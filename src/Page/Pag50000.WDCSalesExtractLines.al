page 50000 "WDC Sales Extract Lines"
{
    //WDC01  CHG 29/08/2024 Create this current object 

    CaptionML = ENG = 'Extract Lines', FRA = 'Extraire Ligne vente';
    PageType = List;
    SourceTable = "Sales Line";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ShowFilter = true;

    layout
    {
        area(content)
        {
            repeater(Control1)

            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    DrillDown = false;
                    Enabled = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    QuickEntry = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    Editable = false;
                }

                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    QuickEntry = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');
                    QuickEntry = false;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');
                    QuickEntry = false;
                }


                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    QuickEntry = false;

                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    DecimalPlaces = 0 : 6;
                    ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');

                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    QuickEntry = false;
                    ApplicationArea = Basic, Suite;
                }


            }
        }
    }

    trigger OnClosePage()
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
        lWarehouseShipmentLine: record "Warehouse Shipment Line";
    begin

        CurrPage.SetSelectionFilter(lSalesLine);
        if lSalesLine.findset then
            repeat
                lWarehouseShipmentLine.Init();
                lWarehouseShipmentLine."No." := DocumentNo;
                lWarehouseShipmentLine."Location Code" := locationCode;
                lWarehouseShipmentLine."Source Type" := 37;
                lWarehouseShipmentLine."Source Subtype" := 1;
                lWarehouseShipmentLine."Source No." := lSalesLine."Document No.";
                lWarehouseShipmentLine."Source Document" := lSalesLine."Document type"::Order;
                lWarehouseShipmentLine."Line No." := GetLineNo(DocumentNo);
                lWarehouseShipmentLine."Item No." := lSalesLine."No.";
                lWarehouseShipmentLine.Description := lSalesLine.Description;
                lWarehouseShipmentLine."Source Line No." := lSalesLine."Line No.";
                lWarehouseShipmentLine."Unit of Measure Code" := lSalesLine."Unit of Measure";
                lWarehouseShipmentLine.Validate(Quantity, lSalesLine.Quantity - lSalesLine."Quantity Shipped");
                lWarehouseShipmentLine.Insert();
            until lSalesLine.Next() = 0;
    end;

    procedure GetLineNo(docNo: code[20]): Integer
    var
        lWhseShpLines: record "Warehouse Shipment Line";
    begin
        lWhseShpLines.Reset();
        lWhseShpLines.SetRange("No.", docNo);
        if lWhseShpLines.FindLast() then
            exit(lWhseShpLines."Line No." + 10000)
        else
            exit(10000);
    end;

    procedure SetDocumentNO(pDocNo: code[20])
    var
    begin
        DocumentNo := pDocNo;
    end;

    procedure SetLocationCode(plocationCode: code[10])
    var
    begin
        locationCode := plocationCode;
    end;


    var
        DocumentNo: Code[20];
        Item: Record Item;
        salesLine: record "Sales Line";
        RemainingQty: decimal;
        locationCode: code[10];
        SalesExtractLine: page "WDC Sales Extract Lines";
        p: Page "Sales Order";
}