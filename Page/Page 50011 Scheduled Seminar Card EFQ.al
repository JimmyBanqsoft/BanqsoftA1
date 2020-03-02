page 50011 "Scheduled Seminar Card"
{
    Caption = 'Scheduled Seminar Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Scheduled Seminar";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                }
                field("Seminar ID"; "Seminar ID")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar ID';
                    ShowMandatory = true;
                }
                field("Room ID"; "Room ID")
                {
                    ApplicationArea = All;
                    Caption = 'Room ID';
                    ShowMandatory = true;
                }
                field("Instructor ID"; "Instructor ID")
                {
                    ApplicationArea = All;
                    Caption = 'Instructor ID';
                    ShowMandatory = true;
                }
                field("Seminar Date"; "Seminar Date")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Date';
                    ShowMandatory = true;
                }
                field("Seminar Start Time"; "Seminar Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Start Time';
                    ShowMandatory = true;
                }
                field("Seminar End Time"; "Seminar End Time")
                {
                    ApplicationArea = All;
                    Caption = 'End Time';
                }
                field("Minimum Participant"; "Minimum Participant")
                {
                    ApplicationArea = All;
                    Caption = 'Minimum Participant';
                }
                field("Maximum Participant"; "Maximum Participant")
                {
                    ApplicationArea = All;
                    Caption = 'Maximum Participant';
                }
                field("Total Registered Participants"; "Total Registered Participants")
                {
                    ApplicationArea = All;
                    Caption = 'Total Reg. Participants';
                }
            }

            part("Seminar Add Exp List Part"; "Seminar Add Exp List Part")
            {
                Caption = 'Seminar Additional Expenses';
                SubPageLink = "Schedule Seminar ID" = field(ID);
            }

            part("Seminar Reg Ppt List Part"; "Seminar Reg Ppt List Part")
            {
                Caption = 'Seminar Registered Participant';
                SubPageLink = "Schedule Seminar ID" = field(ID);
            }
        }

        area(FactBoxes)
        {
            part("Seminar Info Details"; "Seminar Info Factbox")
            {
                Caption = 'Seminar Info Details';
                SubPageLink = "Seminar ID" = field("Seminar ID");
            }

            part("Seminar Room Details"; "Seminar Room Factbox")
            {
                Caption = 'Seminar Room Details';
                SubPageLink = "Room ID" = field("Room ID");
            }
            part("Seminar Instructor Details"; "Seminar Instructor Factbox")
            {
                Caption = 'Seminar Instructor Details';
                SubPageLink = "ID" = field("Instructor ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddParticipant)
            {
                ApplicationArea = All;
                Caption = 'Add Participant';
                Image = TaskList;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LineNo: Integer;
                    CountParticipant: Integer;
                    CustomerID: Code[20];
                    PartListPage: Page "Contact List";
                    TCBR: Record "Contact Business Relation";
                    TParticipant: Record Contact;
                    TRegPpt: Record "Seminar Reg Participant";
                    TSeminarRoom: Record "Seminar Room";
                begin
                    TParticipant.SetRange(TParticipant.Type, TParticipant.Type::Person);
                    TParticipant.SetFilter(TParticipant."Company No.", '<>%1', '');
                    PartListPage.SetTableView(TParticipant);
                    PartListPage.LookupMode(true);

                    if PartListPage.RunModal() = Action::LookupOK then begin
                        PartListPage.GetRecord(TParticipant);
                        PartListPage.SetSelectionFilter(TParticipant);

                        TRegPpt.SetRange(TRegPpt."Schedule Seminar ID", ID);
                        if TRegPpt.FindLast() then
                            LineNo := TRegPpt."Line No."
                        else
                            TRegPpt."Line No." := 0;

                        CountParticipant := TRegPpt.Count();

                        TSeminarRoom.Get("Room ID");

                        if TParticipant.FindSet() then
                            repeat
                                CountParticipant := CountParticipant + 1;
                                LineNo := LineNo + 10000;

                                TRegPpt.Reset();
                                TRegPpt.SetRange(TRegPpt."Schedule Seminar ID", ID);
                                TRegPpt.SetRange(TRegPpt.ID, TParticipant."No.");
                                if TRegPpt.FindFirst() then
                                    Message('Participant has been registered.')
                                else begin
                                    if CountParticipant > "Maximum Participant" then begin
                                        if CountParticipant <= TSeminarRoom."Allocated Maximum Participant" then begin
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
                                        end
                                        else
                                            Message('No more slot to register more participant.')
                                    end
                                    else begin
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
                    if (("Seminar ID" <> '') and ("Room ID" <> '') and ("Instructor ID" <> '') and ("Seminar Date" <> 0D) and ("Seminar Start Time" <> 0T)) then begin
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
                    end
                    else
                        Error('You have not fill in all the required fields yet!');
                end;
            }
        }
    }
}