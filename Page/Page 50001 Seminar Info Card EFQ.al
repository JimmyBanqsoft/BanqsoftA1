page 50001 "Seminar Info Card"
{
    Caption = 'Seminar Info Card';
    PageType = Card;
    SourceTable = "Seminar Info";
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;

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
    }
}