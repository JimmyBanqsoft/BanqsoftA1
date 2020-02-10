page 50008 "Seminar Instructor Card"
{
    // 2020-01-07  LCY   Created this page with some fields.
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
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}