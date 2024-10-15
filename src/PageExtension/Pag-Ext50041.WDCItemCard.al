namespace Sogrega.Sogrega;

using Microsoft.Inventory.Item;

pageextension 50041 "WDC Item Card" extends "Item Card"

{
    layout
    {

        modify("Description 2")
        {
            Visible = true;
        }
        addlast(Replenishment_Production)
        {
            field("Production Moule Date"; Rec."Production Moule Date")
            {
                ApplicationArea = all;
            }
            field("Technical Description"; Rec."Technical Description")
            {
                ApplicationArea = all;
                MultiLine = true;
            }
        }

    }
}
