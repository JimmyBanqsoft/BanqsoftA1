page 50010 "Scheduled Seminar List"
{
    Caption = 'Scheduled Seminar List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Scheduled Seminar";
    CardPageId = 50011;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        ShowScheduledSemCard(false);
                    end;
                }
                field("Seminar ID"; "Seminar ID")
                {
                    Caption = 'Seminar ID';
                    ApplicationArea = All;
                }
                field("Seminar Name"; "Seminar Name")
                {
                    Caption = 'Seminar Name';
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field("Room ID"; "Room ID")
                {
                    Caption = 'Room ID';
                    ApplicationArea = All;
                }
                field("Instructor ID"; "Instructor ID")
                {
                    Caption = 'Instructor ID';
                    ApplicationArea = All;
                }
                field("Seminar Date"; "Seminar Date")
                {
                    Caption = 'Seminar Date';
                    ApplicationArea = All;
                }
                field("Seminar Start Time"; "Seminar Start Time")
                {
                    Caption = 'Start Time';
                    ApplicationArea = All;
                }
                field("Seminar End Time"; "Seminar End Time")
                {
                    Caption = 'End Time';
                    ApplicationArea = All;
                }
                field("Maximum Participant"; "Maximum Participant")
                {
                    Caption = 'Maximum Participant';
                    ApplicationArea = All;
                }
                field("Total Registered Participants"; "Total Registered Participants")
                {
                    Caption = 'Total Reg. Participants';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ParticipantRegForSeminar)
            {
                ApplicationArea = All;
                Caption = 'New Participant Seminar Registration';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunPageMode = Create;

                trigger OnAction()
                begin
                    SeminarIDManagement.InitScheduledSeminarID(true);
                end;
            }
        }
    }

    var
        SeminarIDManagement: Codeunit SeminarIDManagement;
}