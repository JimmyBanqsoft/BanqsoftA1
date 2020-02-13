page 50004 "Seminar Room List"
{
    ApplicationArea = All;
    Caption = 'Seminar Room List';
    CardPageId = 50005;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Seminar Room";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
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