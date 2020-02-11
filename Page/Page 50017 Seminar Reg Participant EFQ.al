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
                field(ID; ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                    Editable = IsStatusRegistration;
                }

                field(Name; Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    Editable = IsStatusRegistration;
                }

                field("E-Mail"; "E-Mail")
                {
                    Caption = 'E-Mail';
                    ApplicationArea = All;
                    Editable = IsStatusRegistration;
                }

                field("Phone No."; "Phone No.")
                {
                    Caption = 'Phone No';
                    ApplicationArea = All;
                    Editable = IsStatusRegistration;
                }
                field(Billable; Billable)
                {
                    Caption = 'Additional Charges';
                    ApplicationArea = All;
                    Editable = CheckIfBillable;
                }
                field("Bill-To-Company"; "Bill-To-Company")
                {
                    Caption = 'Bill-To-Company';
                    ApplicationArea = All;
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