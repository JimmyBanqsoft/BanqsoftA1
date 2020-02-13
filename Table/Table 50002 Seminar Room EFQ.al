table 50002 "Seminar Room"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Room ID", "Room Name";
    LookupPageId = "Seminar Room List";
    DrillDownPageId = "Seminar Room List";

    fields
    {
        field(1; "Room ID"; Code[20])
        {
            Caption = 'Room ID';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Room Type"; Option)
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            OptionMembers = "In-House","Off-Site";

            trigger OnValidate()
            begin
                Validate("Room Size");
            end;
        }

        field(20; "Room Name"; Text[50])
        {
            Caption = 'Room Name';
            DataClassification = CustomerContent;
        }

        field(30; "Room Size"; Option)
        {
            Caption = 'Room Size';
            DataClassification = CustomerContent;
            OptionMembers = "Small","Medium","Large";
            OptionCaption = 'Small, Medium, Large';

            trigger OnValidate();
            begin
                case "Room Size" of
                    "Room Size"::"Small":
                        begin
                            AssignRoomCost("Room Type", 1000);
                        end;
                    "Room Size"::"Medium":
                        begin
                            AssignRoomCost("Room Type", 2000);
                        end;
                    "Room Size"::"Large":
                        begin
                            AssignRoomCost("Room Type", 3000);
                        end;
                end;
            end;
        }

        field(40; "Cost of Room"; Decimal)
        {
            Caption = 'Cost of Room';
            DataClassification = CustomerContent;
        }

        field(90; "Allocated Maximum Participant"; Integer)
        {
            Caption = 'Allocated Maximum Participants';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Room ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Room ID", "Room Name", "Room Size", "Room Type", "Cost of Room", "Allocated Maximum Participant")
        { }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarSetup: Record "Seminar Setup";
        IsInHouse: Boolean;

    trigger OnInsert()
    begin
        if "Room ID" = '' then begin
            SeminarSetup.Reset();
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Room ID No. Series");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Room ID No. Series", '', 0D, "Room ID", SeminarSetup."Seminar Room ID No. Series");
        end;
    end;

    procedure AssignRoomCost(RoomTypeSelected: Option; RoomCost: Decimal);
    begin
        case RoomTypeSelected of
            "Room Type"::"In-House":
                begin
                    "Cost of Room" := 0.00;
                end;
            "Room Type"::"Off-Site":
                begin
                    "Cost of Room" := RoomCost;
                end;
            else begin
                    Error('Not such selection existed!');
                end;
        end;
    end;
}
