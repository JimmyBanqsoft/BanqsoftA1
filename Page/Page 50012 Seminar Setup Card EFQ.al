page 50012 "Seminar Setup"
{
    // All good
    ApplicationArea = Basic, Suite;
    Caption = 'Seminar Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Seminar Setup";
    UsageCategory = Administration;

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
                        ApplicationArea = All;
                        Caption = 'Seminar Info ID No. Series';
                        ToolTip = 'Specifies the types of No. Series of Seminar Info';
                    }

                    field("Seminar Info Description"; "Seminar Info Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        ToolTip = 'Description';
                    }
                }

                group("Seminar Room")
                {
                    Caption = 'Seminar Room';
                    field("Seminar Room ID No. Series"; "Seminar Room ID No. Series")
                    {
                        ApplicationArea = All;
                        Caption = 'Seminar Room ID No. Series';
                        ToolTip = 'Specifies the types of No. Series of Seminar Room';
                    }
                    field("Seminar Room Description"; "Seminar Room Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        ToolTip = 'Description';
                    }
                }

                group("Seminar Instructor")
                {
                    Caption = 'Seminar Instructor';
                    field("Seminar Instructor ID No. Series"; "Sem Instructor ID No. Series")
                    {
                        ApplicationArea = All;
                        Caption = 'Seminar Instructor ID No. Series';
                        ToolTip = 'Specifies the types of No. Series of Seminar Instructor';
                    }
                    field("Sem Instructor Description"; "Sem Instructor Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        ToolTip = 'Description';
                    }
                }

                group("Scheduled Seminar")
                {
                    Caption = 'Scheduled Seminar';
                    field("Scehduled Sem ID No. Series"; "Scehduled Sem ID No. Series")
                    {
                        ApplicationArea = All;
                        Caption = 'Scehduled Seminar ID No. Series';
                        ToolTip = 'Specifies the types of No. Series of Scheduled Seminar';
                    }
                    field("Scehduled Sem Description"; "Scehduled Sem Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        ToolTip = 'Description';
                    }

                }

            }
            group(Posting)
            {
                Caption = 'Posting';
                // TODO: need to add field on Table first.

            }

            group(STPM)
            {
                Caption = 'STPM Setup';
                // TODO: need to add field on Table first.

            }
        }
    }

    trigger OnOpenPage();
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;
}