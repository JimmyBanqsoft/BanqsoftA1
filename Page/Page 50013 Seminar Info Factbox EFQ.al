page 50013 "Seminar Info Factbox"
{
    // 2020-01-08  LCY   Created this CardPart page to used as Factbox

    Caption = 'Seminar Info Factbox';
    PageType = CardPart;
    SourceTable = "Seminar Info";

    layout
    {
        area(Content)
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
            field("Seminar Price"; "Seminar Price")
            {
                Caption = 'Seminar Price';
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

    actions
    {
    }
}