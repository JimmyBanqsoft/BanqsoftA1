page 50001 "Seminar Info Card"
{
    Caption = 'Seminar Info Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Seminar Info";

    layout
    {
        area(Content)
        {
            group(General)
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
                    ShowMandatory = true;

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
}