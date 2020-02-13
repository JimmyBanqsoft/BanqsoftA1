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
                ApplicationArea = All;
                Caption = 'Room ID';
                Editable = false;
            }

            field("Room Type"; "Room Type")
            {
                ApplicationArea = All;
                Caption = 'Room Type';
            }

            field("Room Name"; "Room Name")
            {
                ApplicationArea = All;
                Caption = 'Room Name';
            }

            field("Room Size"; "Room Size")
            {
                ApplicationArea = All;
                Caption = 'Room Size';
            }

            field("Cost of Room"; "Cost of Room")
            {
                ApplicationArea = All;
                Caption = 'Cost of Room';
            }

            field("Allocated Maximum Participant"; "Allocated Maximum Participant")
            {
                ApplicationArea = All;
                Caption = 'Allocated Maximum Participant';
            }
        }
    }
}