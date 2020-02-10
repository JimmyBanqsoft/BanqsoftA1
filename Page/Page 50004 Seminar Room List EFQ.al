page 50004 "Seminar Room List"
{
    // 2020-01-07  LCY   Created this Page with some fields.

    Caption = 'Seminar Room List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Room";
    CardPageId = 50005;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
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
    }

    actions
    {
        area(Processing)
        {
            action(NewSeminarRoom)
            {
                ApplicationArea = All;
                Caption = 'Create New Seminar Room';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunPageMode = Create;

                trigger OnAction();
                begin
                    SeminarIDManagement.InitSeminarRoomID(true);
                end;
            }
        }
    }

    var
        SeminarIDManagement: Codeunit SeminarIDManagement;

}