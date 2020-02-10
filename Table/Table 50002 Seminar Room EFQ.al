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
            OptionMembers = "In-House","Off-Site";

            trigger OnValidate()
            begin
                Validate("Room Size");
            end;
        }

        field(20; "Room Name"; Text[50])
        {
            Caption = 'Room Name';

        }

        field(30; "Room Size"; Option)
        {
            Caption = 'Room Size';
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
                end
            end;
        }

        field(40; "Cost of Room"; Decimal)
        {
            Caption = 'Cost of Room';
        }

        field(90; "Over Maximum Participant"; Integer)
        {
            Caption = 'Over Maximum Participants';
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
        fieldgroup(DropDown; "Room ID", "Room Name", "Room Size", "Room Type", "Cost of Room", "Over Maximum Participant")
        { }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarSetup: Record "Seminar Setup";
        IsInHouse: Boolean;

    trigger OnInsert()
    begin
        SeminarSetup.FindLast();
        "Room ID" := NoSeriesMgt.GetNextNo(SeminarSetup."Seminar Room ID No. Series", 0D, true);

    end;

    procedure AssignRoomCost(RoomTypeSelected: Option; RoomCost: Decimal);
    begin
        if RoomTypeSelected = "Room Type"::"In-House" then
            "Cost of Room" := 0.00
        else
            "Cost of Room" := RoomCost
    end;
}
