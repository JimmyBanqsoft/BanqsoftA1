page 50015 "Seminar Instructor Factbox"
{
    Caption = 'Seminar Instructor Factbox';
    PageType = CardPart;
    SourceTable = "Seminar Instructor";

    layout
    {
        area(Content)
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