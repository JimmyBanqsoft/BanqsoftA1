page 50014 "Seminar Room Factbox"
{
    Caption = 'Seminar Room Factbox';
    PageType = CardPart;
    SourceTable = "Seminar Room";

    layout
    {
        area(Content)
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

            }
            field("Over Maximum Participant"; "Over Maximum Participant")
            {
                Caption = 'Over Maximum Participant';
                ApplicationArea = All;

            }
        }
    }

    actions
    {
    }
}