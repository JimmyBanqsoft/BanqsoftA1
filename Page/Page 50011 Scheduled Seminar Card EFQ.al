page 50011 "Scheduled Seminar Card"
{
    // 2020-01-15  LCY   Added new field to keep CustomerID.
    // 2020-01-13  LCY   Added the if-else to check if duplicate participant and if user want add more than the max participant. Add a process to switch status.
    // 2020-01-10  LCY   Added End time field.
    // 2020-01-09  LCY   Re-arrange Comment.
    // 2020-01-08  LCY   Add 3 factboxes into this card page. Add a action to add participant (Just a button process), yet to complete.
    // 2020-01-07  LCY   Created this page with some fields and page property.


    Caption = 'Scheduled Seminar Card';
    PageType = Card;
    SourceTable = "Scheduled Seminar";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(ID; ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field("Seminar ID"; "Seminar ID")
                {
                    Caption = 'Seminar ID';
                    ApplicationArea = All;
                }
                field("Room ID"; "Room ID")
                {
                    Caption = 'Room ID';
                    ApplicationArea = All;
                }
                field("Instructor ID"; "Instructor ID")
                {
                    Caption = 'Instructor ID';
                    ApplicationArea = All;
                }
                field("Seminar Date"; "Seminar Date")
                {
                    Caption = 'Seminar Date';
                    ApplicationArea = All;
                }
                field("Seminar Start Time"; "Seminar Start Time")
                {
                    Caption = 'Start Time';
                    ApplicationArea = All;
                }
                field("Seminar End Time"; "Seminar End Time")
                {
                    Caption = 'End Time';
                    ApplicationArea = All;
                }
                field("Minimum Participant"; "Minimum Participant")
                {
                    Caption = 'Minimum Participant';
                    ApplicationArea = All;
                }
                field("Maximum Participant"; "Maximum Participant")
                {
                    Caption = 'Maximum Participant';
                    ApplicationArea = All;
                }
                field("Total Registered Participants"; "Total Registered Participants")
                {
                    Caption = 'Total Reg. Participants';
                    ApplicationArea = All;
                }
            }

            part("Seminar Add Exp List Part"; "Seminar Add Exp List Part")
            {
                Caption = 'Seminar Additional Expenses';
                SubPageLink = "Schedule Seminar ID" = field (ID);
            }

            part("Seminar Reg Ppt List Part"; "Seminar Reg Ppt List Part")
            {
                Caption = 'Seminar Registered Participant';
                SubPageLink = "Schedule Seminar ID" = field (ID);
            }
        }

        area(FactBoxes)
        {
            part("Seminar Info Details"; "Seminar Info Factbox")
            {
                Caption = 'Seminar Info Details';
                SubPageLink = "Seminar ID" = field ("Seminar ID");
            }

            part("Seminar Room Details"; "Seminar Room Factbox")
            {
                Caption = 'Seminar Room Details';
                SubPageLink = "Room ID" = field ("Room ID");
            }
            part("Seminar Instructor Details"; "Seminar Instructor Factbox")
            {
                Caption = 'Seminar Instructor Details';
                SubPageLink = "ID" = field ("Instructor ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddParticipant)
            {
                Caption = 'Add Participant';
                ApplicationArea = All;
                Image = TaskList;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PartListPage: Page "Contact List";
                    TParticipant: Record Contact;
                    TRegPpt: Record "Seminar Reg Participant";
                    TSeminarRoom: Record "Seminar Room";
                    TCBR: Record "Contact Business Relation";

                    LineNo: Integer;
                    CountParticipant: Integer;
                    CustomerID: Code[20];
                begin
                    TParticipant.SetRange(TParticipant.Type, TParticipant.Type::Person);
                    TParticipant.SetFilter(TParticipant."Company No.", '<>%1', '');
                    PartListPage.SetTableView(TParticipant);
                    PartListPage.LookupMode(true);

                    if PartListPage.RunModal() = Action::LookupOK then begin
                        PartListPage.GetRecord(TParticipant);
                        PartListPage.SetSelectionFilter(TParticipant);
                        TSeminarRoom.Get("Room ID");
                        TRegPpt.SetRange(TRegPpt."Schedule Seminar ID", ID);

                        if TRegPpt.FindLast() then
                            LineNo := TRegPpt."Line No."
                        else
                            TRegPpt."Line No." := 0;

                        CountParticipant := TRegPpt.Count();

                        if TParticipant.FindSet() then
                            repeat
                                CountParticipant := CountParticipant + 1;
                                LineNo := LineNo + 1;

                                TRegPpt.Reset();
                                TRegPpt.SetRange(TRegPpt."Schedule Seminar ID", ID);
                                TRegPpt.SetRange(TRegPpt.ID, TParticipant."No.");
                                if TRegPpt.FindFirst() then
                                    Message('Participant has registered before.')
                                else begin
                                    if CountParticipant > "Maximum Participant" then
                                        if CountParticipant <= TSeminarRoom."Over Maximum Participant" then
                                            if Dialog.Confirm('Are you sure you want to add more than the max capacity?', true) then begin
                                                "Total Registered Participants" := CountParticipant;
                                                TRegPpt.Init();
                                                TRegPpt."Schedule Seminar ID" := ID;
                                                TRegPpt."Line No." := LineNo;
                                                TRegPpt.ID := TParticipant."No.";
                                                TRegPpt.Name := TParticipant.Name;
                                                TRegPpt.CompanyNo := TParticipant."Company No.";
                                                TRegPpt."E-Mail" := TParticipant."E-Mail";
                                                TRegPpt."Phone No." := TParticipant."Phone No.";
                                                TRegPpt.Insert(true);
                                            end
                                            else
                                                exit
                                        else
                                            Message('No more slot to register more participant.')
                                    else begin
                                        // TODO: Convert to one procedure.....
                                        "Total Registered Participants" := CountParticipant;
                                        TRegPpt.Init();
                                        TRegPpt."Schedule Seminar ID" := ID;
                                        TRegPpt."Line No." := LineNo;
                                        TRegPpt.ID := TParticipant."No.";
                                        TRegPpt.Name := TParticipant.Name;
                                        TRegPpt."E-Mail" := TParticipant."E-Mail";
                                        TRegPpt."Phone No." := TParticipant."Phone No.";
                                        TRegPpt.CompanyNo := TParticipant."Company No.";

                                        Clear(TCBR);
                                        TCBR.Reset();
                                        TCBR.SetCurrentKey(TCBR."Link to Table", TCBR."Contact No.");
                                        TCBR.SetRange("Link to Table", TCBR."Link to Table"::Customer);
                                        TCBR.SetRange(TCBR."Contact No.", TParticipant."Company No.");

                                        if TCBR.FindFirst() then
                                            CustomerID := TCBR."No.";

                                        TRegPpt.CustomerID := CustomerID;
                                        TRegPpt.Insert(true);
                                    end;
                                end;
                            until TParticipant.Next() = 0;
                    end;
                end;
            }

            action(Process)
            {
                ApplicationArea = All;
                Caption = 'Process';
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if "Seminar ID" <> '' then begin
                        if "Total Registered Participants" < "Minimum Participant" then begin
                            if Dialog.Confirm('Not enough participant to schedule this Seminar. Do you want to cancel this seminar?') then begin
                                Status := Status::Ongoing;
                                CurrPage.Update(true);
                                ShowScheduledSemCard(false);
                                CurrPage.Close();
                            end;
                        end
                        else begin
                            Status := Status::Confirm;
                            CurrPage.Update(true);
                            ShowScheduledSemCard(false);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
        }
    }
}