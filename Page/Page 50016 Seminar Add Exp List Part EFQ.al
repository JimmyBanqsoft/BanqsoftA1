page 50016 "Seminar Add Exp List Part"
{
    AutoSplitKey = true;
    Caption = 'Seminar Additional Expenses';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Seminar Additional Expenses";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cost Type"; "Cost Type")
                {
                    Caption = 'Cost Type';
                    ApplicationArea = All;
                }

                field(Remark; Remark)
                {
                    Caption = 'Remark';
                    ApplicationArea = All;
                }

                field(Amount; Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }

                field("Bill-To-Customer"; "Bill-To-Customer")
                {
                    Caption = 'Bill-To-Customer';
                    ApplicationArea = All;
                }
            }
        }
    }
}