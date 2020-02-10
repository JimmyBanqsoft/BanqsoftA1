page 50012 "Seminar Setup"
{
    Caption = 'Seminar Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Setup";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Seminar Info")
                {
                    Caption = 'Seminar Info';
                    field("Seminar Info ID No. Series"; "Seminar Info ID No. Series")
                    {
                        Caption = 'Seminar Info ID No. Series';
                        ApplicationArea = All;

                    }

                    field("Seminar Info Description"; "Seminar Info Description")
                    {
                        Caption = 'Description';
                        ApplicationArea = All;
                    }
                }

                group("Seminar Room")
                {
                    Caption = 'Seminar Room';
                    field("Seminar Room ID No. Series"; "Seminar Room ID No. Series")
                    {
                        Caption = 'Seminar Room ID No. Series';
                        ApplicationArea = All;

                    }
                    field("Seminar Room Description"; "Seminar Room Description")
                    {
                        Caption = 'Description';
                        ApplicationArea = All;
                    }
                }

                group("Seminar Instructor")
                {
                    Caption = 'Seminar Instructor';

                    field("Seminar Instructor ID No. Series"; "Sem Instructor ID No. Series")
                    {
                        Caption = 'Seminar Instructor ID No. Series';
                        ApplicationArea = All;

                    }
                    field("Sem Instructor Description"; "Sem Instructor Description")
                    {
                        Caption = 'Description';
                        ApplicationArea = All;
                    }
                }

                group("Scheduled Seminar")
                {
                    Caption = 'Scheduled Seminar';

                    field("Scehduled Sem ID No. Series"; "Scehduled Sem ID No. Series")
                    {
                        Caption = 'Scehduled Seminar ID No. Series';
                        ApplicationArea = All;

                    }
                    field("Scehduled Sem Description"; "Scehduled Sem Description")
                    {
                        Caption = 'Description';
                        ApplicationArea = All;

                    }

                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;
}