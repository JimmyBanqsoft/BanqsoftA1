page 50017 "Seminar Reg Ppt List Part"
{
    AutoSplitKey = true;
    Caption = 'Registed Participant';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Seminar Reg Participant";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // Add tooltip for each field
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    Editable = IsStatusRegistration;
                }

                field(Name; Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = IsStatusRegistration;
                }

                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                    Editable = IsStatusRegistration;
                }

                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No';
                    Editable = IsStatusRegistration;
                }

                field(Billable; Billable)
                {
                    ApplicationArea = All;
                    Caption = 'Additional Charges';
                    Editable = CheckIfBillable;
                }

                field("Bill-To-Company"; "Bill-To-Company")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-To-Company';
                }
            }
        }
    }

    var
        CheckIfBillable: Boolean;
        IsStatusRegistration: Boolean;

    procedure GetCheckIfBillable(): Boolean
    begin
        exit(CheckIfBillable);
    end;

    trigger OnAfterGetRecord();
    var
        TScheduledSeminar: Record "Scheduled Seminar";
        TAddExp: Record "Seminar Additional Expenses";
        TRegPart: Record "Seminar Reg Participant";
    begin
        TScheduledSeminar.Get("Schedule Seminar ID");

        if TScheduledSeminar.Status = TScheduledSeminar.Status::Registration then
            IsStatusRegistration := true
        else
            IsStatusRegistration := false;

        if TScheduledSeminar.Status = TScheduledSeminar.Status::Ongoing then begin
            TAddExp.SetRange(TAddExp."Schedule Seminar ID", "Schedule Seminar ID");
            TRegPart.SetRange(TRegPart."Schedule Seminar ID", "Schedule Seminar ID");

            if TAddExp.FindSet() then begin
                repeat
                    if TAddExp."Bill-To-Customer" = true then
                        CheckIfBillable := true;
                until TAddExp.Next() = 0;
            end;
        end;
    end;
}