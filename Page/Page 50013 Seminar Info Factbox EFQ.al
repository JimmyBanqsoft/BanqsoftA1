page 50013 "Seminar Info Factbox"
{
    Caption = 'Seminar Info Factbox';
    PageType = CardPart;
    SourceTable = "Seminar Info";

    layout
    {
        area(Content)
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