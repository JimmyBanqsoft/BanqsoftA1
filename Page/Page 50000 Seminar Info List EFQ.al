page 50000 "Seminar Info List"
{
    // 2020-01-09  LCY   Re-arrange Comment. Major Changes.
    // 2020-01-07  LCY   Added an action to generate auto-filled ID.
    // 2020-01-06  LCY   Re-design Table and Fields, then addon Trigger functions. Then created List & Card Pages for some Table.


    Caption = 'Seminar Info List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Info";
    CardPageId = 50001;
    Editable = false;

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
        area(Factboxes)
        {

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