page 50005 "Seminar Room Card"
{
    Caption = 'Seminar Room Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Seminar Room";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Room ID"; "Room ID")
                {
                    ApplicationArea = All;
                    Caption = 'Room ID';
                    Editable = false;
                }

                field("Room Type"; "Room Type")
                {
                    ApplicationArea = All;
                    Caption = 'Room Type';

                    trigger OnValidate();
                    begin
                        if "Room Type" = "Room Type"::"In-House" then
                            IsInHouse := false
                        else
                            IsInHouse := true;
                    end;
                }

                field("Room Name"; "Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Room Name';
                }

                field("Room Size"; "Room Size")
                {
                    ApplicationArea = All;
                    Caption = 'Room Size';
                }

                field("Cost of Room"; "Cost of Room")
                {
                    ApplicationArea = All;
                    Caption = 'Cost of Room';
                    Editable = IsInHouse;
                }

                field("Allocated Maximum Participant"; "Allocated Maximum Participant")
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Maximum Participant';
                }
            }
        }
    }
    var
        IsInHouse: Boolean;
}