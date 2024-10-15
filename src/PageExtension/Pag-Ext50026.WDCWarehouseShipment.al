
pageextension 50026 "WDC Warehouse Shipment" extends "Warehouse Shipment"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02 CHG 30/08/2024 Add action "Extract line whse"
    layout
    {
        addLast(General)
        {
            field("Gross_Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Number of Packages"; Rec."Number of Packages")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }

        }
    }
    actions
    {

        addafter("Get Source Documents")
        {
            action(GetPostedDocumentLinesToReverse)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Suite;
                CaptionML = ENG = 'Get SalesLines', FRA = 'Extraire lignes';
                Ellipsis = true;
                Image = ReverseLines;
                Enabled = Rec.Status <> Rec.Status::Released;
                trigger OnAction()
                begin
                    ExtractWhseLine();
                end;
            }
        }


    }
    procedure ExtractWhseLine()
    var
        lSalesLine: Record "Sales Line";
        lwhseList: page "WDC Sales Extract Lines";
        lWarehouseShipmentLine: record "Warehouse Shipment Line";
    begin
        Clear(SalesExtractLine);
        SalesReceivablesSetup.Get();
        ShipDate := CalcDate(SalesReceivablesSetup."Last Shipping Date Filter", WorkDate());
        lSalesLine.reset;
        lSalesLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
        lSalesLine.SetRange("Document Type", lSalesLine."Document Type"::Order);
        lSalesLine.SetRange(Type, lSalesLine.Type::Item);
        lSalesLine.SetFilter("Outstanding Quantity", '>%1', 0);
        lSalesLine.SetFilter("Shipment Date", '<%1', shipDate);
        lSalesLine.SetFilter("Location Code", '%1', rec."Location Code");
        lSalesLine.CalcFields(Status);
        lSalesLine.setrange("status", lSalesLine.status::Released);
        if lSalesLine.FindSet() then begin
            SalesExtractLine.SetTableView(lSalesLine);
            SalesExtractLine.SetDocumentNO(rec."No.");
            SalesExtractLine.SetLocationCode(rec."Location Code");
            SalesExtractLine.LOOKUPMODE(TRUE);
            IF SalesExtractLine.RUNMODAL = ACTION::LookupOK then;
        end;
    end;

    var
        WhseNo: code[20];
        SalesExtractLine: page "WDC Sales Extract Lines";
        RemainingQty: decimal;

        ShipDate: Date;
        SalesReceivablesSetup: record "Sales & Receivables Setup";
}
