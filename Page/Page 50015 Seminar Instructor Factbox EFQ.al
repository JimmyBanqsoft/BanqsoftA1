page 50015 "Seminar Instructor Factbox"
{
    // 2020-01-08  LCY   Created this CardPart page to used as Factbox

    Caption = 'Seminar Instructor Factbox';
    PageType = CardPart;
    SourceTable = "Seminar Instructor";

    layout
    {
        area(Content)
        {
            field(ID; ID)
            {
                Caption = '';
                ApplicationArea = All;

            }
            field("Instructor Name"; "Instructor Name")
            {
                Caption = '';
                ApplicationArea = All;

            }
            field("Area of Expertise"; "Area of Expertise")
            {
                Caption = '';
                ApplicationArea = All;

            }
        }
    }

    actions
    {
    }
}