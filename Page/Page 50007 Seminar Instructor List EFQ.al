page 50007 "Seminar Instructor List"
{
    ApplicationArea = All;
    Caption = 'Seminar Instructor List';
    CardPageId = 50008;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "Seminar Instructor";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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