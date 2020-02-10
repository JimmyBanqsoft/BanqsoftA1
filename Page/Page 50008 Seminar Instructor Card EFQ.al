page 50008 "Seminar Instructor Card"
{
    Caption = 'Seminar Instructor Card';
    PageType = Card;
    SourceTable = "Seminar Instructor";

    layout
    {
        area(Content)
        {
            group(GroupName)
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
    }

    actions
    {
    }
}