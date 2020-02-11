page 50000 "Seminar Info List"
{
    Caption = 'Seminar Info List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Info";
    CardPageId = 50001;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
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

                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }

                field("Seminar Duration"; "Seminar Duration")
                {
                    Caption = 'Seminar Duration';
                    ApplicationArea = All;
                }

                field("Seminar Cost"; "Seminar Price")
                {
                    Caption = 'Seminar Cost';
                    ApplicationArea = All;
                }

                field("Minimum Participants"; "Minimum Participants")
                {
                    Caption = 'Minimum Participants';
                    ApplicationArea = All;
                }

                field("Maximum Participant"; "Maximum Participants")
                {
                    Caption = 'Maximum Participant';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewSeminarInfo)
            {
                ApplicationArea = All;
                Caption = 'Create New Seminar Info';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunPageMode = Create;

                trigger OnAction();
                begin
                    SeminarIDManagement.InitSeminarInfoID(true);
                end;
            }
        }
    }

    var
        SeminarIDManagement: Codeunit SeminarIDManagement;
}