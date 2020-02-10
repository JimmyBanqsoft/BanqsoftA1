page 50001 "Seminar Info Card"
{
    // 2020-01-23  LCY   Rename some fields.
    // 2020-01-09  LCY   Re-arrange Comment. Major Changes
    // 2020-01-07  LCY   Added ApplicationArea to all fields.
    // 2020-01-06  LCY   Re-design Table and Fields, then addon Trigger functions. Then created List & Card Pages for some Table.


    Caption = 'Seminar Info Card';
    PageType = Card;
    SourceTable = "Seminar Info";

    layout
    {
        area(Content)
        {
            group(General)
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
                    ShowMandatory = true;

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
                field("Seminar Price"; "Seminar Price")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}