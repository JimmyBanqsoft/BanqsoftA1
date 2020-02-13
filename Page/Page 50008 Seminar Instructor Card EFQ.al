page 50008 "Seminar Instructor Card"
{
    Caption = 'Seminar Instructor Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Seminar Instructor";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                }

                field("Instructor Name"; "Instructor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Instructor Name';
                }

                field("Area of Expertise"; "Area of Expertise")
                {
                    ApplicationArea = All;
                    Caption = 'Area of Expertise';
                }
            }
        }
    }
}