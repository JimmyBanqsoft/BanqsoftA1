page 50018 "Scheduled Seminar Card Confirm"
{
    Caption = 'Scheduled Seminar Card';
    Editable = false;
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
                }

                field("Room ID"; "Room ID")
                {
                    ApplicationArea = All;
                    Caption = 'Room ID';
                }

                field("Instructor ID"; "Instructor ID")
                {
                    ApplicationArea = All;
                    Caption = 'Instructor ID';
                }

                field("Seminar Date"; "Seminar Date")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Date';
                }

                field("Seminar Start Time"; "Seminar Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Start Time';
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
                    if Dialog.Confirm('Is Seminar Starting?') then begin
                        Status := Status::Ongoing;
                        CurrPage.Update(true);
                        ShowScheduledSemCard(false);
                        CurrPage.Close();
                    end;
                end;
            }

            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    SmtpMail: Codeunit "SMTP Mail";
                    SmtpMailSetup: Record "SMTP Mail Setup";
                    TRegPart: Record "Seminar Reg Participant";
                    TSeminarInfo: Record "Seminar Info";
                    LblMailSubject: Label 'Seminar %1';
                    LblMailBody: Label '<h1>Hi %1,</h1><br> The Seminar <u><b>%2</b></u> that you registered is <u><b>%3</b></u>.<br>The Seminar is on <u><b>%4</b></u> which is from <b>%5</b> to <b>%6</b>.<br> <h3>Thank You!</h3>';
                    MailSubject: Text;
                    MailBody: Text;
                    SenderName: Text;
                    SenderAddress: Text;
                    Recipient: Text;
                begin
                    TRegPart.Reset();
                    TRegPart.SetFilter(TRegPart."Schedule Seminar ID", '%1', ID);
                    TSeminarInfo.Get("Seminar ID");
                    SmtpMailSetup.Get();

                    if TRegPart.FindSet() then begin
                        repeat
                            MailSubject := StrSubstNo(LblMailSubject, TSeminarInfo."Seminar Name");
                            MailBody := StrSubstNo(LblMailBody, TRegPart.Name, TSeminarInfo."Seminar Name", Status, "Seminar Date", "Seminar Start Time", "Seminar End Time");
                            SenderName := 'Seminar Management';
                            SenderAddress := Format(SmtpMailSetup."User ID");
                            Recipient := Format(TRegPart."E-Mail");
                            SmtpMail.CreateMessage(SenderName, SenderAddress, Recipient, MailSubject, MailBody, true);
                            SmtpMail.Send();
                        until TRegPart.Next() = 0;
                        Message('Email Sent!');
                    end;
                end;
            }
        }
    }
}