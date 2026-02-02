import { LightningElement, wire, track } from 'lwc';
import getMyOpenCases from '@salesforce/apex/MyOpenCasesController.getMyOpenCases';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Subject', fieldName: 'Subject' },
    {
        label: 'Status',
        fieldName: 'Status',
        editable: true
    },
    {
        label: 'Priority',
        fieldName: 'Priority',
        editable: true
    },
    { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' }
];

export default class MyOpenCases extends LightningElement 
{

    columns = COLUMNS;
    @track draftValues = [];
    cases;
    wiredResult;

    @wire(getMyOpenCases)
    wiredCases(result) 
    {
        this.wiredResult = result;
        if (result.data) 
        {
            this.cases = result.data;
        } 
        else if (result.error) 
        {
            this.showToast('Error', 'Failed to load cases', 'error');
        }
    }

    async handleSave(event) 
    {
        const records = event.detail.draftValues.map(draft => {
            return { fields: { ...draft } };
       });

        try 
        {
            await Promise.all(records.map(record => updateRecord(record)));

            this.showToast('Success', 'Cases updated successfully', 'success');

            this.draftValues = [];
            await refreshApex(this.wiredResult);

        } 
        catch (error) 
        {
            this.showToast('Error', error.body.message, 'error');
        }
    }

    showToast(title, message, variant) 
    {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}
