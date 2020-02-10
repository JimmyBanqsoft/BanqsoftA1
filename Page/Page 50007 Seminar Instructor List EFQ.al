page 50007 "Seminar Instructor List"
{
    Caption = 'Seminar Instructor List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Instructor";
    CardPageId = 50008;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
            action(NewSeminarInstructor)
            {
                ApplicationArea = All;
                Caption = 'Create New Seminar Instructor';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunPageMode = Create;

                trigger OnAction();
                begin
                    SeminarIDManagement.InitSeminarInstructorID(true);
                end;
            }
        }
    }

    var
        SeminarIDManagement: Codeunit SeminarIDManagement;
}