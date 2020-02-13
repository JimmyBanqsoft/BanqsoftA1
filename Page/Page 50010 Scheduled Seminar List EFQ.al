page 50010 "Scheduled Seminar List"
{
    ApplicationArea = All;
    Caption = 'Scheduled Seminar List';
    CardPageId = 50011;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Scheduled Seminar";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID';

                    trigger OnDrillDown();
                    begin
                        ShowScheduledSemCard(false);
                    end;
                }

                field("Seminar ID"; "Seminar ID")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar ID';
                }

                field("Seminar Name"; "Seminar Name")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Name';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }

                field("Room ID"; "Room ID")
                {
                    ApplicationArea = All;
                    Caption = 'Room ID';
                }

                field("Instructor ID"; "Instructor ID")
                {
                    ApplicationArea = All;
                    Caption = 'Instructor ID';
                }

                field("Seminar Date"; "Seminar Date")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Date';
                }

                field("Seminar Start Time"; "Seminar Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Start Time';
                }

                field("Seminar End Time"; "Seminar End Time")
                {
                    ApplicationArea = All;
                    Caption = 'End Time';
                }

                field("Maximum Participant"; "Maximum Participant")
                {
                    ApplicationArea = All;
                    Caption = 'Maximum Participant';
                }

                field("Total Registered Participants"; "Total Registered Participants")
                {
                    ApplicationArea = All;
                    Caption = 'Total Reg. Participants';
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