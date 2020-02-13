page 50000 "Seminar Info List"
{
    ApplicationArea = All;
    Caption = 'Seminar Info List';
    CardPageId = 50001;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Seminar Info";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }

                field("Seminar Duration"; "Seminar Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Duration';
                }

                field("Seminar Price"; "Seminar Price")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Price';
                }

                field("Minimum Participants"; "Minimum Participants")
                {
                    ApplicationArea = All;
                    Caption = 'Minimum Participants';
                }

                field("Maximum Participant"; "Maximum Participants")
                {
                    ApplicationArea = All;
                    Caption = 'Maximum Participant';
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