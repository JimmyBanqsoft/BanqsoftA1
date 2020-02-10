table 50001 "Seminar Additional Expenses"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Schedule Seminar ID"; Code[20])
        {
            Caption = 'Schedule Seminar ID';
            Editable = false;
            TableRelation = "Scheduled Seminar".ID;
        }

        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }

        field(20; "Cost Type"; Option)
        {
            Caption = 'Cost Type';
            OptionMembers = "Catering Expenses","Equipment Rental";
            OptionCaption = 'Catering Expenses, Equipment Rental';
        }

        field(21; Remark; Text[50])
        {
            Caption = 'Remark';

        }

        field(30; Amount; Decimal)
        {
            Caption = 'Amount';
        }

        field(40; "Bill-To-Customer"; Boolean)
        {
            Caption = 'Bill-To-Customer';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Schedule Seminar ID", "Line No.")
        {
            Clustered = true;
        }
    }
}