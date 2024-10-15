report 50002 "Shipping List"
{
    RDLCLayout = './.vscode/src/Report/RDLC/ShippingList.rdlc';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    CaptionML = ENU = 'Shipping List ', FRA = 'Expédition entrepôt';

    dataset
    {
        dataitem(PostedWhseShpttHeader; "Posted Whse. Shipment Header")
        {
            RequestFilterFields = "No.";
            column(ColisageNo; "No.")
            {
            }
            column(date; "Posting Date")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAdr; CompanyInfo.Address)
            {

            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }

            column(Companytel; CompanyInfo."Phone No.")
            {

            }

            column(BanqueName; CompanyInfo."Bank Name")
            {

            }
            column(IBNA; CompanyInfo.IBAN)
            {
            }
            column(CodeFiscalCompany; CompanyInfo."VAT Registration No.")
            {
            }
            column(Registration_No_; CompanyInfo."Registration No.")
            {
            }

            column(NetWeight; PostedWhseShpttHeader."Net Weight")
            {
            }
            column(GrossWeight; PostedWhseShpttHeader."Gross Weight")
            {
            }
            column(num; NumLineNotEmpty)
            {

            }
            Column(PageNumber; PageNumber)
            {
            }

            dataitem("PostedWhseShipmentLine"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = field("NO.");
                DataItemLinkReference = PostedWhseShpttHeader;
                DataItemTableView = SORTING("No.", "Line No.");

                column(Article; "Item No.")
                {
                }
                column(Description; "Description")
                {
                }
                column(UM; "Unit of Measure Code")
                {
                }

                column(LineNo; "Line No.")
                {
                }
                column(destinataire; customer."Name")
                {
                }

                column(Address; customer."Address")
                {
                }
                column(country; country."Name")
                {
                }
                column(CF; customer."VAT Registration No.")
                {
                }
                column(Qty; "Quantity")
                {
                }
                column(PhoneNumber; customer."Phone No.")
                {
                }
                column(Qtytotal; Qty)
                {
                }
                column(Matricule; Matricule)
                {
                }

                // dataitem(comment; "Sales Comment Line")
                // {
                //     DataItemLink = "No." = field("Posted Source No."),
                //     "Document Line No." = field("Source Line No.");
                //     DataItemTableView = SORTING("No.", "Line No.");
                //     DataItemLinkReference = PostedWhseShipmentLine;

                // Column(CommentLine; Comment)
                // {
                // }
                // trigger OnAfterGetRecord()
                // begin

                //     if StrLen(Comment) >= 45 then
                //         NumLineNotEmpty += 2
                //     else
                //         NumLineNotEmpty += 1;

                //     PageNumber := ((NumLineNotEmpty - 1) div 30) + 1;

                // end;
                // }

                trigger OnAfterGetRecord()
                begin
                    if StrLen(Description) >= 45 then
                        NumLineNotEmpty += 2
                    else
                        NumLineNotEmpty += 1;
                    PageNumber := ((NumLineNotEmpty - 1) div 30) + 1;
                    // if ((PostedWhseShipmentLine."Destination No." <> '') and (PostedWhseShipmentLine."Destination Type" = PostedWhseShipmentLine."Destination Type"::Customer)) then
                    //     customer.get(PostedWhseShipmentLine."Destination No.");
                    salesheader.reset;
                    if salesheader.get(salesheader."Document Type"::Order, "Source No.") then begin
                        customer.get(salesheader."Sell-to Customer No.");
                        country.Get(customer."Country/Region Code");
                    end;
                    // Item.Get(PostedWhseShipmentLine."Item No.");
                    // pNetWeight += (Item."Net Weight" * PostedWhseShipmentLine."Quantity");
                    // pGrossWeight += (Item."Gross Weight" * PostedWhseShipmentLine."Quantity");
                    //Qty += Quantity;


                end;
            }

            dataitem(integer; integer)
            {
                DataItemTableView = SORTING(Number);

                Column(NumLineNotEmpty; NumLineNotEmpty + Number)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PageNumber := ((NumLineNotEmpty - 1) div 30) + 1;
                end;

                trigger OnPreDataItem()
                begin
                    if (((NumLineNotEmpty mod 30) < 27) and (NumLineNotEmpty mod 30 <> 0)) THEN
                        SETRANGE(Number, 1, 26 - (NumLineNotEmpty mod 30))
                    Else
                        SETRANGE(Number, 1, (30 - (NumLineNotEmpty mod 30)) mod 30);
                end;
            }

            trigger OnPreDataItem()
            begin
                // pNetWeight := 0;
                // pGrossWeight := 0;
                Qty := 0;
            end;

        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()

    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnInitReport()

    begin
        clear(NumLineNotEmpty);
    end;

    var
        CompanyInfo: record 79;
        customer: Record 18;
        salesheader: record 36;
        Item: record 27;
        //pNetWeight: decimal;
        //pGrossWeight: decimal;
        NumLineNotEmpty: Integer;
        PageNumber: Integer;
        Qty: Integer;
        country: record 9;

}
