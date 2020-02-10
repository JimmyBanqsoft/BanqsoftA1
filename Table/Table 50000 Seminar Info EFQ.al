table 50000 "Seminar Info"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Seminar ID", "Seminar Name";
    LookupPageId = "Seminar Info List";
    DrillDownPageId = "Seminar Info List";

    fields
    {
        field(1; "Seminar ID"; Code[20])
        {
            Caption = 'Seminar ID';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate();
            begin
                Validate("Seminar Name");
            end;
        }

        field(10; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(20; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(30; "Seminar Duration"; Duration)
        {
            Caption = 'Seminar Duration';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Seminar Duration" > 43200000 then
                    Error('Seminar Duration is too long to held in a day');
            end;
        }

        field(40; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
        }

        field(50; "Minimum Participants"; Integer)
        {
            MinValue = 1;
            InitValue = 1;
            Caption = 'Minimum Participants';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Maximum Participants" <> 0 then begin
                    Validate("Maximum Participants");
                end;
            end;
        }

        field(60; "Maximum Participants"; Integer)
        {
            MinValue = 1;
            InitValue = 1;
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Minimum Participants" <> 0 then begin
                    if "Minimum Participants" > "Maximum Participants" then
                        Error('Input of Maximum Participant cannot lower than Minimum Participant.')
                end;
            end;
        }
    }

    keys
    {
        key(PK; "Seminar ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Seminar ID", "Seminar Name", Description, "Seminar Price", "Seminar Duration")
        { }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarSetup: Record "Seminar Setup";

    trigger OnInsert()
    begin
        SeminarSetup.FindLast();
        "Seminar ID" := NoSeriesMgt.GetNextNo(SeminarSetup."Seminar Info ID No. Series", 0D, true);
    end;
}