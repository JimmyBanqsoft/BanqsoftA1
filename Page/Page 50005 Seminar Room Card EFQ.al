page 50005 "Seminar Room Card"
{
    // 2020-01-07  LCY   Created this Page with some fields.

    Caption = 'Seminar Room Card';
    PageType = Card;
    SourceTable = "Seminar Room";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Room ID"; "Room ID")
                {
                    Caption = 'Room ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Room Type"; "Room Type")
                {
                    Caption = 'Room Type';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if "Room Type" = "Room Type"::"In-House" then
                            IsInHouse := false
                        else
                            IsInHouse := true;
                    end;

                }
                field("Room Name"; "Room Name")
                {
                    Caption = 'Room Name';
                    ApplicationArea = All;

                }
                field("Room Size"; "Room Size")
                {
                    Caption = 'Room Size';
                    ApplicationArea = All;

                }
                field("Cost of Room"; "Cost of Room")
                {
                    Caption = 'Cost of Room';
                    ApplicationArea = All;
                    Editable = IsInHouse;

                }
                field("Over Maximum Participant"; "Over Maximum Participant")
                {
                    Caption = 'Over Maximum Participant';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    var
        myInt: Integer;
        IsInHouse: Boolean;
}