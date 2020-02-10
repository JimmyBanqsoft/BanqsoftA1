report 50000 ListParticipant
{
    RDLCLayout = 'layouts/ListParticipant.rdl';
    WordLayout = 'layouts/ListParticipant.docx';
    PreviewMode = Normal;
    WordMergeDataItem = "Scheduled Seminar";
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Scheduled Seminar"; "Scheduled Seminar")
        {
            column(ScheduledSeminarID; ID)
            {
                IncludeCaption = true;
            }
            column(Seminar_Name; "Seminar Name")
            {
                IncludeCaption = true;
            }

            dataitem("Seminar Reg Participant"; "Seminar Reg Participant")
            {
                DataItemLink = "Schedule Seminar ID" = field (ID);
                column(ContactID; ID)
                {
                    IncludeCaption = true;
                }
                column(ContactName; Name)
                {
                    IncludeCaption = true;
                }
                column(ContactEmail; "E-mail")
                {
                    IncludeCaption = true;
                }
                column(ContactPhone; "Phone No.")
                {
                    IncludeCaption = true;
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(SchSemID; SchSemID)
                    {
                        TableRelation = "Scheduled Seminar";
                    }
                }
            }
        }

        actions
        {
        }
    }

    var
        myInt: Integer;
        SchSemID: Code[20];
        ScheduledSeminar: Record "Scheduled Seminar";
}